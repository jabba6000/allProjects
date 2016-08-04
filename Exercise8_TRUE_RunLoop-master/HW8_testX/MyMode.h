//
//  MyMode.h
//  HW8_testX
//
//  Created by Uri Fuholichev on 8/1/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMode : NSObject

/*
 Данный класс создается для того, чтобы иметь режим как отдельный объект со свойством
 modeIsRunning, что даст возможность контролировать жизнь отдельных режимов, не краша их
 все одним ударом кнопки
 */

@property (atomic) BOOL modeIsRunning;
@property (strong, atomic) NSString *modeName;

@end
