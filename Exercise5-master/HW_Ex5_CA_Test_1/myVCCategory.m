//
//  myVCCategory.m
//  HW_Ex5_CA_Test_1
//
//  Created by Uri Fuholichev on 5/26/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "myVCCategory.h"

@implementation myVC (myVCCategory)

-(CAAnimationGroup *)getAnimationScenario {
    
    //для начала получаем текущее положение слоя, имя которого вбито на текстовом поле
    
    CGPoint originPoint = [[self.dictionaryForLayers objectForKey:self.textFieldForName.text] position ];    
    
    
    //СЦЕНАРИЙ 1
    //Ездит, становится прозрачным, верится вокруг своего центра
    
    if (([self.textFieldForAnimation.text  isEqual: @"1"])) {
        
        NSArray  *pathArray = @[
                                [NSValue valueWithCGPoint:originPoint],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:originPoint],
                                ];
        
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation.values = pathArray;
        pathAnimation.keyTimes = @[@0., @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1.];
        
        CABasicAnimation *fadeAnim=[CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeAnim.fromValue=[NSNumber numberWithDouble:1.0];
        fadeAnim.toValue=[NSNumber numberWithDouble:0.1];
        
        CABasicAnimation *rotateAnim=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotateAnim.fromValue=[NSNumber numberWithDouble:0.0];
        rotateAnim.toValue=[NSNumber numberWithDouble:M_PI * 2.0];
        
        CAAnimationGroup *scenarioOne = [CAAnimationGroup animation];
        scenarioOne.duration = 5.;
        
        if (self.switchForRepeatAnimationEternally.on == YES)
            scenarioOne.repeatCount = HUGE_VALF;
        else if (self.switchForRepeatAnimationEternally.on == NO)
            scenarioOne.repeatCount = arc4random() %(10);
        
        if (self.switchForReverseAnimation.on == YES)
            scenarioOne.autoreverses = YES;
        else if (self.switchForReverseAnimation.on == NO)
            scenarioOne.autoreverses = NO;
        
        scenarioOne.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scenarioOne.animations = @[pathAnimation, fadeAnim, rotateAnim];
        
        [[self.dictionaryForLayers objectForKey:self.textFieldForName.text] addAnimation:scenarioOne forKey:@"scenario1"];
        
        return scenarioOne;
        
    }
    
    //СЦЕНАРИЙ 2
    //Ездит, меняет цвет, уменьшается
    
    if (([self.textFieldForAnimation.text  isEqual: @"2"])) {
        
        NSArray  *pathArray = @[
                                [NSValue valueWithCGPoint:originPoint],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:originPoint],
                                ];
        
        CAKeyframeAnimation *pathAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation2.values = pathArray;
        pathAnimation2.keyTimes = @[@0., @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1.];
        
        CABasicAnimation *scaleAnim=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnim.fromValue = [NSNumber numberWithFloat:1.00];
        scaleAnim.toValue = [NSNumber numberWithFloat:0.30];
        
        CABasicAnimation *backgroundAnim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        backgroundAnim.toValue = (id)[self.myExt getRandomColor].CGColor;
        
        CAAnimationGroup *scenarioTwo = [CAAnimationGroup animation];
        scenarioTwo.duration = 5.;
        
        if (self.switchForRepeatAnimationEternally.on == YES)
            scenarioTwo.repeatCount = HUGE_VALF;
        else if (self.switchForRepeatAnimationEternally.on == NO)
            scenarioTwo.repeatCount = arc4random() %(10);
        
        if (self.switchForReverseAnimation.on == YES)
            scenarioTwo.autoreverses = YES;
        else if (self.switchForReverseAnimation.on == NO)
            scenarioTwo.autoreverses = NO;
        
        scenarioTwo.autoreverses = YES;
        scenarioTwo.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scenarioTwo.animations = @[pathAnimation2, scaleAnim, backgroundAnim];
        
        [[self.dictionaryForLayers objectForKey:self.textFieldForName.text] addAnimation:scenarioTwo forKey:@"scenario2"];
        
        return scenarioTwo;
        
    }
    
    //СЦЕНАРИЙ 3
    //Ездит, превращается в круг, меняет цвет
    
    if (([self.textFieldForAnimation.text  isEqual: @"3"])) {
        
        NSArray  *pathArray = @[
                                [NSValue valueWithCGPoint:originPoint],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:originPoint],
                                ];
        
        CAKeyframeAnimation *pathAnimation3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation3.values = pathArray;
        pathAnimation3.keyTimes = @[@0., @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1.];
        
        CABasicAnimation *cornerAnim=[CABasicAnimation animationWithKeyPath:@"cornerRadius"];
        cornerAnim.toValue = [NSNumber numberWithDouble:25.0];
        
        CABasicAnimation *backgroundAnim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        backgroundAnim.toValue = (id)[self.myExt getRandomColor].CGColor;
        
        CAAnimationGroup *scenarioThree = [CAAnimationGroup animation];
        scenarioThree.duration = 5.;
        
        if (self.switchForRepeatAnimationEternally.on == YES)
            scenarioThree.repeatCount = HUGE_VALF;
        else if (self.switchForRepeatAnimationEternally.on == NO)
            scenarioThree.repeatCount = arc4random() %(10);
        
        if (self.switchForReverseAnimation.on == YES)
            scenarioThree.autoreverses = YES;
        else if (self.switchForReverseAnimation.on == NO)
            scenarioThree.autoreverses = NO;
        
        scenarioThree.autoreverses = YES;
        scenarioThree.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scenarioThree.animations = @[pathAnimation3, cornerAnim, backgroundAnim];
        
        [[self.dictionaryForLayers objectForKey:self.textFieldForName.text] addAnimation:scenarioThree forKey:@"scenario3"];
        
        return scenarioThree;
    }
    
    //СЕЦНАРИЙ 4
    //Ездит, вращается вокруг левого вехнего края, меняет цвет
    
    if (([self.textFieldForAnimation.text  isEqual: @"4"])) {
        
        NSArray  *pathArray = @[
                                [NSValue valueWithCGPoint:originPoint],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:originPoint],
                                ];
        
        CAKeyframeAnimation *pathAnimation4 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation4.values = pathArray;
        pathAnimation4.keyTimes = @[@0., @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1.];
        
        
        CALayer  *myBonusLayer = [self.dictionaryForLayers objectForKey:self.textFieldForName.text];
        myBonusLayer.anchorPoint = CGPointMake(0, 0);
        
        CABasicAnimation *rotateAnim=[CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
        rotateAnim.fromValue=[NSNumber numberWithDouble:0.0];
        rotateAnim.toValue=[NSNumber numberWithDouble:M_PI * 2.0];
        
        
        CABasicAnimation *backgroundAnim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        backgroundAnim.toValue = (id)[self.myExt getRandomColor].CGColor;
        
        CAAnimationGroup *scenarioFour = [CAAnimationGroup animation];
        scenarioFour.duration = 5.;
        
        if (self.switchForRepeatAnimationEternally.on == YES)
            scenarioFour.repeatCount = HUGE_VALF;
        else if (self.switchForRepeatAnimationEternally.on == NO)
            scenarioFour.repeatCount = arc4random() %(10);
        
        if (self.switchForReverseAnimation.on == YES)
            scenarioFour.autoreverses = YES;
        else if (self.switchForReverseAnimation.on == NO)
            scenarioFour.autoreverses = NO;
        
        scenarioFour.autoreverses = YES;
        scenarioFour.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scenarioFour.animations = @[pathAnimation4, rotateAnim, backgroundAnim];
        
        [[self.dictionaryForLayers objectForKey:self.textFieldForName.text] addAnimation:scenarioFour forKey:@"scenario3"];
        
        return scenarioFour;
    }
    
    //СЕЦНАРИЙ 5
    //Ездит, исчезает, увеличивается
    
    if (([self.textFieldForAnimation.text  isEqual: @"5"])) {
        
        NSArray  *pathArray = @[
                                [NSValue valueWithCGPoint:originPoint],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:[self.myExt getRandomPoint]],
                                [NSValue valueWithCGPoint:originPoint],
                                ];
        
        CAKeyframeAnimation *pathAnimation5 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation5.values = pathArray;
        pathAnimation5.keyTimes = @[@0., @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1.];
        
        
        CABasicAnimation *scaleAnim=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnim.fromValue = [NSNumber numberWithFloat:1.00];
        scaleAnim.toValue = [NSNumber numberWithFloat:2.00];
        
        
        CABasicAnimation *fadeAnim=[CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeAnim.fromValue=[NSNumber numberWithDouble:1.0];
        fadeAnim.toValue=[NSNumber numberWithDouble:0.3];
        
        
        CABasicAnimation *backgroundAnim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        backgroundAnim.toValue = (id)[self.myExt getRandomColor].CGColor;
        
        
        CABasicAnimation *rotateAnim=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        rotateAnim.fromValue=[NSNumber numberWithDouble:0.0];
        rotateAnim.toValue=[NSNumber numberWithDouble:M_PI * 2.0];
        
        
        CAAnimationGroup *scenarioFive = [CAAnimationGroup animation];
        scenarioFive.duration = 5.;
        
        if (self.switchForRepeatAnimationEternally.on == YES)
            scenarioFive.repeatCount = HUGE_VALF;
        else if (self.switchForRepeatAnimationEternally.on == NO)
            scenarioFive.repeatCount = arc4random() %(10);
        
        if (self.switchForReverseAnimation.on == YES)
            scenarioFive.autoreverses = YES;
        else if (self.switchForReverseAnimation.on == NO)
            scenarioFive.autoreverses = NO;
        
        scenarioFive.autoreverses = YES;
        scenarioFive.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scenarioFive.animations = @[rotateAnim, pathAnimation5, scaleAnim, fadeAnim, backgroundAnim];
        
        [[self.dictionaryForLayers objectForKey:self.textFieldForName.text] addAnimation:scenarioFive forKey:@"scenario3"];
        
        return scenarioFive;
    }

    return nil;
}


@end
