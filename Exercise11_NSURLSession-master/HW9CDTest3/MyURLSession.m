//
//  MyURLSession.m
//  HW9CDTest3
//
//  Created by Uri Fuholichev on 8/3/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

//имелась жесткая проблема, о ее сути читать ниже

#import "MyURLSession.h"

@interface MyURLSession()

@property (strong, nonatomic) NSMutableArray* resetArrayTitle;
@property (strong, nonatomic) NSMutableArray* resetArrayText;
@property (strong, nonatomic) NSMutableDictionary *dictWIthTwoArrays;

@end

@implementation MyURLSession

//это так в процессе решения проблемы было вынесено в отдельный метод, не играет роли
-(void)allocate{
    _dictWIthTwoArrays = [NSMutableDictionary new];
    _resetArrayTitle = [NSMutableArray new];
    _resetArrayText = [NSMutableArray new];
}

-(NSDictionary *)getDataFromURL {
    
    //в данном методе использована NSURLSession для доступа к сайту, где висят запросы, которые
    //довольно шустро обновляются - их мы подкачиваем в качестве исходных для reset.
    // в одном массиве лежат тайтлы, во втором - текст
    
    [self allocate];

    //создаем  экземпляр сессии
    NSURLSession *session = [NSURLSession sharedSession];
    
    //создаем экземпляр сессионного запроса, в блоке прописываем операции с полученными данными
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          //серриализуем json данные в словарь
                                          NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                          
                                          //создаем массив из объекта по ключу из словаря выше
                                          NSArray* latestLoans = [json objectForKey:@"loans"]; //2
                                          
                                          //Берем пять объектов из массива: 5 последних долгов с источника
                                          NSDictionary* loan0 = [latestLoans objectAtIndex:0];
                                          NSDictionary* loan1 = [latestLoans objectAtIndex:1];
                                          NSDictionary* loan2 = [latestLoans objectAtIndex:2];
                                          NSDictionary* loan3 = [latestLoans objectAtIndex:3];
                                          NSDictionary* loan4 = [latestLoans objectAtIndex:4];
                                          
                                          //здесь уже берем конкретно нужные нам объекты-строки по ключу
                                          [_resetArrayTitle addObject:[loan0 objectForKey:@"name"]];
                                          [_resetArrayTitle addObject:[loan1 objectForKey:@"name"]];
                                          [_resetArrayTitle addObject:[loan2 objectForKey:@"name"]];
                                          [_resetArrayTitle addObject:[loan3 objectForKey:@"name"]];
                                          [_resetArrayTitle addObject:[loan4 objectForKey:@"name"]];
                                          
                                          [_resetArrayText addObject:[loan0 objectForKey:@"use"]];
                                          [_resetArrayText addObject:[loan1 objectForKey:@"use"]];
                                          [_resetArrayText addObject:[loan2 objectForKey:@"use"]];
                                          [_resetArrayText addObject:[loan3 objectForKey:@"use"]];
                                          [_resetArrayText addObject:[loan4 objectForKey:@"use"]];
                                          
                                          
                                          [_dictWIthTwoArrays setObject:_resetArrayTitle forKey:@"TitleArray"];
                                          [_dictWIthTwoArrays setObject:_resetArrayText forKey:@"TextArray"];
                                      }];
    
    
    
    //это обязательно в конце сессионного запроса (для завершения)
    [dataTask resume];
    
    /*
     В общем, тут был жеский баг, данный метод возвращал в CUstomViewController пустой словарь, 
     так как данные с сайта не успевали загрузиться: получается, что сперва срабатывает то, что находится вне блока и только потом содержимое блока, из-за этого опережения, return возвращал пустой словарь. Цикл while дожидается, пока словарь не наполнится и завершается, когда счетчик достигает двух.
     */
    while([_dictWIthTwoArrays count]!=2){
        nil;
    }

    return _dictWIthTwoArrays;
}


@end
