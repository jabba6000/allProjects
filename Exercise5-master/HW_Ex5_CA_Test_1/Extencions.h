//
//  Extencions.h
//  HW_Ex5_CA_Test_1
//
//  Created by Uri Fuholichev on 5/25/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//данный класс предназначен для получения случайного цвета и случайной точки

@interface Extencions : NSObject

-(CGPoint)getRandomPoint;

-(UIColor *)getRandomColor;

@end
