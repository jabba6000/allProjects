//
//  ViewController+ImnputViewLogic.m
//  pickerViewTraining
//
//  Created by Uri Fuholichev on 7/31/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "ViewController+ImnputViewLogic.h"

@implementation ViewController (ImnputViewLogic)

# pragma mark PickerView - DataSource Methods

//теперь мы динамично выводим в текстФиелд значение ПикерВью, которые выделены
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)componen{
    
    if (isMetric)
        textField.text = metricArray[row];
    else
        textField.text = [self textForTextFieldInImperial];
}

//это для вывода в ТекстФиелд выделенных значений в системе Imperial
-(NSString *)textForTextFieldInImperial{
    
    NSInteger selectedFoot = [myPickerView selectedRowInComponent: 0];
    NSInteger selectedInch = [myPickerView selectedRowInComponent: 1];
    
    NSString *ft = imperialArrayFoot  [selectedFoot];
    NSString *inch = imperialArrayInch [selectedInch];
    
    NSString *textForTextField = [[NSString alloc] initWithFormat: @"%@'%@''", ft, inch];
    
    return textForTextField;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (isMetric)
        return 1;
    else
        return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (isMetric)
        return [metricArray count];
    else
    {
        if (component == 0) {
            return [imperialArrayFoot count];
        } else {
            return [imperialArrayInch count];
        }
    }
}

//заполняем ряды ПикерВью значениями из массивов
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (isMetric)
        return [metricArray objectAtIndex:row];
    else
    {
        if (component == 0){
            return [imperialArrayFoot objectAtIndex:row];
        }
        else {
            return [imperialArrayInch objectAtIndex:row];
        }
    }
}

#pragma mark ConvertToAnotherSystem - methods

-(void)convertToImperial
{
    NSString *fromTF = [[NSString alloc] initWithString:textField.text];
    
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
    
    textField.text = str;
    textFieldValue = str; //эта строка для выделения ряда в ПикерВью
    
}


-(void)convertToMetric
{
    NSString *fromTF = [[NSString alloc] initWithString:textField.text];
    fromTF = [fromTF stringByReplacingOccurrencesOfString:@"'" withString:@" "];
    fromTF = [fromTF stringByReplacingOccurrencesOfString:@"''" withString:@" "];
    NSLog(@"%@", fromTF);
    
    NSArray *arrayForImperial = [[NSArray alloc]initWithArray:[fromTF componentsSeparatedByString:@" "]];
    
    float x = [arrayForImperial[0] floatValue];
    float y = [arrayForImperial[1] floatValue];
    float result = x*30.48 + y*2.54;
    
    NSString *str = [[NSString alloc] initWithFormat: @"%.f", result];
    
    textField.text = str;
    textFieldValue = str; //эта строка для выделения ряда в ПикерВью
    
}

#pragma mark SegmentControl - actionMethod

-(void)mySelControlAction: (UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 0)
    {
        isMetric = YES;
        [self convertToMetric];
        
        //вот это для того, чтобы выделить в ПикерВью нужную строку после конвератции в Метрик
        NSInteger rowIndex = [metricArray indexOfObject: textFieldValue];
        [myPickerView reloadAllComponents];
        [myPickerView selectRow:rowIndex inComponent:0 animated:NO];
        //
    }
    if (segment.selectedSegmentIndex == 1)
    {
        isMetric = NO;
        [self convertToImperial];
        
        //вот это для того, чтобы выделить в ПикерВью нужную строку после конвертации в Империал
        NSString *fromTF = [[NSString alloc] initWithString:textFieldValue];
        fromTF = [fromTF stringByReplacingOccurrencesOfString:@"'" withString:@" "];
        fromTF = [fromTF stringByReplacingOccurrencesOfString:@"''" withString:@" "];
        
        NSArray *subStrings = [fromTF componentsSeparatedByString:@" "];
        NSString *firstString = [subStrings objectAtIndex:0];
        NSString *lastString = [subStrings objectAtIndex:1];
        
        NSInteger rowIndexFoot = [imperialArrayFoot indexOfObject: firstString];
        NSInteger rowIndexInch = [imperialArrayInch indexOfObject: lastString];
        [myPickerView reloadAllComponents];
        [myPickerView selectRow:rowIndexFoot inComponent:0 animated:NO];
        [myPickerView selectRow:rowIndexInch inComponent:1 animated:NO];
        //
    }
}

@end
