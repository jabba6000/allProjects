//
//  ViewController.h
//  HomeWorkTest7
//
//  Created by Uri Fuholichev on 3/16/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *numberTextField1;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField2;

@property (weak, nonatomic) IBOutlet UILabel *intersectLabel;
@property (weak, nonatomic) IBOutlet UILabel *conjunctionLabel;
@property (weak, nonatomic) IBOutlet UILabel *unionLabel;

-(UIColor *)getColor;

- (IBAction)calculateBtn:(id)sender;

@end

