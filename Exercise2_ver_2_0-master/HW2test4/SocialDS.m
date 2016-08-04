//
//  SocialDS.m
//  HW2test4
//
//  Created by Uri Fuholichev on 4/8/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "SocialDS.h"

@interface SocialDS ()

@property (copy, nonatomic) NSMutableArray   *arrayWithLabelsSocial;

@end

@implementation SocialDS

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if(!_arrayForCellsSocial){
        _arrayForCellsSocial = [[NSMutableArray alloc] init];
        NSLog(@"Array for Social Cells was created");
    }
    
    myCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellOne" forIndexPath:indexPath ];
    [_arrayForCellsSocial addObject:cell];
    
    
    if (indexPath.row == 0)
        cell.textFieldOnCell.text = [defaults objectForKey:@"HomeNumber"];
    if (indexPath.row == 1)
        cell.textFieldOnCell.text = [defaults objectForKey:@"MobileNumber"];
    if (indexPath.row == 2)
        cell.textFieldOnCell.text = [defaults objectForKey:@"Skype"];
    
    
    self.arrayWithLabelsSocial = @[@"Home Number", @"Mobile Number", @"Skype"];
    cell.labelOnCell.text = self.arrayWithLabelsSocial[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Social";
}


@end
