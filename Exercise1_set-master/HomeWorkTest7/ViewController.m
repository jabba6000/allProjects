//
//  ViewController.m
//  HomeWorkTest7
//
//  Created by Uri Fuholichev on 3/16/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{

}

- (void)viewDidLoad
{
    self.numberTextField1.delegate = self;
    self.numberTextField2.delegate = self;
    
    [super viewDidLoad];
 
///////////////////////CUSTOM_KEYBOARD_FEATURES//////////////////
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[
                            [[UIBarButtonItem alloc]initWithTitle:@"Space" style:UIBarButtonItemStylePlain target:self action:@selector(spaceNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(applyNumberPad)],
                            ];
    [numberToolbar sizeToFit];
    
    _numberTextField1.inputAccessoryView = numberToolbar;
    _numberTextField2.inputAccessoryView = numberToolbar;
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _numberTextField1 || textField == _numberTextField2)
    {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^([0-9 ]+)?(\\.,([0-9 ]{1})?)?$"
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                            options:0
                                                              range:NSMakeRange(0, [newString length])];
        if (numberOfMatches == 0)
            return NO;
    }
    
    return YES;
}

////////////////BUTTONS_METHODS///////////////////////////

-(void)applyNumberPad{
    [_numberTextField1 resignFirstResponder];
    [_numberTextField2 resignFirstResponder];
}

-(void)spaceNumberPad{
    
    if (_numberTextField1.isFirstResponder)
    {
        NSString    *str = _numberTextField1.text;
        NSMutableString *mStr = [NSMutableString stringWithString:str];
        [mStr insertString:@" " atIndex:[mStr length]];
        _numberTextField1.text=mStr;
    }
    else{
        NSString    *str = _numberTextField2.text;
        NSMutableString *mStr = [NSMutableString stringWithString:str];
        [mStr insertString:@" " atIndex:[mStr length]];
        _numberTextField2.text=mStr;
    }
}


-(IBAction)backgroundTouched:(id)sender{
    [_numberTextField1 resignFirstResponder];
    [_numberTextField2 resignFirstResponder];
}


-(UIColor *)getColor{
    
    NSArray    *colors   =   [[NSArray alloc] init];
    colors=@[[UIColor redColor],
             [UIColor grayColor],
             [UIColor yellowColor],
             [UIColor greenColor],
             [UIColor blueColor],
             [UIColor purpleColor],
             [UIColor orangeColor],
             [UIColor brownColor],
             [UIColor magentaColor],
             ];
    
    int random = arc4random() % [colors count];
    UIColor *randColor = [colors objectAtIndex:random];
    return randColor;
}

- (IBAction)calculateBtn:(id)sender {
    
////////////////////////GET_DATA_FROM_TEXT_FIELDS////////////////////
    
    NSString    *textField1 = _numberTextField1.text;
    NSString    *textField2 = _numberTextField2.text;

    NSArray     *objectsFromTextField1  =  [NSMutableArray new];
    objectsFromTextField1 = [textField1 componentsSeparatedByString:@" "];
    
    NSArray     *objectsFromTextField2  =  [NSMutableArray new];
    objectsFromTextField2 =  [textField2 componentsSeparatedByString:@" "];
    
    
    
    NSMutableSet   *set1 = [NSMutableSet new];
    [set1 addObjectsFromArray:objectsFromTextField1];
    
    NSMutableSet   *set2 = [NSMutableSet new];
    [set2 addObjectsFromArray:objectsFromTextField2];
    
    NSMutableSet    *set3 = [NSMutableSet   new];
    [set3 addObjectsFromArray:objectsFromTextField1];
    
    NSMutableSet    *set4 = [NSMutableSet   new];
    [set4 addObjectsFromArray:objectsFromTextField1];
    
//    NSMutableArray  *conjunctionArray   =   [NSMutableArray new];
    
///////////////////OPERATIONS_WITH_SETS///////////////////////
    
    [set1 unionSet:set2];
    [set3 intersectSet:set2];
    [set4 minusSet:set2];
    
///////////////////RETURN_DATA_TO_LABELS///////////////////////////
    
    
    NSMutableArray  *unionOfSets   =  [NSMutableArray new];
    NSMutableArray  *intersecOfSets = [NSMutableArray new];
    NSMutableArray  *minusSet = [NSMutableArray new];
    
    unionOfSets = [NSMutableArray arrayWithArray:[set1 allObjects]];
    intersecOfSets = [NSMutableArray arrayWithArray:[set3 allObjects]];
    minusSet = [NSMutableArray arrayWithArray:[set4 allObjects]];
    
///////////////////////////////////////////////////////
    
    NSMutableAttributedString   *atrFinalResult = [NSMutableAttributedString new];
    
///////////////////////////////////////////////////////
    
    NSMutableString * unionResult = [[NSMutableString alloc] init];
    for (NSObject * obj in unionOfSets)
    {
        [unionResult appendString:[obj description]];
        [unionResult appendString:@" "];
        NSMutableAttributedString   *buffer = [[NSMutableAttributedString alloc] initWithString:unionResult];
        [buffer addAttribute:NSForegroundColorAttributeName
                       value:[self getColor]
                       range:NSMakeRange(0, [buffer length])];
        [buffer addAttribute:NSBackgroundColorAttributeName
                       value:[self getColor]
                       range:NSMakeRange(0, [buffer length]-1)];
        [atrFinalResult appendAttributedString:buffer];
        [[buffer mutableString] setString:@""];
        [unionResult setString:@""];
    }
    
    self.unionLabel.attributedText = atrFinalResult;
    [[atrFinalResult mutableString] setString:@""];
    
/////////////////////////////////////////////////////////
    
    NSMutableString * intersectResult = [[NSMutableString alloc] init];
    for (NSObject * obj in intersecOfSets)
    {
        [intersectResult appendString:[obj description]];
        [intersectResult appendString:@" "];
        NSMutableAttributedString   *buffer = [[NSMutableAttributedString alloc] initWithString:intersectResult];
        [buffer addAttribute:NSForegroundColorAttributeName
                       value:[self getColor]
                       range:NSMakeRange(0, [buffer length])];
        [buffer addAttribute:NSBackgroundColorAttributeName
                       value:[self getColor]
                       range:NSMakeRange(0, [buffer length]-1)];
        [atrFinalResult appendAttributedString:buffer];
        [[buffer mutableString] setString:@""];
        [intersectResult setString:@""];
    }
    
    self.intersectLabel.attributedText = atrFinalResult;
    [[atrFinalResult mutableString] setString:@""];
    
///////////////////////////////////////////////////////////
    
    NSMutableString     *conjunctionResult = [[NSMutableString alloc] init];
    for(NSObject *str in minusSet){
        [conjunctionResult appendString:[str description]];
        [conjunctionResult appendString:@" "];
        NSMutableAttributedString   *buffer = [[NSMutableAttributedString alloc] initWithString:conjunctionResult];
        [buffer addAttribute:NSForegroundColorAttributeName
                       value:[self getColor]
                       range:NSMakeRange(0, [buffer length])];
        [buffer addAttribute:NSBackgroundColorAttributeName
                       value:[self getColor]
                       range:NSMakeRange(0, [buffer length]-1)];
        [atrFinalResult appendAttributedString:buffer];
        [[buffer mutableString] setString:@""];
        [conjunctionResult setString:@""];
        
    }
    
    self.conjunctionLabel.attributedText = atrFinalResult;
    [[atrFinalResult mutableString] setString:@""];
    
///////////////////////////////////////////////////////////

}
@end
