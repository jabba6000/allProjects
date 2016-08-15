//
//  MyPickerView.h
//  pickerViewTraining
//
//  Created by Uri Fuholichev on 8/14/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"

/*
    Здесь мы унаследовались от UIPickerView и подписались на ДатаСорс протокол. Реализуем 2 ДатаСорс метода,а также 2 метода для конвертации величин из метрик в империал и обратно
 */

@interface MyPickerView : UIPickerView <UIPickerViewDataSource>

@property (nonatomic) BOOL isMetric;
@property(strong, nonatomic) NSMutableArray  *metricArray;
@property(strong, nonatomic) NSArray  *imperialArrayFoot;
@property(strong, nonatomic) NSArray  *imperialArrayInch;

-(NSString *)convertToImperial:(NSString *)string;
-(NSString *)convertToMetric: (NSString *)string;

@end
