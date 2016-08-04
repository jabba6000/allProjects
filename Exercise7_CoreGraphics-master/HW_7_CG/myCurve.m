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
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //СИНУСОИДА отрисовка
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    int y;
    for(int x=rect.origin.x; x < rect.size.width; x++)
    {
        y = ((rect.size.height/6) * sin(((x*4) % 360) * M_PI/180) +200);   //380 -это чтобы сместить вниз
        if (x == 0) CGContextMoveToPoint(context, x, y);
        else CGContextAddLineToPoint(context, x, y);
    }
    CGContextStrokePath(context);
    
    [@"HELLO!" drawInRect:self.bounds withAttributes:@{}];
}


@end
