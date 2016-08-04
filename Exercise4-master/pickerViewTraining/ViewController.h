//
//  ViewController.h
//  pickerViewTraining
//
//  Created by Uri Fuholichev on 4/18/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
{
    UIPickerView *myPickerView;
    
    UITextField     *textField;
    NSMutableArray  *metricArray;
    NSArray  *imperialArrayFoot;
    NSArray  *imperialArrayInch;
    BOOL    isMetric;
    NSMutableString *textFieldValue; //строка для сохранения значения ТекстФиелд
}
@end

