//
//  myVC.m
//  HW_Ex5_CA_Test_1
//
//  Created by Uri Fuholichev on 5/24/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "myVC.h"
#import "myVCCategory.h"

@implementation myVC

- (void)viewDidLoad {
//    [super viewDidLoad];
    
    //определим словарь для наших слоев
    _dictionaryForLayers = [NSMutableDictionary new];
    
    //удержим объект класса Extension (для получения случайной точки или цвета)
    Extencions  *ext = [Extencions new];
    _myExt=ext;

//ВЕСЬ VIEW DID LOAD - здесь добавление UI элементов
    
    self.view.backgroundColor = [UIColor colorWithRed:187/255.0 green:205/255.0 blue:189/255.0 alpha:1.0];
    _myView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, self.view.frame.size.height-300)];
    _myView.backgroundColor = [UIColor colorWithRed:180/255.0 green:211/255.0 blue:139/255.0 alpha:1.0];
    _myView.layer.borderColor = [UIColor blackColor].CGColor;
    _myView.layer.borderWidth = 2.0;
    _myView.layer.cornerRadius = 5;
    _myView.layer.masksToBounds = YES;   //теперь выхлдящие за край субслои будут обрезатсья
    
    [self.view addSubview:_myView];
    
#pragma mark LabelLayerName
    
    UILabel *layerName = [[UILabel alloc] initWithFrame: CGRectMake(20, _myView.frame.size.height+35, _myView.frame.size.width/2-40, 50)];
    layerName.text = @"Layer:";
    layerName.font = [UIFont systemFontOfSize:20];
    layerName.textAlignment = NSTextAlignmentCenter;
    layerName.layer.backgroundColor = [UIColor grayColor].CGColor;
    layerName.layer.cornerRadius = 10;
    [self.view addSubview:layerName];
    

#pragma mark textFieldForName
    
    _textFieldForName = [[UITextField alloc] initWithFrame:CGRectMake(_myView.frame.size.width/2, _myView.frame.size.height+45, self.view.frame.size.width-_myView.frame.size.width/2- 20, 30)];
    _textFieldForName.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _textFieldForName.layer.cornerRadius = 5;
    
    [self.view addSubview:_textFieldForName];
    

#pragma mark addNewLayerButton
    
    UIButton *addNewLayer = [UIButton buttonWithType:UIButtonTypeCustom];
    addNewLayer.layer.backgroundColor = [UIColor greenColor].CGColor;
    addNewLayer.layer.cornerRadius = 10;
    addNewLayer.layer.borderWidth = 2;
    addNewLayer.layer.borderColor = [UIColor blackColor].CGColor;
    [addNewLayer addTarget:self
                    action:@selector(buttonNewLayerPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [addNewLayer setTitle:@"New Layer" forState:UIControlStateNormal];
    addNewLayer.frame = CGRectMake(20, _myView.frame.size.height+100, _myView.frame.size.width/2-40, 50);
    [self.view addSubview:addNewLayer];
    

#pragma mark DeleteLayerButton
   
    UIButton *deleteLayer = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteLayer.layer.backgroundColor = [UIColor greenColor].CGColor;
    deleteLayer.layer.cornerRadius = 10;
    deleteLayer.layer.borderWidth = 2;
    deleteLayer.layer.borderColor = [UIColor blackColor].CGColor;
    [deleteLayer addTarget:self
                    action:@selector(buttonDeleteLayerPressed:)
          forControlEvents:UIControlEventTouchUpInside];
    [deleteLayer setTitle:@"Delete Layer" forState:UIControlStateNormal];
    deleteLayer.frame = CGRectMake(_myView.frame.size.width/2+40, _myView.frame.size.height+100, self.view.frame.size.width/2-40, 50);
    [self.view addSubview:deleteLayer];


#pragma mark labelAnimation
    
    UILabel *layerAnimation = [[UILabel alloc] initWithFrame: CGRectMake(20, _myView.frame.size.height+170, _myView.frame.size.width/2-40, 50)];
    layerAnimation.text = @"Animation (1-5):";
    layerAnimation.font = [UIFont systemFontOfSize:20];
    layerAnimation.textAlignment = NSTextAlignmentCenter;
    layerAnimation.layer.backgroundColor = [UIColor grayColor].CGColor;
    layerAnimation.layer.cornerRadius = 10;
    [self.view addSubview:layerAnimation];
    

#pragma mark textFieldForAnimation
    
    _textFieldForAnimation = [[UITextField alloc] initWithFrame:CGRectMake(_myView.frame.size.width/2, _myView.frame.size.height+180, self.view.frame.size.width-_myView.frame.size.width/2- 20, 30)];
    _textFieldForAnimation.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _textFieldForAnimation.layer.cornerRadius = 5;
    
    [self.view addSubview:_textFieldForAnimation];
    

#pragma mark - ApplyAnimationButton
    
    UIButton *buttonApplyAnimation = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonApplyAnimation.layer.backgroundColor = [UIColor greenColor].CGColor;
    buttonApplyAnimation.layer.cornerRadius = 10;
    buttonApplyAnimation.layer.borderWidth = 2;
    buttonApplyAnimation.layer.borderColor = [UIColor blackColor].CGColor;
    [buttonApplyAnimation addTarget:self
                    action:@selector(buttonApplyAnimationPressed:)
          forControlEvents:UIControlEventTouchUpInside];
    [buttonApplyAnimation setTitle:@"Apply Animation" forState:UIControlStateNormal];
    buttonApplyAnimation.frame = CGRectMake(20, _myView.frame.size.height+ layerAnimation.frame.size.height+ layerName.frame.size.height+ addNewLayer.frame.size.height+90, self.view.frame.size.width/2-40, 50);
    [self.view addSubview: buttonApplyAnimation];
    

#pragma mark - Switch For Eternal Animation
    
    _switchForRepeatAnimationEternally = [[UISwitch alloc] initWithFrame: CGRectMake(self.view.frame.size.width/2, _myView.frame.size.height+ layerAnimation.frame.size.height+ layerName.frame.size.height+ addNewLayer.frame.size.height+90, self.view.frame.size.width/2-40, 50)];
    _switchForRepeatAnimationEternally.on = NO;
    
    [self.view addSubview:_switchForRepeatAnimationEternally];
    


#pragma mark - SwitchForReverseAnimation

    _switchForReverseAnimation = [[UISwitch alloc] initWithFrame: CGRectMake(self.view.frame.size.width/2+90, _myView.frame.size.height+ layerAnimation.frame.size.height+ layerName.frame.size.height+ addNewLayer.frame.size.height+90, self.view.frame.size.width/2-40, 50)];
    _switchForReverseAnimation.on = NO;

    [self.view addSubview:_switchForReverseAnimation];
}


#pragma mark - Selector's method for buttons

-(void) buttonNewLayerPressed:(UIButton *) sender
{
    CALayer *myLayer = [CALayer layer];
    
    if ([[_dictionaryForLayers allKeys] containsObject:_textFieldForName.text])
    {
        nil;
    }
    else{
        myLayer.backgroundColor = [_myExt getRandomColor].CGColor;
        myLayer.bounds = CGRectMake(0, 0, 50, 50);   // размер слоя
        myLayer.position = [_myExt getRandomPoint];      // положение anchorPoint на родительском слое
        myLayer.name = _textFieldForName.text;
        [_myView.layer addSublayer:myLayer];
        [_dictionaryForLayers setObject:myLayer forKey:_textFieldForName.text];
        NSLog(@"Dictionary contains %lu layers", (unsigned long)[_dictionaryForLayers count]);
    }
 }

//проверяет, есть ли в ловаре указанный слой и удаляет его, если да
-(void) buttonDeleteLayerPressed:(UIButton *) sender{
    
    if ([[_dictionaryForLayers allKeys] containsObject:_textFieldForName.text]) {
        [[_dictionaryForLayers objectForKey:_textFieldForName.text] removeFromSuperlayer ] ;
        [_dictionaryForLayers removeObjectForKey:_textFieldForName.text];
    }
    
    NSLog(@"Dictionary contains %lu layers", (unsigned long)[_dictionaryForLayers count]);
}

-(void)buttonApplyAnimationPressed: (UIButton *) sender {
    
    [self getAnimationScenario];
}



@end
