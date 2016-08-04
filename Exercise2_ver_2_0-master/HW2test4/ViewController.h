//
//  ViewController.h
//  HW2test4
//
//  Created by Uri Fuholichev on 4/8/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NamesDS.h"
#import "SocialDS.h"
#import "AboutDS.h"

#import "myCell.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)PrevButton:(id)sender;
- (IBAction)NextButton:(id)sender;

-(void)saveNames;
-(void)saveSocial;
-(void)saveAbout;

@end

