//
//  AppDelegate.h
//  HW_Ex5_CA_Test_1
//
//  Created by Uri Fuholichev on 5/24/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myVC.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navController;    //we've added this

@property (strong, nonatomic) myVC  *homeViewController;

@end

