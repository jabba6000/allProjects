//
//  MyThreadController.m
//  HW8_testX
//
//  Created by Uri Fuholichev on 8/2/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "MyThreadController.h"


// Данный класс контролирует жизненный цикл потока

@implementation MyThreadController
{
    MyThread *thread;
}

// Метод создает экземпляр потока MyThread и запускает для него РанЛууп. Метод также принимает имя
// name. Пока флаг threadISAlive равно YES ранлууп продолжает крутиться для данного потока
-(MyThread *)startThreadWithName: (NSString *)name
{
    thread =[[MyThread alloc] initWithTarget:self selector:@selector(startRunLoop) object:nil];
    thread.name = name;
    [thread start];
    
    return thread;
}

-(void)startRunLoop{
    
    thread.threadIsAlive = YES;
    
    CFRunLoopAddCommonMode( [[NSRunLoop currentRunLoop] getCFRunLoop], CFSTR( "Background Mode" ) );
    [[NSMachPort port] scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:@"Background Mode"];
    [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:@"Background Mode"];
    
    //следующие 3 строки: создаем строку с сообщением и через delegate передаем ее на ViewController
    NSString *string1 = [NSString stringWithFormat:@"Thread %@ was started\n", [[NSThread currentThread] name]];
    NSLog(string1);
    [self.delegate addItemModule:self didFinishEnteringItem:string1];
    
    while (thread.threadIsAlive)
    {
        [[NSRunLoop currentRunLoop] runMode:@"Background Mode" beforeDate:[NSDate distantFuture]];
    }
    
    //здесть тоже string2 передаем через делегат на viewController
    NSString *string2 = [NSString stringWithFormat:@"Thread %@ was removed\n", [[NSThread currentThread] name]];
    NSLog(string2);
    [self.delegate addItemModule:self didFinishEnteringItem:string2];
}

@end
