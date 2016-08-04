//
//  myScrollView.m
//  HW_7_CG
//
//  Created by Uri Fuholichev on 6/1/16.
//  Copyright © 2016 Uri Fuholichev. All rights reserved.
//

#import "myScrollView.h"

@implementation myScrollView
    

- (void)drawRect:(CGRect)rect {
    

    //ОСИ КООРДИНАТ
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextFillRect(context, self.bounds);
    
    //толщина линии
    CGContextSetLineWidth(context, 2.0);
    //цвет линии
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    //устанавливаем кисть на стартовую точку линии
    CGContextMoveToPoint(context, 30, 30);
    //перетаскиваем кисть в конечную точку
    CGContextAddLineToPoint(context, 30, 350);
    CGContextAddLineToPoint(context, 650, 350);
    
    //стрелочка для Oy
    CGContextMoveToPoint(context, 25, 50);
    CGContextAddLineToPoint(context, 30, 30);
    CGContextAddLineToPoint(context, 35, 50);
    
    //стрелочка для Ox
    CGContextMoveToPoint(context, 630, 345);
    CGContextAddLineToPoint(context, 650, 350);
    CGContextAddLineToPoint(context, 630, 355);

    //наконец, отрисовываем линию
    CGContextStrokePath(context);

    
    //ВЕРТИКАЛЬНАЯ СЕТКА
    
    //настраиваем ширину и цвет
    CGContextSetLineWidth(context, 300.0);
    CGContextSetStrokeColorWithColor(context,
                                     [UIColor blueColor].CGColor);
    //массив с шаблоном черточек (их ширины)
    CGFloat dashArray[] = {1,[self setWidthOfSpace:x]};
    
    /*следующая функция имеет 4 параметра:
     1) контекст,
     2) фаза - определяет фазу (из массива), с которой следует начать отрисовку черт на линии
     3) массив, где указана ширина каждой из черточек
     4) количество элементов в массиве (2)
     */
    CGContextSetLineDash(context, 2, dashArray, 2);
    CGContextMoveToPoint(context, 30, 200);
    CGContextAddLineToPoint(context, 630, 200);
    CGContextStrokePath(context);
    
    [self setNumberOfVerticalLines:x];
}


-(void)setNumberOfVerticalLines:(int)x{
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    [self setWidthOfSpace:x];
    
    if (x==1) // если только одна вертикальная линия, то отыгрывает это
    {
       char *txt = [self setTitle]; //получаем из метода надпись для Тайтла
       char string[11];
       char *number = "1";
        
        //здесь мы составляем char строку из надписи TITLE и порядкового номера
        strcpy(string, number);
        strcat(string, txt);
        
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSelectFont(context, "Cochin", 16.0, kCGEncodingMacRoman);
        CGContextSetTextDrawingMode(context, kCGTextFill);

        CGAffineTransform transform;
        transform = CGAffineTransformConcat(CGContextGetTextMatrix(context),
                                            CGAffineTransformMake(1.0, 0.0, 0.0,
                                                                  -1.0, 0.0, 0.0));
        CGContextSetTextMatrix(context, transform);
        CGContextShowTextAtPoint(context, 315, 370, string, strlen(string));
    }
    if (x!=1) //если больше одной вертикальной линии, то отыгрывает это
    {
        CGFloat postionX = 600/(x+1);
        
        char allNumbers[1024] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'};
        int counter = 1;
        char *txt = [self setTitle];

       ///ЭТО ЧТОБЫ ПЕРЕВЕРНУЛО НОРМАЛЬНО ТЕКСТ
        CGAffineTransform transform;
        transform = CGAffineTransformConcat(CGContextGetTextMatrix(context),
                                            CGAffineTransformMake(1.0, 0.0, 0.0,
                                                                  -1.0, 0.0, 0.0));
        CGContextSetTextMatrix(context, transform);
       ////ТАК ЧТО НЕ ТРОГАТЬ!!!
        
        
        CGFloat titlePosition = postionX;

        
        for(int t=x; t!=0; t--)  //перебираем все тайтлы и задаем текст для них
        {
            CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
            CGContextSelectFont(context, "Cochin", 16.0, kCGEncodingMacRoman);
            CGContextSetTextDrawingMode(context, kCGTextFill);
            
            char number = allNumbers[counter];
            printf("%c", number);

            //здесь мы составляем char строку из надписи TITLE и порядкового номера
            char str3[11];
            strcpy(str3, &number);
            strcat(str3, txt);
            
            CGContextShowTextAtPoint(context, titlePosition+15, 370, str3, strlen(str3));
            
            titlePosition=titlePosition+postionX;
            
            counter++;
        }
    }
}

//Здесь рассчитывается расстояние между вертикальными линиями
// в зависимости от количества самих линий на сетке
-(CGFloat)setWidthOfSpace:(int)x{
    
    CGFloat width = 600/(x+1);
    return width;
}

//Этот метод задает значение Тайтлов под вертикальной сеткой?
//Можем прописать сами
-(char*)setTitle{
    char *txt = "Title";
    return txt;
}

@end
