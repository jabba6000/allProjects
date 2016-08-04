//
//  CenterVC.m
//  hw3t1
//
//  Created by Uri Fuholichev on 7/30/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "CenterVC.h"

@implementation CenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    CGRect  myRect = CGRectMake(0, 0, 300, 100);
    UILabel *Label1 = [[UILabel alloc] initWithFrame:myRect];
    Label1.text = _labelString;
    Label1.textAlignment = NSTextAlignmentCenter;
    Label1.font = [UIFont fontWithName:@"Chalkduster" size:36];
    Label1.textColor = [UIColor whiteColor];
    [Label1 setCenter:self.view.center];
    [self.view addSubview:Label1];
    
 }

@end
