//
//  CustomVC.m
//  HW9CDTest3
//
//  Created by Uri Fuholichev on 7/20/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "CustomVC.h"
#import "AppDelegate.h"
#import "Storage.h"
#import "MyURLSession.h"

@interface CustomVC ()

@property (strong, atomic) MyURLSession *session;

@property(strong, nonatomic) DetailVC *myDetailVC;
@property(strong, nonatomic) NSMutableArray *resetArrayTitle;
@property(strong, nonatomic) NSMutableArray *resetArrayText;

@property (strong, atomic) NSMutableDictionary *dataFromURL;

@end


@implementation CustomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataFromURL = [NSMutableDictionary new];
    
    //создаем экземпляр MyURLSession (для получения Интернет-данных) и удерживаем его в свойстве (стронг)
    MyURLSession *mySession = [MyURLSession new];
    _session = mySession;
    
    self.myDetailVC = [DetailVC new];
    self.arrayForCoreData = [NSMutableArray new];
    self.resetArrayTitle = [NSMutableArray new];
    self.resetArrayText = [NSMutableArray new];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = [appDelegate managedObjectContext];
    
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription *storage = [NSEntityDescription entityForName:@"Storage" inManagedObjectContext:_managedObjectContext];
    
    [request setEntity:storage];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[_managedObjectContext executeFetchRequest:request error:&error ] mutableCopy];
    
    if (mutableFetchResults == nil){
        //handle error
    }
    
    self.arrayForCoreData=mutableFetchResults;
    NSLog(@"There are %lu in the array", [_arrayForCoreData count]);
}

-(void)viewWillAppear{
    //эта обновляет значения тайтлов в таблице после их редактирования в DetailVC
    [self.myTableView reloadData];
}

-(void)getCoreDataArrayFromOrigin{
    
    //данный метод вызывает в массив значения из базы CoreData
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = [appDelegate managedObjectContext];
    
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription *storage = [NSEntityDescription entityForName:@"Storage" inManagedObjectContext:_managedObjectContext];
    
    [request setEntity:storage];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[_managedObjectContext executeFetchRequest:request error:&error ] mutableCopy];
    
    if (mutableFetchResults == nil){
        //handle error
    }

    self.arrayForCoreData=mutableFetchResults;
}


#pragma mark - TableView Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return (NSInteger)[self.arrayForCoreData count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    Storage *storage = [self.arrayForCoreData objectAtIndex:indexPath.row];
    cell.textLabel.text = storage.title;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Здесь мы обеспечиваем переход на второй экран по нажатию на ячейку
    
    /*
     Сначала мы берем и делаем VC из того, что есть в сториБорде.
     Затем определяем для него делегата - self, то есть CustomVC
     Затем по номеру выделенной ячейки берем объект из массива, который передадим в  DetailVC
     Наконец вызываем переход на DetailVC
     */
    
    self.myDetailVC = [self.storyboard
                       instantiateViewControllerWithIdentifier:@"Detail"];
    
    self.myDetailVC.delegate = self;
    
    self.myDetailVC.storage = [self.arrayForCoreData objectAtIndex:indexPath.row];

    [self.navigationController pushViewController:self.myDetailVC animated:YES];
}

#pragma mark - Action Buttons

- (IBAction)newTitleBtn:(UIButton *)sender {
    [self createNewContext];
    [self.myTableView reloadData];
}

- (IBAction)resetBtn:(UIButton *)sender {
    
    /*
     ИСПРВАЛЕНО!!!!
     Кнопка reset вызывает данные с сервера, наполняет ими базу Core Data 
     и сохраняет изменения
     НО! есть баг: с первого нажатия кнопка только удаляет те данные, что есть 
     в базе в данный момент. После второго нажатия она наконец подгружает в базу 
     данные с сайта и обновляет значения в таблице. не исправлено
     */
    
    //опустошим массивы, заново объявив их
    _resetArrayText = [NSMutableArray new];
    _resetArrayTitle = [NSMutableArray new];
    
    // подгрузим инфу с сайта, загрузив ее в словарь _dataFromURL
    //Отключено выполнение в главном потоке
//    dispatch_async (dispatch_get_main_queue(), ^{
    
        _dataFromURL = [_session getDataFromURL];

//    });
    
    //наполним массивы данными, полученными с сайта
    _resetArrayTitle = [_dataFromURL objectForKey:@"TitleArray"];
    _resetArrayText = [_dataFromURL objectForKey:@"TextArray"];
    
    //Теперь очистим Core Data базу и массив с объектами, один за другим
    
    int i = [_arrayForCoreData count];
    int x;
    
    for (x=0; x!=i; x++)
    {
        NSManagedObject *objectToDelete = [_arrayForCoreData objectAtIndex:x];
        [_managedObjectContext deleteObject:objectToDelete];
        
        NSError *error = nil;
        if(![_managedObjectContext save:&error]){
        }
    }

    [_arrayForCoreData removeAllObjects];
    
    // затем наполним новыми подгруженными объектами
    
    int index = 0;
    
    for(NSString *str in _resetArrayTitle)
    {
        Storage *storage1 = [NSEntityDescription insertNewObjectForEntityForName:@"Storage" inManagedObjectContext:_managedObjectContext];
        
        storage1.title = str;
        storage1.text = [_resetArrayText objectAtIndex:index];
        
        [self.arrayForCoreData addObject:storage1];
        
        index++;
    }
    
    index=0;
    
    //И СОХРАНЯЕМ ТУТ ЖЕ (УБРАЛИ СОХРАНЕНИЕ)
//    NSError *error = nil;
//    if(![_managedObjectContext save:&error]){
//        
//    }
    
    [_myTableView reloadData];
    
    [_resetArrayText removeAllObjects];
    [_resetArrayTitle removeAllObjects];
    
}

-(void)createNewContext{
    /*
     Данный метод создает экземпляр хранилища, открывает контекст для него
     и кидает экземпляр с открытым контекстом внутрь массива
     */
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = [appDelegate managedObjectContext];
    
    Storage *storage1 = [NSEntityDescription insertNewObjectForEntityForName:@"Storage" inManagedObjectContext:_managedObjectContext];
    
    storage1.title = @"New title";
    storage1.text = @"Type your text here";
    
    [self.arrayForCoreData addObject:storage1];
}

- (IBAction)saveContextBtn:(UIButton *)sender {
    
    /*
     В данном методе перебераются все объекты внутри массива, 
     все они добавляются в контекст, им присваивает отредактиваронное пользователем значение,
     затем происходит сохрание контектса с изменениями в базу Core Data
     */
    
    for(Storage *storage in self.arrayForCoreData)
    {
        _storage = [NSEntityDescription insertNewObjectForEntityForName:@"Storage" inManagedObjectContext:_managedObjectContext];
        
        _storage.title = storage.title;
        _storage.text = storage.text;
        
        //ЭТО СОХРАНЯЕТ ЗНАЧЕНИЕ КОНТЕКСТА в базу Core Data
        NSError *error = nil;
        if(![_managedObjectContext save:&error]){
            
        }
    }
    
    [self removeDublicates];
    
    [self getCoreDataArrayFromOrigin];
    
    [_myTableView reloadData];
}

-(void)removeDublicates{
    
    /*
     имеется неисправленный баг: после нажатия на кнопку сохранения в базу Core Data 
     отправляется 2 копии файлов из массива. Поэтому данный цикл пробегает по всему массиву 
     и удаляет из базы по одному соответствующему объекту. На выходе получается так, словно
     кнопка "сохранить" отправляет в базу только одну копию объектов из массива.
     */
    
    int i = [_arrayForCoreData count];
    int x;
    
    for (x=0; x!=i; x++)
        {
            NSManagedObject *objectToDelete = [_arrayForCoreData objectAtIndex:x];
            [_managedObjectContext deleteObject:objectToDelete];
            NSError *error = nil;
            if(![_managedObjectContext save:&error]){
                
            }
        }
}


#pragma mark - extra methods

- (void)addItemViewController:(DetailVC *)controller didFinishEnteringItem:(Storage *)item
{
    /*
     Данный метод сначала вычисляет номер выделенной ячейки,
     Затем принимает из DetailVC объект и вставляет его в массив вместо того, что был раньше.
     В финале reloadData, чтобы отобразить изменения в таблице
     */
    
    NSIndexPath *selectedIndexPath = [self.myTableView indexPathForSelectedRow];
    
    [self.arrayForCoreData replaceObjectAtIndex:selectedIndexPath.row withObject:item];
    
    [self.myTableView reloadData];
    
}

//добавим возможность редактировать ячейки и базу соответственно
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *objectToDelete = [_arrayForCoreData objectAtIndex:indexPath.row];
        [_managedObjectContext deleteObject:objectToDelete];
        
        [_arrayForCoreData removeObjectAtIndex:indexPath.row];
        [ tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES ];
        
        NSError *error = nil;
        if(![_managedObjectContext save:&error]){
            
        }
    }
}


@end
