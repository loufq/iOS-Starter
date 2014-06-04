//
//  BaseTableVC.m
//  TollCollector
//
//  Created by loufq on 14-3-24.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "BaseTableVC.h"
#import "BaseTableViewCell.h"

@interface BaseTableVC ()

@end

@implementation BaseTableVC
+(id)createWithNumbersOfColumn:(int)iCol{
    BaseTableVC* view =[[self alloc] init];
    view.numbersOfColumn = iCol;
    return view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.numbersOfColumn<=1) {
        self.numbersOfColumn = 1;
    }
    self.tableView =[[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.width = self.view.width;
    self.tableView.height = self.view.height;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate=self;
    self.tableView.dataSource =self;
    [self.view addSubview:self.tableView];

}


#pragma mark - TableView delegate methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell* cell = [[self cellClass] cellForTableViewExtInfo:tableView indexPath:indexPath numbersOfColumn:self.numbersOfColumn];
    //    cell.delegate = self;
    
    id transObj=nil;
    if (self.numbersOfColumn>1) {
        transObj = self.dataList;
    }
    else{
        transObj =[self.dataList objectAtIndex:indexPath.row];
    }
    if ([cell respondsToSelector:@selector(updateAtIndex:withInfo:)]) {
        [cell updateAtIndex:indexPath.row*_numbersOfColumn withInfo:transObj];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int iCount = [self.dataList count];
    int allCol =self.numbersOfColumn;
    float f = iCount*1.0/allCol;
    float f2 = ceil(f);
    iCount = f2;
    return iCount;
}

-(int)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self sectionCount];
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self headerViewClass]) {
        return [self headerViewHeight:section];
    }
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeight:indexPath];
}

- (int)sectionCount{
    return 1;
}

- (Class)headerViewClass{
    return nil;
}

- (float)headerViewHeight:(int)aSection{
    return 0;
}

- (Class)cellClass{
    return [BaseTableViewCell class];
}
- (float)cellHeight:(NSIndexPath*)aIndexPath{
    return 44.0f;
}

@end