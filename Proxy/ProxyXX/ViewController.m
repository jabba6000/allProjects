//
//  ViewController.m
//  ProxyXX
//
//  Created by Uri Fuholichev on 8/21/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "ViewController.h"
#import "CallOnceProxy.h"
#import "MyExperimantalClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyExperimantalClass *exp = [MyExperimantalClass new];
    
    [CallOnceProxy callOnceMethod:@selector(helloWorldMethod1) ofObject:self];
    [CallOnceProxy callOnceMethod:@selector(helloWorldMethod1) ofObject:self];
    [CallOnceProxy callOnceMethod:@selector(helloWorldMethod1) ofObject:self];
    [CallOnceProxy callOnceMethod:@selector(helloWorldMethod2) ofObject:self];
    [CallOnceProxy callOnceMethod:@selector(helloWorldMethod2) ofObject:self];
    [CallOnceProxy callOnceMethod:@selector(helloWorldMethod2) ofObject:self];
    [CallOnceProxy callOnceMethod:@selector(helloWorldMethod3) ofObject:self];
    [CallOnceProxy callOnceMethod:@selector(helloWorldMethod3) ofObject:self];
    [CallOnceProxy callOnceMethod:@selector(helloWorldMethod3) ofObject:self];
    [CallOnceProxy callOnceMethod:@selector(helloWorldMethod3) ofObject:self];
    [CallOnceProxy callOnceMethod:@selector(writeText1) ofObject:exp];
    [CallOnceProxy callOnceMethod:@selector(writeText1) ofObject:exp];
    [CallOnceProxy callOnceMethod:@selector(writeText1) ofObject:exp];
    [CallOnceProxy callOnceMethod:@selector(writeText2) ofObject:exp];


//    [CallOnceProxy callOnceMethod:@selector(helloWorldMethod4:) ofObject:self];
    //метод выше принимает аргументы, при его пропускании через proxy будет вызван NSAssert

}

//эксперементальные методы нашего VC
-(void)helloWorldMethod1{
    NSLog(@"Hello world 1 ");
}

-(void)helloWorldMethod2{
    NSLog(@"Hello world 2 ");
}

-(void)helloWorldMethod3{
    NSLog(@"Hello world 3 ");
}

-(void)helloWorldMethod4: (NSString*)string{
    NSLog(@"Hello world 4 with argument %@", string);
}

@end
