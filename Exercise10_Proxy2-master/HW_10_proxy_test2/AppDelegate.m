//
//  AppDelegate.m
//  HW_10_proxy_test2
//
//  Created by Uri Fuholichev on 8/3/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "AppDelegate.h"
#import "NSObject+CallOnce.h"
#import "CallOnceProxy.h"

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
    NSLog(@"From background");

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // на случай, если из бэкграунда пользователь все же вернется обратно в фореграунд, мы обратно меняем знаечние буллевой переменной на NO, чтобы не показывать заново рекламу, которая и так была показана при первом запуске
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"first_launch_during_execution"];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //Этот метод вызывается, когда мы приходим обратно из бэкграунда, таким образом, мы проверяем состояние буллевой величины в User Defaults и, прочитав ее видим, что приложение уже было запущено, таким образом не показываем по новой рекламу, как показывали ее при первом запуске
    
    NSObject *myObject = [NSObject new];
    
    if([(CallOnceProxy *)[myObject callOnceDuringExecuting] checkIfTheFirstLaunchDuringExecutiong]==YES)
        NSLog(@"It's the first launch during this session");
    else
        NSLog(@"It's not the first launch during this session");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    //этот метод применим в случае, если приложение бутет по какой-то причине убито во время нахождения в бэкраунде, но это не наш случай
}

@end
