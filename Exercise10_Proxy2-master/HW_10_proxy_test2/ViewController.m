//
//  ViewController.m
//  HW_10_proxy_test2
//
//  Created by Uri Fuholichev on 8/3/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+CallOnce.h"
#import "CallOnceProxy.h"

@interface ViewController ()

@property (strong, nonatomic) NSObject *myObject;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
   _myObject = [NSObject new];
    
    if([(CallOnceProxy *)[_myObject callOnceDuringAppLife] checkIfTheFirstLaunchEver]==YES)
        NSLog(@"IT THE FIRST TIME YOU LAUNCH THIS APP!");
    else
        NSLog(@"IT NOT THE FIRST TIME YOU LAUNCH THIS APP!");
}

//Эта кнопка сбрасывает значение величины на YES, чтобы мы согли увидеть сообщение о том, что приложение вообще впервые на этом телефоне запущено только что было при последующем запуске
- (IBAction)resetButton:(UIButton *)sender {
    if ((BOOL)[[NSUserDefaults standardUserDefaults] boolForKey:@"first_launch_ever"]==NO)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first_launch_ever"];
    }
}




@end
