//
//  Data.h
//  pickerViewTraining
//
//  Created by Uri Fuholichev on 8/14/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
    Были кое-какие проблемы с наполняемостью массивов для Империал-системы, поэтому вынес в отдельный файл, как выяснилось, необходимости в этом не было. В общем, здесь три метода, которые наполняют массивы значениями, которые не меняются на протяжении жизненного цикла аппы.
 */

@interface Data : NSObject

@property (strong, nonatomic) NSMutableArray *iAFoot;
@property (strong, nonatomic) NSMutableArray *iAInch;
@property (strong, nonatomic) NSMutableArray *metrica;

-(NSMutableArray *)createArrayFoot;
-(NSMutableArray *)createArrayInch;
-(NSMutableArray *)createArrayMetric;

@end
