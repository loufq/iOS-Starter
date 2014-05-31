//
//  UILabel_CreateHelper.m
//  iPodMenuPlus
//
//  Created by loufq on 11-8-24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UILabel_CreateHelper.h"
#import "UIView+Size.h"

@implementation UILabel(CreateHelp)

+(UILabel*)create{
    return [self createWithString:nil];
}

+(UILabel*)createWithString:(NSString*)aString{
    UILabel* lbl =[[UILabel alloc] init] ;
    lbl.adjustsFontSizeToFitWidth = YES;
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.backgroundColor =[UIColor clearColor];
    lbl.text = aString;
    lbl.size =[aString sizeWithAttributes:@{NSFontAttributeName:lbl.font}];
    return lbl;
}

+(UILabel*)createWithString:(NSString *)txt font:(UIFont*)font{
    UILabel* lbl =[[UILabel alloc] init] ;
    lbl.adjustsFontSizeToFitWidth = YES;
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.backgroundColor =[UIColor clearColor];
    lbl.text = txt;
    lbl.font = font;
    lbl.size =[txt sizeWithAttributes:@{NSFontAttributeName:font}];
    return lbl;
}

+(UILabel*)createWithString:(NSString *)txt font:(UIFont*)font size:(CGSize)size{
    UILabel* lbl =[[UILabel alloc] init] ;
    lbl.adjustsFontSizeToFitWidth = YES;
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.backgroundColor =[UIColor clearColor];
    lbl.text = txt;
    lbl.font = font;
    lbl.size =size;
    return lbl;
}

+(UILabel*)UnderLine{
    //landscape?
    UILabel* lbl =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIDevice isPad]?1024:320, 1)];
    lbl.backgroundColor =MF_ColorFromRGB(235, 235, 235);
    return lbl;
}

@end 