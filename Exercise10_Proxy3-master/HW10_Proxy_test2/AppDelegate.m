//
//  AppDelegate.m
//  HW10_Proxy_test2
//
//  Created by Uri Fuholichev on 8/4/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //после старта приложения мы проверяем, есть ли в User Defaults эта переменная и если нет, то задаем значение буллевой переменной на YES, чтобы при текущем запуске отыграла реклама

    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"first_launch_during_execution"])
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first_launch_during_execution"];
    else
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first_launch_during_execution"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //при уходе в бэкграунд мы меняем значение буллевой величины на YES, так как рассматриваем предположение о том, что из бэкграунда приложение затем будет  закончено. Таким образом, при следующем запуске приложения, при запросе в User Defaults мы получим занчение YES, отыграет реклама и значение будет изменено на NO
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first_launch_during_execution"];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // на случай, если из бэкграунда пользователь все же вернется обратно в фореграунд, мы обратно меняем знаечние буллевой переменной на NO, чтобы не показывать заново рекламу, которая и так была показана при первом запуске
    NSLog(@"The app has already been launched, no adv");
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"first_launch_during_execution"];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
