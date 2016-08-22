//
//  NSObject+CallOnce.h
//  ProxyXX
//
//  Created by Uri Fuholichev on 8/21/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CallOnce)

-(instancetype) callOnceDuringExecuting;

@end
