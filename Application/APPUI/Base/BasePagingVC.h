//
//  BasePagingVC.h
//  PaperMedia
//
//  Created by loufq on 13-7-9.
//  Copyright (c) 2013年 Tuogu. All rights reserved.
//

#import "MyPaginator.h"
#import "BaseVC.h"
#define kConstant_onePageLoad 10

@interface BasePagingVC : BaseVC <NMPaginatorDelegate, UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) BOOL pullToRefresh;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MyPaginator *paginator;

@property (nonatomic, strong) UILabel *footerLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, assign) int numbersOfColumn;
+(id)createWithNumbersOfColumn:(int)iCol;

-(Class)PaginatorClass;
-(Class)cellClass;

-(Class)headerViewClass;
- (float)headerViewHeight:(int)aSection;

- (float)cellHeight:(NSIndexPath*)aIndexPath;
- (int)sectionCount;

- (void)fetchNext;
- (void)fetchFirst;

- (void)refreshPaginator;

-(BOOL)loadReFreshFooter;



- (void)successLoadWithPageinator:(id)paginator;


- (void)paginatorDidFailToRespond:(id)paginator error:(NSError *)error;
@end
