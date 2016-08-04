//
//  AppDelegate.h
//  HW_6_Browser
//
//  Created by Uri Fuholichev on 5/27/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//В AppDelegate создадим логику для ТабБаров
@property (strong, nonatomic) UITabBarController   *tabBarController;

@end

