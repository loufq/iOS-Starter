//
//  UITextView_CreateHelper.h
//  iMenu
//
//  Created by loufq on 12-4-16.
//  Copyright (c) 2012年 hotel3g.com. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@interface MBTextView : UITextView
@end



@interface UITextView(CreateHelp)

-(void)addInputAccessoryView;
-(void)addInputAccessoryCustomView:(UIView*)aView;


+(id)createWithSize:(CGSize)aSize;


@end
