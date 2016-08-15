//
//  MyPickerView.m
//  pickerViewTraining
//
//  Created by Uri Fuholichev on 8/14/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "MyPickerView.h"

@implementation MyPickerView

#pragma mark - DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.isMetric)
        return 1;
    else
        return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.isMetric)
        return [_metricArray count];
    else
    {
        if (component == 0) {
            return [_imperialArrayFoot count];
        } else {
            return [_imperialArrayInch count];
        }
    }
}

#pragma mark ConvertToAnotherSystem - methods

-(NSString *)convertToImperial:(NSString *)string
{
    NSString *fromTF = [[NSString alloc] initWithString:string];
    
    int x = [fromTF intValue];
    
    int resultFoot = x/30.48;
    float resultInchSummary = x- (resultFoot*30.48);
    float resultInch = resultInchSummary / 2.54;
    
    //это чтобы избежать крэша при енсостыковке крайних величин
    if(resultFoot==10){
        resultFoot=9;
        resultInch=12;
    }
    
    NSString *str = [[NSString alloc] initWithFormat: @"%i'%.f''", resultFoot, resultInch];
    return str;
}

-(NSString *)convertToMetric: (NSString *)string
{
    NSString *fromTF = [[NSString alloc] initWithString:string];
 
    fromTF = [fromTF stringByReplacingOccurrencesOfString:@"'" withString:@" "];
    fromTF = [fromTF stringByReplacingOccurrencesOfString:@"''" withString:@" "];
    
    NSArray *arrayForImperial = [[NSArray alloc]initWithArray:[fromTF componentsSeparatedByString:@" "]];
    
    float x = [arrayForImperial[0] floatValue];
    float y = [arrayForImperial[1] floatValue];
    float result = x*30.48 + y*2.54;
    
    NSString *str = [[NSString alloc] initWithFormat: @"%.f", result];
    return str;
}

@end
