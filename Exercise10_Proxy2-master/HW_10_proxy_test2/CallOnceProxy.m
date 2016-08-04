//
//  CallOnceProxy.m
//  HW_10_proxy_test2
//
//  Created by Uri Fuholichev on 8/3/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "CallOnceProxy.h"

@implementation CallOnceProxy

-(BOOL)checkIfTheFirstLaunchEver{

    /*проверяет в словаре UserDefaults, есть ли там значение "первый запуск"
     и поступает соответствующе, возвращая буллевую величину
     */
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"first_launch_ever"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"first_launch_ever"];
        return YES;
    }
    if ((BOOL)[[NSUserDefaults standardUserDefaults] boolForKey:@"first_launch_ever"]==NO)
    {
        return NO;
    }
    if ((BOOL)[[NSUserDefaults standardUserDefaults] boolForKey:@"first_launch_ever"]==YES)
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"first_launch_ever"];
        return YES;
    }

    return nil;
}

-(BOOL)checkIfTheFirstLaunchDuringExecutiong{
 
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"first_launch_during_execution"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first_launch_during_execution"];
        return YES;
    }
    if ((BOOL)[[NSUserDefaults standardUserDefaults] boolForKey:@"first_launch_during_execution"]==YES)
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"first_launch_during_execution"];
        return YES;
    }
    if ((BOOL)[[NSUserDefaults standardUserDefaults] boolForKey:@"first_launch_during_execution"]==NO)
    {
        return NO;
    }
    return nil;
}

@end
