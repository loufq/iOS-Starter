//
//  UIView+Common.h
//  LFQ Fundation
//
//  Created by loufq on 11-3-28.
//  Copyright 2011 E0571. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIView(UIView_Common)
 

-(void)removeChildren;
-(void)removeAllGestur;
-(void)setPosition:(CGPoint)aPostion;
-(void)setSize:(CGSize)aSize;

-(UIView*) getbyClass:(Class)aClass;
-(id) getbyClass:(Class)aClass withTag:(int)aTag;
-(CGPoint)getAbsolutePosition;


- (UIViewController *)belongController;

- (UIView*) GetFirstResponser;

// 设置为调试状态
- (void)setDebug:(BOOL)val;

-(UIImage *)getViewImage;

@end
 