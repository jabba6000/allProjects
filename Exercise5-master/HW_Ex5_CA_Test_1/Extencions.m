//
//  Extencions.m
//  HW_Ex5_CA_Test_1
//
//  Created by Uri Fuholichev on 5/25/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "Extencions.h"

@implementation Extencions

-(CGPoint)getRandomPoint{
    
    CGPoint  myPoint = CGPointMake((26 + arc4random() % (339 - 26)), 26 + arc4random() % (391 - 26));
    return myPoint;
}


-(UIColor *)getRandomColor{
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}




@end
