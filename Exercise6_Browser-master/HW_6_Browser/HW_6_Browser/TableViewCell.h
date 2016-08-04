//
//  TableViewCell.h
//  HW_6_Browser
//
//  Created by Uri Fuholichev on 5/28/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "myVCTwo.h"

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *myLabelOnCell;

@property (strong, nonatomic) IBOutlet UILabel *labelOnCell;

@end
