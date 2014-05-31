//
//  UIView+Common.m
//  LFQ Fundation
//
//  Created by loufq on 11-3-28.
//  Copyright 2011 E0571. All rights reserved.
//

#import "UIView+Common.h"
//#import "Functions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView(UIView_Common)

-(void)removeChildren
{
	NSArray* children =self.subviews;
	NSUInteger i, count = [children count];
	for (i = 0; i < count; i++) {
        UIView *view = (UIView *)[children objectAtIndex:i];
        [view removeFromSuperview];
	}
}
-(void)setPosition:(CGPoint)aPostion
{
	self.frame = CGRectMake(aPostion.x, aPostion.y, self.frame.size.width, self.frame.size.height);
}
-(void)setSize:(CGSize)aSize
{
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, aSize.width, aSize.height);
}

-(UIView*) getbyClass:(Class)aClass
{
	for (UIView* subView in self.subviews){
		if ([subView isKindOfClass:aClass]) {
			return subView;
		}
	} 
	return nil;
}

-(id) getbyClass:(Class)aClass withTag:(int)aTag
{
	for (UIView* subView in self.subviews){
		if ([subView isKindOfClass:aClass] && subView.tag==aTag) {
			return subView;
		}
	}
	return nil;
}

-(CGPoint)getAbsolutePosition
{
	UIView* view = self;
	CGPoint pos =view.frame.origin;
	while ((view = [view superview])) {
		pos = CGPointMake(pos.x + view.frame.origin.x, pos.y + view.frame.origin.y);
	}
	return pos;
}

- (UIViewController *)belongController{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
- (UIView*) GetFirstResponser{
    return  self;//(UIView*)GetFirstResponser(self);
}

-(void)removeAllGestur
{
	for(id gesture in [self gestureRecognizers]){
		[self removeGestureRecognizer:gesture];
	}
}

- (void)setDebug:(BOOL)val {
    if (val) {
        self.layer.borderColor = [[UIColor colorWithRed:(arc4random()%100)/100.0f green:(arc4random()%100)/100.0f blue:(arc4random()%100)/100.0f alpha:1.0f] CGColor
                                  ];
        self.layer.borderWidth = 1.0f;
    }
}
//将UIView转成UIImage
-(UIImage *)getViewImage
{
    //UIGraphicsBeginImageContext(theView.bounds.size);
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, self.layer.contentsScale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
