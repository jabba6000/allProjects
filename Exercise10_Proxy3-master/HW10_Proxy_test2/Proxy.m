//
//  Proxy.m
//  HW10_Proxy_test2
//
//  Created by Uri Fuholichev on 8/4/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "Proxy.h"

@implementation Proxy

-(BOOL)checkIfTheFirstLaunchEver{
    /*проверяет в словаре UserDefaults, есть ли там значение "первый запуск"
     и поступает соответствующе, возвращая буллевую величину
     */
    
    object = [MyObject new];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"first_launch_ever"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"first_launch_ever"];
        [object callOnceDuringAppLife];
        return YES;
    }
    if ((BOOL)[[NSUserDefaults standardUserDefaults] boolForKey:@"first_launch_ever"]==NO)
    {
        return NO;
    }
    if ((BOOL)[[NSUserDefaults standardUserDefaults] boolForKey:@"first_launch_ever"]==YES)
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"first_launch_ever"];
        [object callOnceDuringAppLife];
        return YES;
    }
    
    return nil;
    
}
-(BOOL)checkIfTheFirstLaunchDuringExecution{
    
    object = [MyObject new];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"first_launch_during_execution"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"first_launch_during_execution"];
        [object callOnceDuringExecution];
        return YES;
    }
    if ((BOOL)[[NSUserDefaults standardUserDefaults] boolForKey:@"first_launch_during_execution"]==YES)
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"first_launch_during_execution"];
        [object callOnceDuringExecution];
        return YES;
    }
    else
        return NO;
}

@end
