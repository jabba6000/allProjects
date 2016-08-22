//
//  CallOnceProxy.m
//  ProxyXX
//
//  Created by Uri Fuholichev on 8/21/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "CallOnceProxy.h"

@implementation CallOnceProxy

+(void)callOnceMethod:(SEL)method ofObject:(id)object {

    //получаем строку из имени метода и из имени класса:
    NSString *methodsNameStr = NSStringFromSelector(method);
    NSString *classNameStr = NSStringFromClass([object class]);

    //конвертируем метод в строку и считаем, есть ли у него знак ":". Если да, то метод принимает аргументы, а значит выкидываем NSAssert
    NSAssert(![methodsNameStr containsString:@":"], @"ERROR: Method has arguments - FORBIDDEN");
    
    //В User Defaults проверяем, есть ли уже объект "Словарь с классами"
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"My Classes"]==nil){
        NSMutableDictionary *myClasses = [NSMutableDictionary new];
        [defaults setObject:myClasses forKey:@"My Classes"];
    }
    
    //Теперь проверим, есть ли в My Classes объект-класс под ключем classNameStr, если нету, то добавим словарь с классами в наш корневой словарь My Classes
    if ([[defaults objectForKey:@"My Classes"] objectForKey:classNameStr]==nil)
    {
        NSMutableDictionary *classDictionary = [NSMutableDictionary new];
        [classDictionary setObject:methodsNameStr forKey:methodsNameStr];
        NSMutableDictionary *myClasses = [[defaults dictionaryForKey:@"My Classes" ]  mutableCopy];
        [myClasses setObject:classDictionary forKey:classNameStr];
        [defaults setObject:myClasses forKey:@"My Classes"];
        [object performSelector: method onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
    }
    
    /* В User Defaults проверим, есть ли по имени класса соотвествующий в словаре ключ.
     Если нет, то создадим под таким ключом словарь, добавим в него ключ с именем метода и перейдем к выполнению.
     Если такой класс уже есть, то проверим, есть ли в его словаре ключ с именем метода. Если нет, то создадим такой ключ и перейдем к выполнению, если есть, то прервем выполнение
     */
    if ([[defaults objectForKey:@"My Classes"] objectForKey:classNameStr] !=nil)
    {
        if([[[defaults objectForKey:@"My Classes"] objectForKey:classNameStr] objectForKey:methodsNameStr] == nil)
        {
            NSMutableDictionary *myClasses = [[defaults dictionaryForKey:@"My Classes"] mutableCopy];
            NSMutableDictionary *classDictionary = [[myClasses objectForKey:classNameStr] mutableCopy];
            [classDictionary setObject:methodsNameStr forKey:methodsNameStr];
            [myClasses setObject:classDictionary forKey:classNameStr];
            [defaults setObject:myClasses forKey:@"My Classes"];
            //проверки пройдены, выполняем метод
            [object performSelector: method onThread:[NSThread mainThread] withObject:nil waitUntilDone:NO];
        }
    }
}

@end
