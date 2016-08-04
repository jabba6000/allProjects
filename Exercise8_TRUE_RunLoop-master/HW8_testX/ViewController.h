//
//  ViewController.h
//  HW8_testX
//
//  Created by Uri Fuholichev on 8/1/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyThread.h"
#import "MyMode.h"
#import "MyThreadController.h"

@interface ViewController : UIViewController <MyThreadControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *threadTField;
@property (strong, nonatomic) IBOutlet UITextField *modeTField;

@end

