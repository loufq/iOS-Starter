//
//  BaseTableVC.h
//  TollCollector
//
//  Created by loufq on 14-3-24.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "BaseVC.h"

@interface BaseTableVC :BaseVC <UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) BOOL pullToRefresh;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, assign) int numbersOfColumn;
+(id)createWithNumbersOfColumn:(int)iCol;

-(Class)cellClass;

-(Class)headerViewClass;
- (float)headerViewHeight:(int)aSection;

- (float)cellHeight:(NSIndexPath*)aIndexPath;
- (int)sectionCount;

@end
