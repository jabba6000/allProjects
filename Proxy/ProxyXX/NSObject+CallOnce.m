//
//  NSObject+CallOnce.m
//  ProxyXX
//
//  Created by Uri Fuholichev on 8/21/16.
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

@end
