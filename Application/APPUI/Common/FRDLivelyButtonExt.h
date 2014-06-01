//
//  FRDLivelyButtonExt.h
//  ShopReport
//
//  Created by loufq on 14-6-1.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "FRDLivelyButton.h"
#import "BaseVC.h"
@interface FRDLivelyButtonExt : FRDLivelyButton

@property (copy) NormalBlock normalBlock;

+(id)createWithStyle:(kFRDLivelyButtonStyle)style tapped:(NormalBlock)block;

+(id)createBarItemWithStyle:(kFRDLivelyButtonStyle)style tapped:(NormalBlock)block;

@end
