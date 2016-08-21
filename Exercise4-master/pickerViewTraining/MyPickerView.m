//
//  MyPickerView.m
//  pickerViewTraining
//
//  Created by Uri Fuholichev on 8/14/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "MyPickerView.h"

@implementation MyPickerView

-(void)createArraysWithData{
    //Создаем и наполняем массивы
    _metricArray = [NSMutableArray new];
    _imperialArrayFoot = [NSMutableArray new];
    _imperialArrayInch = [NSMutableArray new];
    
    Data *myData = [Data new];
    
    _metricArray = [myData createArrayMetric];
    _imperialArrayFoot = [myData createArrayFoot];
    _imperialArrayInch = [myData createArrayInch];
}

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

-(NSString *)performConversionFromTextFieldToMetric: (NSString *)text{
    
    _isMetric = YES;
    NSString *textFieldValue = [self convertToMetric:text];
    
    //вот это для того, чтобы выделить в ПикерВью нужную строку после конвератции в Метрик
    NSInteger rowIndex = [self.metricArray indexOfObject: textFieldValue];
    [self reloadAllComponents];
    [self selectRow:rowIndex inComponent:0 animated:NO];
    
    return textFieldValue;
}
-(NSString *)performConversionFromTextFieldToImperial: (NSString *)text{
    _isMetric=NO;
    NSString *textFieldValue = [self convertToImperial:text];

    //вот это для того, чтобы выделить в ПикерВью нужную строку после конвертации в Империал
    NSString *fromTF = [[NSString alloc] initWithString:textFieldValue];
    fromTF = [fromTF stringByReplacingOccurrencesOfString:@"'" withString:@" "];
    fromTF = [fromTF stringByReplacingOccurrencesOfString:@"''" withString:@" "];
    
    NSArray *subStrings = [fromTF componentsSeparatedByString:@" "]; //or rather @" - "
    NSString *firstString = [subStrings objectAtIndex:0];
    NSString *lastString = [subStrings objectAtIndex:1];
    
    NSInteger rowIndexFoot = [_imperialArrayFoot indexOfObject: firstString];
    NSInteger rowIndexInch = [_imperialArrayInch indexOfObject: lastString];
    [self reloadAllComponents];
    [self selectRow:rowIndexFoot inComponent:0 animated:NO];
    [self selectRow:rowIndexInch inComponent:1 animated:NO];
    //
    return textFieldValue;
    }

#pragma mark - delegate-Methods

// Передаем значения в уведомлении через Центр уведомлений - чтобы задавть значение в текст фиелд
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)componen{
    if (_isMetric == YES)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MyNotification" object:(NSString *)[_metricArray objectAtIndex:row]];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MyNotification" object:(NSString *)[self textForTextFieldInImperial]];
    }
}

// метод получает строку для текст фиелда на основе значений в PickerView
-(NSString *)textForTextFieldInImperial{
    
    NSInteger selectedFoot = [self selectedRowInComponent: 0];
    NSInteger selectedInch = [self selectedRowInComponent: 1];
    
    NSString *ft = _imperialArrayFoot  [selectedFoot];
    NSString *inch = _imperialArrayInch [selectedInch];
    
    NSString *textForTextField = [[NSString alloc] initWithFormat: @"%@'%@''", ft, inch];
    
    return textForTextField;
}

//DELEGATE.заполняем ряды ПикерВью значениями из массивов
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_isMetric==YES)
        return [_metricArray objectAtIndex:row];
    else
    {
        if (component == 0)
            return [_imperialArrayFoot objectAtIndex:row];
        else
            return [_imperialArrayInch objectAtIndex:row];
    }
}

@end
