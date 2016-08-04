//
//  MyThread.h
//  HW8_testX
//
//  Created by Uri Fuholichev on 8/1/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyThread : NSThread

/*
 Данный класс создается для того, чтобы у оригинального NSThread появилось свойство 
 threadIsAlive, что даст возможность контролировать жизнь отдельных потоков, не краша их
 все одним ударом кнопки
 */

@property (atomic) BOOL threadIsAlive;

@end
