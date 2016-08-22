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
    
    //ПОДКЛЮЧАЕМ СЛАЙДЕР ДЛЯ РЕГУЛИРОВАНИЯ ЛИНИЙ СЕТКИ
    MySlider *_mySlider = [[MySlider alloc] initWithFrame:CGRectMake(630, 180, 150, 50)];
    [_mySlider rotateSliderAndSetItsValues];
    [self.view addSubview:_mySlider];
    //добавляем метод, который будет отыгрывать при взаимодействии со слайдером
    [_mySlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
    // Здесь создается экземпляр каcтомного СкроллВью метода, в дров Рект методе которого
    // уже нарисована вертикальная сетка, ось обсцисс и ось ординат (последние две - статичные)
    myScrollView    *scroll = [[myScrollView alloc] initWithFrame:CGRectMake(10, 0, 660, 414)];
    scroll.contentSize = CGSizeMake (2000, 414);
    scroll.bounces = NO;
    self.scrView = scroll;
    [self.view addSubview:scroll];
    
    // создаем массив для точек, который передадим на график
    // В принципе можно было сделать плавную линию, использую кривые Бизье
    // Но в данном случае просто ломаная линия
    NSMutableArray *arrayOfPoints = [NSMutableArray new];
    [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(10, 250)]];
    [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(100,150)]];
    [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(150,200)]];
    [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(200,330)]];
    [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(250,300)]];
    [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(300,20)]];
    [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(450,390)]];
    [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(600,150)]];
    [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(800,400)]];
    [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(1000,200)]];
    [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(1200,250)]];
    [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(1400,300)]];
    [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(1600,20)]];
    [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(1800,200)]];
    [arrayOfPoints addObject:[NSValue valueWithCGPoint:CGPointMake(2000,150)]];

    myCurve *curve = [[myCurve alloc] initWithFrame:CGRectMake(0,0,2000, 414)];
    curve.backgroundColor = [UIColor clearColor];
    //присваиваем массив точек свойству нашего компонента - кривой
    curve.pointsToDraw = arrayOfPoints;
    [scroll addSubview:curve];
}

//метод для слайдера: меняет количество вертикальных линий в соотвествии со значением слайдера
-(void)sliderAction:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    int value = slider.value;

    self.scrView->x = value; //доступ к внутренней переменной myScrollView через @public
    
    // метод ниже действует наподобие reload Data, т.к. вызывает изменение расстояния
    // между вертикальными линиями
    [self.scrView setNeedsDisplay];
}


@end
