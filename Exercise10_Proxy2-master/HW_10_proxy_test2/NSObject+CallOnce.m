//
//  NSObject+CallOnce.m
//  HW_10_proxy_test2
//
//  Created by Uri Fuholichev on 8/3/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "NSObject+CallOnce.h"
#import "CallOnceProxy.h"

@implementation NSObject (CallOnce)

-(instancetype) callOnceDuringExecuting {
    CallOnceProxy *proxy = [CallOnceProxy new];
    proxy.receiver = self;
    return (id)proxy;
}

-(instancetype) callOnceDuringAppLife {
    CallOnceProxy *proxy = [CallOnceProxy new];
    proxy.receiver = self;
    return (id)proxy;
}

@end
