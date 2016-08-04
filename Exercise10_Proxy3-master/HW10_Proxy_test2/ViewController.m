//
//  ViewController.m
//  HW10_Proxy_test2
//
//  Created by Uri Fuholichev on 8/4/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "ViewController.h"
#import "Proxy.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIImageView *myImageView;

@property (strong, nonatomic) NSTimer *myTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *image = [UIImage imageNamed: @"nuka.png"];
    self.myImageView.image = image;
    
    Proxy *proxy = [Proxy new];
    
    //выполняется проверка проксятника, если да, то вызывается метод "обернутого" класса MyObject и запускается таймер на 5 секунд, чтобы показать рекламу. По сути, происходит при каждом запуске прилоги. Вообще можно было запихнуть рекламу в Лаунч Сториборд
    if([proxy checkIfTheFirstLaunchDuringExecution]==YES)
    {
        self.myImageView.hidden =  NO;
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector: @selector(myCounter) userInfo:nil repeats:YES];
    }
    else
        self.myImageView.hidden = YES;
    
    //выполняет проверка проксятником на то, первый ли раз запущена прилога вообще за то время, что установлена на телефоне
    if ([proxy checkIfTheFirstLaunchEver]==YES)
        _label.text = @"IT'S A VERY FIRST LAUNCH OF THE APP EVER!";
    else
        _label.text = @"IT'S NOT THE FIRTS LAUNCH EVER!";

}

-(void)myCounter{
    //счетчик таймера на 5 секунд, чтобы показать рекламу
     int countInt=0;
    
    while (countInt<5) {
        countInt++;
        sleep(1);
    }
    
    [_myTimer invalidate];
    self.myImageView.hidden = YES;
}

//кнопка сбрасывает состояние до "первый раз запускаю"
- (IBAction)resetButton:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first_launch_ever"];
}

@end
