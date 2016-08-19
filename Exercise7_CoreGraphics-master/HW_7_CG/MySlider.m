//
//  MySlider.m
//  HW_7_CG
//
//  Created by Uri Fuholichev on 8/19/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "MySlider.h"

@implementation MySlider

-(void)rotateSliderAndSetItsValues{
        
    //это чтобы повернуть слайдер на 90 градусов
    self.transform = CGAffineTransformMakeRotation(M_PI_2);
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI_2);
    self.transform =trans;
    
    //задаем величины слайдера
    self.minimumValue = 1.0;
    self.maximumValue = 10.0;
    self.continuous = YES;
    self.value = 5.0;
}



@end
