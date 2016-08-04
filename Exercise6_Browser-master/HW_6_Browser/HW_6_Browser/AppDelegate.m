//
//  AppDelegate.m
//  HW_6_Browser
//
//  Created by Uri Fuholichev on 5/27/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "AppDelegate.h"
#import "myVC.h"
#import "myVCTwo.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [  [UIWindow alloc] initWithFrame:[ [UIScreen mainScreen]bounds] ];
    [self.window makeKeyAndVisible];
    
    self.tabBarController = [[UITabBarController alloc] init];
    
    //создали 2 Вью Контроллера
    myVC* vc1 = [[myVC alloc] init];
    myVCTwo* vc2 = [[myVCTwo alloc] init];
    
    //поместили созданные Вью Контроллеры в массив
    NSArray* controllers = [NSArray arrayWithObjects:vc1, vc2, nil];
    self.tabBarController.viewControllers = controllers;
    
    //делаем Таб Бар Контроллер рутовым вью Контроллером на окне
    self.window.rootViewController = self.tabBarController;
    
    //допиливаем картинки-итемы для табов
    UIImage* anImage1 = [UIImage imageNamed:@"Blog-30.png"];
    UITabBarItem* theItem1 = [[UITabBarItem alloc] initWithTitle:@"Active" image:anImage1 tag:0];

    UIImage* anImage2 = [UIImage imageNamed:@"Einstein-30.png"];
    UITabBarItem* theItem2 = [[UITabBarItem alloc] initWithTitle:@"History" image:anImage2 tag:0];
    
    vc1.tabBarItem = theItem1;
    vc2.tabBarItem = theItem2;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
