//
//  UILabel_CreateHelper.h
//  iPodMenuPlus
//
//  Created by loufq on 11-8-24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UILabel(CreateHelp)
+(UILabel*)create;
+(UILabel*)createWithString:(NSString*)aString;
+(UILabel*)createWithString:(NSString *)txt font:(UIFont*)font;
+(UILabel*)createWithString:(NSString *)txt font:(UIFont*)font size:(CGSize)size;

+(UILabel*)UnderLine;

@end
