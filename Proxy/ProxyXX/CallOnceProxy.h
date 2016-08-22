//
//  CallOnceProxy.h
//  ProxyXX
//
//  Created by Uri Fuholichev on 8/21/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallOnceProxy : NSObject

@property (strong, nonatomic) NSObject *receiver;

+(void)callOnceMethod:(SEL)method ofObject:(id)object;

@end
