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

@interface CustomVC ()

@property(strong, nonatomic) DetailVC *myDetailVC;

@end

@implementation CustomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myDetailVC = [DetailVC new];
    self.arrayForCoreData = [NSMutableArray new];
    
    //посредством fetch request обращаемся к базе данных и вытягиваем из нее информацию в массив
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = [appDelegate managedObjectContext];
    
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription *storage = [NSEntityDescription entityForName:@"Storage" inManagedObjectContext:_managedObjectContext];
    
    [request setEntity:storage];
    
    //это сортировка, ее вообще можно убрать
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
//    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
//    [request setSortDescriptors:sortDescriptors];
    
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
    // и при последующем возвращении на главный экран
    [self.myTableView reloadData];
}

-(void)getCoreDataArrayFromOrigin{
    
    //данный метод вызывает в массив значения из базы CoreData
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = [appDelegate managedObjectContext];
    
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription *storage = [NSEntityDescription entityForName:@"Storage" inManagedObjectContext:_managedObjectContext];
    
    [request setEntity:storage];

    //опять же убираем алфавитную сортировку
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
//    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
//    [request setSortDescriptors:sortDescriptors];
    
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
     Затем определяем для него делегата - self, то есть CustomVC (для обмена данными между VC)
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
    
    //после сохранения удаляются дубликаты, заново подгружается инфа из базы и обновляется таблица
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
     В финале reloadData, чтобы отобразить изменения в таблице (данные при этом не сохранены еще)
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
