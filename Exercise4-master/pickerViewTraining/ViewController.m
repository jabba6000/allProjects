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
    UITextField     *textField;
}

@property (strong, nonatomic) MyPickerView *pickerDS;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Создаем кастомный PickerView
    CGRect pickerViewFrame  = CGRectMake(0, 0, 300, 300);
    _pickerDS = [[MyPickerView alloc] initWithFrame:pickerViewFrame];
    //Создаем и наполняем массивы
    [_pickerDS createArraysWithData];
    _pickerDS.delegate = _pickerDS;   //делегат в этом же файле, ибо не выносится
    _pickerDS.dataSource = _pickerDS;
    _pickerDS.backgroundColor = [UIColor yellowColor];
    _pickerDS.isMetric = YES;

    //СОЗДАЕМ прочие UI-элементы
    
    self.view.backgroundColor = [UIColor greenColor];

    //Создаем программно segmentController
    NSArray  *segmentControllerArray = [[NSArray alloc] initWithObjects:@"METRIC", @"IMPERIAL", nil];
    CGRect  segmControl = CGRectMake(0, 636, 414, 100);
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:segmentControllerArray];
    segmentControl.frame = segmControl;
    [segmentControl addTarget:self action:@selector(mySelControlAction:) forControlEvents:UIControlEventValueChanged];
    segmentControl.selectedSegmentIndex = 0;
    [self.view addSubview:segmentControl];
    
    //TextField
    textField  =[[UITextField alloc] initWithFrame:CGRectMake(50, 300, 300, 30)];
    textField.backgroundColor = [UIColor redColor];
    textField.inputView = _pickerDS;
    [self.view addSubview:textField];
    
    //этот тапРекогнайзер чтобы убирать клавиатуру по нажатию на вьюху
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
    
    //подписались на уведомления, чтобы получать в текстФиелд значения, выбранные из нашего PickerView
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didGetMyNotification:)
                                                 name:@"MyNotification"
                                               object:nil];
}

//получаем значения для текст-фиелда
-(void)didGetMyNotification: (NSNotification*)notification{
    textField.text = [notification object];
}

//это чтобы клавиатуру скрывать при касании Вью-контейнера
-(void)hideKeyboard: (UITapGestureRecognizer *) recognizer{
    [textField resignFirstResponder];
}

#pragma mark SegmentControl - actionMethod

//Главный метод, который регулирует логику при переключении сегмент-контроллера
-(void)mySelControlAction: (UISegmentedControl *)segment{
    if (segment.selectedSegmentIndex == 0){
        textField.text = [_pickerDS performConversionFromTextFieldToMetric:textField.text];
    }
    if (segment.selectedSegmentIndex == 1){
        textField.text = [_pickerDS performConversionFromTextFieldToImperial:textField.text];
    }
}

@end
