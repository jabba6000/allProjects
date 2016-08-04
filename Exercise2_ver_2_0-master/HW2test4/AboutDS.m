//
//  AboutDS.m
//  HW2test4
//
//  Created by Uri Fuholichev on 4/8/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "AboutDS.h"

@implementation AboutDS

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    
    if (!_arrayForCellsAbout){
        _arrayForCellsAbout = [[NSMutableArray alloc] init];
        NSLog(@"Array for About Cells was created");
    }
    
    myCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellOne" forIndexPath:indexPath];
    [_arrayForCellsAbout addObject:cell];
 
    
    if (indexPath.row==0)
        cell.textFieldOnCell.text = [defaults objectForKey:@"About"];
    
    cell.labelOnCell.text = @"Life Status";
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"About";
}


@end
