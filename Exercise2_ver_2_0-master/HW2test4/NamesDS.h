//
//  NamesDS.h
//  HW2test4
//
//  Created by Uri Fuholichev on 4/8/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myCell.h"

@interface NamesDS : UITableView
<UITableViewDelegate, UITableViewDataSource>

@property (copy, nonatomic) NSMutableArray   *arrayForCellsNames;

@end
