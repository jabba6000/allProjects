//
//  MyObject.m
//  HW10_Proxy_test2
//
//  Created by Uri Fuholichev on 8/4/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "MyObject.h"

@implementation MyObject

-(void) callOnceDuringAppLife{
    NSLog(@"It's a very first launch of this app ever");
}

-(void) callOnceDuringExecution{
    NSLog(@"App was launched!");
}

@end
