//
//  Proxy.h
//  HW10_Proxy_test2
//
//  Created by Uri Fuholichev on 8/4/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyObject.h"

@interface Proxy : NSObject
{
    MyObject *object;
}

-(BOOL)checkIfTheFirstLaunchEver;
-(BOOL)checkIfTheFirstLaunchDuringExecution;

@end
