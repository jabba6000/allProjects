//
//  MyTF.m
//  HW_6_Browser
//
//  Created by Uri Fuholichev on 5/27/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "MyTF.h"

@implementation MyTF

-(CGRect)rightViewRectForBounds:(CGRect)bounds{
    CGRect myRect = [super rightViewRectForBounds:bounds];
    myRect.origin.x -=5;  //кнопка "очистить" теперь отстоит от правого края на 5 пунктов
    
    return myRect;
}

@end
