//
//  UIImage+Color.m
//  Application
//
//  Created by loufq on 14-6-27.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)
+(UIImage*)imageFromColor:(UIColor*)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color CGColor]);
    CGContextFillRect(context, rect);
    UIImage * imge = [[UIImage alloc] init];
    imge = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imge;
}
@end
