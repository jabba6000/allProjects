//
//  NamesDS.m
//  HW2test4
//
//  Created by Uri Fuholichev on 4/8/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "NamesDS.h"

@interface NamesDS()

@property (copy, nonatomic) NSMutableArray   *arrayWithLabelsNames;

@end

@implementation NamesDS

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    if (!_arrayForCellsNames){
        _arrayForCellsNames = [[NSMutableArray alloc] init];
        NSLog(@"Array for Names Cells was created");
    }
    
    myCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellOne" forIndexPath:indexPath];
    [_arrayForCellsNames addObject:cell];
    
    
//здесь происходит присваивание ТекстФиелдам значений, которые ранее уже были сохранены в User Defaults
//на всякий случай мы добавили проверку на то, есть ли соотвествующее по ключу значение в USer Defaults
    if (indexPath.row==0){
        if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"firstName"]){
            cell.textFieldOnCell.text = [defaults objectForKey:@"firstName"];
        }
    }
    if (indexPath.row==1){
        if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"firstName"]){
            cell.textFieldOnCell.text = [defaults objectForKey:@"secondName"];
        }
    }
    
    self.arrayWithLabelsNames = @[@"First Name", @"Second Name"];
    cell.labelOnCell.text = self.arrayWithLabelsNames[indexPath.row];
  
    return cell;
}

//задаем Тайтл для секции
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Names";
}

@end
