//
//  myVC.h
//  HW_Ex5_CA_Test_1
//
//  Created by Uri Fuholichev on 5/24/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Extencions.h"

@interface myVC : UIViewController

@property (strong, nonatomic) UIView *myView;
@property (strong, nonatomic) NSMutableDictionary *dictionaryForLayers;


@property (copy, nonatomic) CALayer   *myLayer;
@property (strong, nonatomic) UITextField *textFieldForName;
@property (strong, nonatomic) UITextField *textFieldForAnimation;
@property (strong, nonatomic) UISwitch    *switchForRepeatAnimationEternally;
@property (strong, nonatomic) UISwitch    *switchForReverseAnimation;


@property (strong, nonatomic) Extencions *myExt;

@end
