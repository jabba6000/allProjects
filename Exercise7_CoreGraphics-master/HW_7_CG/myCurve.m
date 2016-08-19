//
//  myCurve.m
//  HW_7_CG
//
//  Created by Uri Fuholichev on 6/1/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "myCurve.h"

@implementation myCurve


- (void)drawRect:(CGRect)rect {
    
    //получаем количество точек из массива
    int numberOfPoints = [_pointsToDraw count];
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);

    CGPoint takeMeBack;

    //цикл перебирает точки внутри массива и отрисовывает их на графике
    for(int counter=0; counter!= numberOfPoints; counter++)
    {
        takeMeBack = [[_pointsToDraw objectAtIndex:counter ] CGPointValue];
        if(counter ==0)
        {
            CGContextMoveToPoint(context, takeMeBack.x, takeMeBack.y);
        }
        else
            CGContextAddLineToPoint(context, takeMeBack.x, takeMeBack.y);
    }
    CGContextStrokePath(context);
}

@end
