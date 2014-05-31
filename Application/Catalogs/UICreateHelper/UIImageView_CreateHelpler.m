//
//  UIImageView_CreateHelpler.m
//  iPodMenuPlus
//
//  Created by loufq on 11-8-31.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UIImageView_CreateHelpler.h"
#import "UIView+Size.h"


@implementation UIImageView(CreateHelp)
+(id)create{
    UIImageView* iv =[[self alloc] initWithFrame:CGRectZero] ;
    return iv;
}

+(id)createWithImage:(UIImage*)image{
    CGFloat scale = 1;//[[UIScreen mainScreen] scale];
    UIImageView* iv =[[self alloc] initWithFrame:CGRectZero];
    iv.size = CGSizeMake(image.size.width/scale, image.size.height/scale);
    iv.image = image;
    return iv;
}
@end
