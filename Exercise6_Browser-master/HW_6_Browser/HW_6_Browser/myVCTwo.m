//
//  myVCTwo.m
//  HW_6_Browser
//
//  Created by Uri Fuholichev on 5/27/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "myVCTwo.h"


@interface myVCTwo () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation myVCTwo{
    
    BOOL isFiltered;
    NSString *filePath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     Здесь такая запара: в Таблице посещенных сайтов можно без проблем осуществлять переход и удаление элементов массива, где содержатся строки с URL. Но, когда таблица преобразуется при осуществлении поиска, удаление ее ячеек приводит к удалению соотвествующих элементов из массива (все как должно быть), НО! сама таблица с результатами поиска не преобразовывается после удаления элемента, массив для результатов поиска держит в себе ОДИН объект, если его удалить программно, приложение падает. РЕШЕНИЕ НЕ НАЙДЕНО! можно дезактивировать возможность удаления из результатов поиска
    */
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    //создали путь на компе, куда сохраняем массив
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = @"/FileWithArray.txt";
    filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    //заполнили масссив
    self.arrayWithURLs = [NSMutableArray arrayWithContentsOfFile:filePath];
    NSLog(@"Array has %lu objects", (unsigned long)[self.arrayWithURLs count]);
    
    self.myTableView.allowsMultipleSelectionDuringEditing = NO;

    //ДОБАВЛЯЕМ СЕРЧ БАР
    _mySearchBar.delegate = self;
    _mySearchBar.autocorrectionType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:_mySearchBar];
    
    //ДОБАВЛЯЕМ ТЭЙБЛ ВЬЮ
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width- 40, 560)];
    _myTableView.backgroundColor = [UIColor grayColor];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.layer.cornerRadius = 3;
    
    [self.view addSubview:_myTableView];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [_myTableView registerNib:nib forCellReuseIdentifier:@"ident"];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [_myTableView reloadData];
}

#pragma mark - SearchBar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length ==0)
        isFiltered = NO;
    else{
        isFiltered = YES;
        _filteredStrings = [NSMutableArray new];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
        _filteredStrings = [_arrayWithURLs filteredArrayUsingPredicate:predicate];
    }
    
    [_myTableView reloadData];
}

#pragma mark - TableVIew Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (isFiltered){
        return [_filteredStrings count];
    }
    else{
        self.arrayWithURLs = [NSMutableArray arrayWithContentsOfFile:filePath];
        return [self.arrayWithURLs count];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
     
     TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ident" forIndexPath:indexPath];
     
     if(isFiltered == YES)
         cell.labelOnCell.text = self.filteredStrings[indexPath.row];
     else if (isFiltered == NO)
         cell.labelOnCell.text = self.arrayWithURLs[indexPath.row];
     
     return cell;
 }


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSMutableString *adress = [NSMutableString new];
    
    if (isFiltered){
        adress = _filteredStrings[indexPath.row];
    }
    if (isFiltered == NO){
        adress = _arrayWithURLs[indexPath.row];
    }
    
    [defaults setObject:adress forKey:@"goToAdress"];
    
    NSLog(@"row was selected");
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       
        if (isFiltered == NO){
            [_arrayWithURLs removeObjectAtIndex:indexPath.row];

            [_arrayWithURLs writeToFile:filePath atomically:YES];
        }
        
        if (isFiltered == YES){
           
            NSMutableString *adress = [NSMutableString new];
            adress = _filteredStrings[indexPath.row];

            NSLog(@"Adress will be removed%@", adress);
            

            [_arrayWithURLs removeObjectIdenticalTo:adress];
            [_arrayWithURLs writeToFile:filePath atomically:YES];
            
            NSLog(@"filtered string array contains now %lu objects", (unsigned long)[_filteredStrings count]);
        }
        
        NSLog(@"Array after deleting has %lu objects", (unsigned long)[self.arrayWithURLs count]);

        [_myTableView reloadData];
    }
}



@end
