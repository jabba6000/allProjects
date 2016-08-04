//
//  MyThreadController.h
//  HW8_testX
//
//  Created by Uri Fuholichev on 8/2/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyThread.h"

//на этот протокол пришлось подписать класс, чтобы иметь возможность выводить
// в логТекстВью сообщения, которые приходят из него при создании и уничтожении потока
@class MyThreadController;

@protocol MyThreadControllerDelegate <NSObject>
- (void)addItemModule:(MyThreadController *)controller didFinishEnteringItem:(NSString *)item;
@end

@interface MyThreadController : NSObject

@property (atomic, strong) id <MyThreadControllerDelegate> delegate;

-(MyThread *)startThreadWithName: (NSString *)name;

@end
