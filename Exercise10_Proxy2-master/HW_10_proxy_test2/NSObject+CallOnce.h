//
//  NSObject+CallOnce.h
//  HW_10_proxy_test2
//
//  Created by Uri Fuholichev on 8/3/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CallOnce)

-(instancetype) callOnceDuringExecuting;
-(instancetype) callOnceDuringAppLife;

@end
