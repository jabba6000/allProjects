//
//  ViewController.m
//  pickerViewTraining
//
//  Created by Uri Fuholichev on 4/18/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    textFieldValue = [NSMutableString new];
    
    isMetric = YES;
    self.view.backgroundColor = [UIColor greenColor];

    imperialArrayFoot = [[NSArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    imperialArrayInch = [[NSArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", nil];
    
    //arrayForMetric
    metricArray = [NSMutableArray new];
    for (NSInteger i = 0; i < 306; i++){
        NSString *myStr = [NSString stringWithFormat: @"%ld", (long)i];
        [metricArray addObject:myStr];
    }
    
    //segmentController
    NSArray  *segmentControllerArray = [[NSArray alloc] initWithObjects:@"METRIC", @"IMPERIAL", nil];
    CGRect  segmControl = CGRectMake(0, 636, 414, 100);
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:segmentControllerArray];
    segmentControl.frame = segmControl;
    [segmentControl addTarget:self action:@selector(mySelControlAction:) forControlEvents:UIControlEventValueChanged];
    segmentControl.selectedSegmentIndex = 0;
    [self.view addSubview:segmentControl];
    
    //PickerView
    CGRect pickerViewFrame  = CGRectMake(0, 0, 300, 300);
    myPickerView = [[UIPickerView alloc] initWithFrame:pickerViewFrame];
    myPickerView.delegate = self;
    myPickerView.dataSource = self;
    myPickerView.backgroundColor = [UIColor yellowColor];
    
    //textField
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


@end
