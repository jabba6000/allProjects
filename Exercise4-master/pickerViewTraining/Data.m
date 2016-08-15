//
//  Data.m
//  pickerViewTraining
//
//  Created by Uri Fuholichev on 8/14/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "Data.h"

@implementation Data

-(NSMutableArray *)createArrayFoot{
    _iAFoot = [[NSArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    return _iAFoot;
}

-(NSMutableArray *)createArrayInch{
    _iAInch = [[NSArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", nil];
    return _iAInch;
}

-(NSMutableArray *)createArrayMetric{
    //arrayForMetric
    _metrica = [NSMutableArray new];
    for (NSInteger i = 0; i < 306; i++)
    {
        NSString *myStr = [NSString stringWithFormat: @"%ld", (long)i];
        [_metrica addObject:myStr];
    }
    return _metrica;
}


@end
