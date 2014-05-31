//
//  SimpleSelectVC.h
//  ChinaCycling
//
//  Created by loufq on 13-11-19.
//  Copyright (c) 2013年 loufq. All rights reserved.
//

#import "BaseVC.h"
@protocol SimpleSelectVCDelegate <NSObject>
@optional
-(void)SimpleSelectVC:(id)vc selectIndex:(int)index;

@end

@interface SimpleSelectVC : BaseVC
@property(assign)id<SimpleSelectVCDelegate> delegate;
@property(strong)NSString* ctitle;

@property(strong)NSString* selValue;
@property(assign)int selIndex;

@property(strong)NSArray* datasource;




@end
