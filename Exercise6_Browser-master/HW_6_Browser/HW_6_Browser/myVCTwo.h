//
//  myVCTwo.h
//  HW_6_Browser
//
//  Created by Uri Fuholichev on 5/27/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"

@interface myVCTwo : UIViewController <UISearchBarDelegate, UITextFieldDelegate, UITextInputTraits>

@property (strong, nonatomic) NSMutableArray *arrayWithURLs;
@property(strong, nonatomic) NSMutableArray *filteredStrings;

@property (strong, nonatomic) UITableView *myTableView;

@property (strong, nonatomic) IBOutlet UISearchBar *mySearchBar;

@end
