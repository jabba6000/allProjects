//
//  ViewController.m
//  HW_7_CG
//
//  Created by Uri Fuholichev on 5/31/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong)myScrollView *scrView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    //это чтобы повернуть слайдер на 90 градусов
    _mySlider.transform = CGAffineTransformMakeRotation(M_PI_2);
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI_2);
    _mySlider.transform =trans;
    
    [_mySlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    _mySlider.minimumValue = 1.0;
    _mySlider.maximumValue = 10.0;
    _mySlider.continuous = YES;
    _mySlider.value = 5.0;
    
    // Здесь создается экземпляр катомного СкроллВью метода, в дров Рект методе которого
    // уже нарисована вертикальная сетка, ось обсцисс и ось ординат (статичные)
    myScrollView    *scroll = [[myScrollView alloc] initWithFrame:CGRectMake(10, 0, 660, 414)];
    scroll.contentSize = CGSizeMake (2000, 414);
    scroll.bounces = NO;
    
    
    self.scrView = scroll;
    [self.view addSubview:scroll];
    
    /*
     Теперь создаем кривую-экземпляр кастомного класса от UIView
     и кидаем ее на view нашего ViewController
     */
    myCurve *curve = [[myCurve alloc] initWithFrame:CGRectMake(0,0,2000, 414)];
    curve.backgroundColor = [UIColor clearColor];
    [scroll addSubview:curve];
}


-(void)sliderAction:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    int value = slider.value;
    NSLog(@"The value is %i", value);

    self.scrView->x = value; //доступ к внутренней переменной myScrollView через @public
    
    // метод ниже действует наподобие reload Data, т.к. вызывает изменение расстояния
    // между вертикальными линиями
    [self.scrView setNeedsDisplay];
}


@end
