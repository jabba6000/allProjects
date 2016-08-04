//
//  ViewController.m
//  HW2test4
//
//  Created by Uri Fuholichev on 4/8/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//через эти свойства доступ к объектам, содержащим Data Source
@property (strong, nonatomic) NamesDS *name;
@property (strong, nonatomic) SocialDS *social;
@property (strong, nonatomic) AboutDS *about;

@end

@implementation ViewController{
    int nextScreen;
    int prevScreen;
    BOOL firstLaunch;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //создаем объекты наших катсомных классов
    NamesDS *myNames  = [[NamesDS alloc ]init];
    SocialDS *mySocial = [[SocialDS alloc] init];
    AboutDS *myAbout = [[AboutDS alloc] init];

    //выполняем привязку объектов к пропертям
    _name = myNames;
    _social = mySocial;
    _about = myAbout;
    
    //вот это вот вставили, чтобы соединить с ксибой, ксиба здесь - шаблон ячейки
    UINib *nib = [UINib nibWithNibName:@"myCell" bundle:nil];
    [self.myTableView registerNib:nib forCellReuseIdentifier:@"CellOne"];
    
    self.myTableView.dataSource = self.name;
    [self.myTableView reloadData];
  
    firstLaunch = YES;
    NSLog(@"Next screen is %i", nextScreen);
}

/*
 name = 0
 social = 1
 about = 2
*/


- (IBAction)PrevButton:(id)sender {
    
    if (firstLaunch)
    {
        prevScreen = 2;
        firstLaunch = NO;
    }
    
    switch (prevScreen) {
        case 0:
            [self saveSocial];
            self.myTableView.dataSource = self.name;
            [self.myTableView reloadData];
            prevScreen = 2;
            nextScreen = 1;
            NSLog(@"Next screen is %i and prevScreen is %i", nextScreen, prevScreen);
            break;
        case 1:
            [self saveAbout];
            self.myTableView.dataSource = self.social;
            [self.myTableView reloadData];
            prevScreen = 0;
            nextScreen = 2;
            NSLog(@"Next screen is %i and prevScreen is %i", nextScreen, prevScreen);
            break;
        case 2:
            [self saveNames];
            self.myTableView.dataSource = self.about;
            [self.myTableView reloadData];
            prevScreen = 1;
            nextScreen = 0;
            NSLog(@"Next screen is %i and prevScreen is %i", nextScreen, prevScreen);
            break;
    }
}

- (IBAction)NextButton:(id)sender {
    
    if(firstLaunch)
    {
        nextScreen++;
        firstLaunch = NO;
    }
    
    switch (nextScreen) {
        case 0:
            [self saveAbout];
            self.myTableView.dataSource = self.name;
            [self.myTableView reloadData];
            nextScreen=1;
            prevScreen = 2;
            NSLog(@"Next screen is %i and prevScreen is %i", nextScreen, prevScreen);
            break;
        case 1:
            [self saveNames];
            self.myTableView.dataSource = self.social;
            [self.myTableView reloadData];
            nextScreen=2;
            prevScreen = 0;
            NSLog(@"Next screen is %i and prevScreen is %i", nextScreen, prevScreen);
            break;
        case 2:
            [self saveSocial];
            self.myTableView.dataSource = self.about;
            [self.myTableView reloadData];
            nextScreen=0;
            prevScreen = 1;
            NSLog(@"Next screen is %i and prevScreen is %i", nextScreen, prevScreen);
            break;
    }
}

-(void)saveNames{
        
    //сначала создаем две пустые ячейки
    myCell *sFirstName = [myCell new];
    myCell *sSecondName= [myCell new];
    
    //подключаем словарь User Defaults
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    //Через цикл перебираем все элементы массива, в который мы при создании ячеек в соответсвтующих таблицах добавили копии этих ячеек.
    //Как видно здесь, мы присваиваем созданным в этом методе ячейкам значения ячеек из массива.
    for (int i = 0; i < [_name.arrayForCellsNames count];i++)
    {
        sFirstName = [_name.arrayForCellsNames objectAtIndex:0];
        sSecondName = [_name.arrayForCellsNames objectAtIndex:1];
    }
    
    //строкам мы присваиваем содержимое ТекстФиелд из ячеек, которые были в массиве
    NSString    *fName = sFirstName.textFieldOnCell.text;
    NSString    *sName = sSecondName.textFieldOnCell.text;
    
    //Теперь мы сохраняем поулченные строки внутри словаря USer Defaults и присваиваем им ключи для вызова
    [defaults setObject:fName forKey:@"firstName"];
    [defaults setObject:sName forKey:@"secondName"];
}

/////Метод для сохранения данных со второго экрана в UserDefaults
-(void)saveSocial{
    
    myCell *socialOne = [myCell new];
    myCell *socialTwo= [myCell new];
    myCell *socialThreee= [myCell new];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    for (int i = 0;i < [_social.arrayForCellsSocial count];i++)
    {
        socialOne = [_social.arrayForCellsSocial objectAtIndex:0];
        socialTwo = [_social.arrayForCellsSocial objectAtIndex:1];
        socialThreee = [_social.arrayForCellsSocial objectAtIndex:2];
    }
    
    NSString    *soc1 = socialOne.textFieldOnCell.text;
    NSString    *soc2 = socialTwo.textFieldOnCell.text;
    NSString    *soc3 = socialThreee.textFieldOnCell.text;
    
    [defaults setObject:soc1 forKey:@"HomeNumber"];
    [defaults setObject:soc2 forKey:@"MobileNumber"];
    [defaults setObject:soc3 forKey:@"Skype"];
    
}

//////Метод для сохранения данных с третьего экрана в UserDefaults
-(void)saveAbout{
    
    myCell *about = [myCell new];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
    about = [_about.arrayForCellsAbout objectAtIndex:0];
    
    NSString    *about1 = about.textFieldOnCell.text;
    
    [defaults setObject:about1 forKey:@"About"];
    [defaults synchronize];
    
}

@end
