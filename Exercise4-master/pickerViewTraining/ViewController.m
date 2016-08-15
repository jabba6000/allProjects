//
//  ViewController.m
//  pickerViewTraining
//
//  Created by Uri Fuholichev on 4/18/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () 
{
    UIPickerView *myPickerView;
    UITextField     *textField;

    NSMutableString *textFieldValue; //строка для сохранения значения ТекстФиелд
}

@property (strong, nonatomic) MyPickerView *pickerDS;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Привязываем свойство
    MyPickerView *myPicker = [MyPickerView new];
    _pickerDS = myPicker;
    
    //Создаем и наполняем массивы
    Data *myData = [Data new];
    _pickerDS.metricArray = [NSMutableArray new];
    _pickerDS.imperialArrayFoot = [NSMutableArray new];
    _pickerDS.imperialArrayInch = [NSMutableArray new];

    _pickerDS.metricArray = [myData createArrayMetric];
    _pickerDS.imperialArrayFoot = [myData createArrayFoot];
    _pickerDS.imperialArrayInch = [myData createArrayInch];
    
    
    _pickerDS.isMetric = YES;
    
    textFieldValue = [NSMutableString new];
    
    //СОЗДАЕМ UI-элементы
    
    self.view.backgroundColor = [UIColor greenColor];

    //Создаем рукодельный segmentController
    NSArray  *segmentControllerArray = [[NSArray alloc] initWithObjects:@"METRIC", @"IMPERIAL", nil];
    CGRect  segmControl = CGRectMake(0, 636, 414, 100);
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:segmentControllerArray];
    segmentControl.frame = segmControl;
    [segmentControl addTarget:self action:@selector(mySelControlAction:) forControlEvents:UIControlEventValueChanged];
    segmentControl.selectedSegmentIndex = 0;
    [self.view addSubview:segmentControl];
    
    //PickerView
    CGRect pickerViewFrame  = CGRectMake(0, 0, 300, 300);
    myPickerView = [[MyPickerView alloc] initWithFrame:pickerViewFrame];
    myPickerView.delegate = self;   //делегат в этом же файле, ибо не выносится
    myPickerView.dataSource = _pickerDS;
    myPickerView.backgroundColor = [UIColor yellowColor];
    
    
    //TextField
    textField  =[[UITextField alloc] initWithFrame:CGRectMake(50, 300, 300, 30)];
    textField.backgroundColor = [UIColor redColor];
    textField.inputView = myPickerView;
    
    //этот тапРекогнайзер чтобы убирать клавиатуру по нажатию на вьюху
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];

    [self.view addGestureRecognizer:tapGesture];
    [self.view addSubview:textField];
}

//это чтобы клавиатуру скрывать при касании Вью-контейнера
-(void)hideKeyboard: (UITapGestureRecognizer *) recognizer{
    [textField resignFirstResponder];
}

//Делегатный метод (ибо не выносился в отдельынй файл)
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)componen{
    
    if (_pickerDS.isMetric == YES)
    {
        textField.text = _pickerDS.metricArray[row];
    }
    else
    {
        textField.text = [self textForTextFieldInImperial];
    }
}

//
-(NSString *)textForTextFieldInImperial{
    
    NSInteger selectedFoot = [myPickerView selectedRowInComponent: 0];
    NSInteger selectedInch = [myPickerView selectedRowInComponent: 1];
    
    NSString *ft = _pickerDS.imperialArrayFoot  [selectedFoot];
    NSString *inch = _pickerDS.imperialArrayInch [selectedInch];
    
    NSString *textForTextField = [[NSString alloc] initWithFormat: @"%@'%@''", ft, inch];
    
    return textForTextField;
}

//DELEGATE.заполняем ряды ПикерВью значениями из массивов
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_pickerDS.isMetric==YES)
        return [_pickerDS.metricArray objectAtIndex:row];
    else
    {
        if (component == 0){
            return [_pickerDS.imperialArrayFoot objectAtIndex:row];
        }
        else {
            return [_pickerDS.imperialArrayInch objectAtIndex:row];
        }
    }
}

#pragma mark SegmentControl - actionMethod

//Главный метод, который регулирует логику при переключении сегмент-контроллера
-(void)mySelControlAction: (UISegmentedControl *)segment
    {
    if (segment.selectedSegmentIndex == 0)
    {
        _pickerDS.isMetric = YES;
        textFieldValue = [_pickerDS convertToMetric:textField.text];
        textField.text = textFieldValue;
        
        //вот это для того, чтобы выделить в ПикерВью нужную строку после конвератции в Метрик
        NSInteger rowIndex = [_pickerDS.metricArray indexOfObject: textFieldValue];
        [myPickerView reloadAllComponents];
        [myPickerView selectRow:rowIndex inComponent:0 animated:NO];
        //
    }
    if (segment.selectedSegmentIndex == 1)
    {
        _pickerDS.isMetric = NO;
        textFieldValue =  [_pickerDS convertToImperial:textField.text];
        textField.text = textFieldValue;
        
        //вот это для того, чтобы выделить в ПикерВью нужную строку после конвертации в Империал
        NSString *fromTF = [[NSString alloc] initWithString:textFieldValue];
        fromTF = [fromTF stringByReplacingOccurrencesOfString:@"'" withString:@" "];
        fromTF = [fromTF stringByReplacingOccurrencesOfString:@"''" withString:@" "];
        
        NSArray *subStrings = [fromTF componentsSeparatedByString:@" "]; //or rather @" - "
        NSString *firstString = [subStrings objectAtIndex:0];
        NSString *lastString = [subStrings objectAtIndex:1];
        
        NSInteger rowIndexFoot = [_pickerDS.imperialArrayFoot indexOfObject: firstString];
        NSInteger rowIndexInch = [_pickerDS.imperialArrayInch indexOfObject: lastString];
        [myPickerView reloadAllComponents];
        [myPickerView selectRow:rowIndexFoot inComponent:0 animated:NO];
        [myPickerView selectRow:rowIndexInch inComponent:1 animated:NO];
        //
    }
}

@end
