//
//  BasePagingVC.m
//  PaperMedia
//
//  Created by loufq on 13-7-9.
//  Copyright (c) 2013年 Tuogu. All rights reserved.
//

#import "BasePagingVC.h"
#import "BaseTableViewCell.h"

@interface BasePagingVC ()

@end

@implementation BasePagingVC
+(id)createWithNumbersOfColumn:(int)iCol{
    BasePagingVC* view =[[self alloc] init];
    view.numbersOfColumn = iCol;
    return view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.numbersOfColumn<=1) {self.numbersOfColumn = 1;}
    self.tableView =[[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.width = self.view.width;
    self.tableView.height = self.view.height;
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate=self;
    self.tableView.dataSource =self;
    [self.view addSubview:self.tableView];
    if ([self loadReFreshFooter]) {
        [self setupTableViewFooter];
    }
    // set up the paginator
    [self refreshPaginator];
}

-(void)refreshPaginator{
    if ([self PaginatorClass]) {
        self.paginator = [[[self PaginatorClass] alloc] initWithPageSize:kConstant_onePageLoad delegate:self];
        [self.paginator addObserver:self forKeyPath:@"requestStatus" options:NSKeyValueObservingOptionNew context:nil];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"requestStatus"]) {
        RequestStatus rs = self.paginator.requestStatus;
        if (rs==RequestStatusInProgress) {
            if (!self.pullToRefresh) {
                [self.activityIndicator startAnimating];
                self.activityIndicator.hidden = NO;
                self.footerLabel.text  = @"加载中...";
                [self.activityIndicator setNeedsDisplay];
                [self.footerLabel setNeedsDisplay];
            }
            else{
                self.activityIndicator.hidden = YES;
                [self.activityIndicator stopAnimating];
            }
        }else if (rs==RequestStatusDone) {
            self.activityIndicator.hidden = YES;
            [self.activityIndicator stopAnimating];
        }
    }
}

#pragma mark - Actions
- (void)fetchFirst{
    [self.paginator fetchFirstPage];
    
}

- (void)fetchNext
{
    [self.paginator fetchNextPage];
}

- (void)setupTableViewFooter
{
    // set up label
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    footerView.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    self.footerLabel = label;
    [footerView addSubview:label];
    // set up activity indicator
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.center = CGPointMake(40, 22);
    activityIndicatorView.hidesWhenStopped = NO;
    self.activityIndicator = activityIndicatorView;
    [footerView addSubview:activityIndicatorView];
    self.tableView.tableFooterView = footerView;
}

- (void)updateTableViewFooter
{
    
    self.activityIndicator.hidden =YES;
    self.footerLabel.text = @"";
    [self.footerLabel setNeedsDisplay];
}

#pragma mark - Paginator delegate methods

- (void)paginator:(id)paginator didReceiveResults:(NSArray *)results
{
    [self.tableView.pullToRefreshView stopAnimating];
    self.pullToRefresh = NO;
    // update tableview footer
    [self updateTableViewFooter];
    [self.activityIndicator stopAnimating];
    [self.tableView reloadData];
    
    [self successLoadWithPageinator:paginator];
    
    return;
    // update tableview content
    // easy way : call [tableView reloadData];
    // nicer way : use insertRowsAtIndexPaths:withAnimation:
    /*
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSInteger i = [self.paginator.results count] - [results count];
    
    for(NSDictionary *result in results)
    {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        i++;
    }
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.tableView endUpdates];
     */
}

-(void)successLoadWithPageinator:(id)paginator{
    
}

- (void)paginatorDidReset:(id)paginator
{
    // [self.tableView reloadData];
    // [self updateTableViewFooter];
}

- (void)paginatorDidFailToRespond:(id)paginator error:(NSError *)error
{
    MBProgressHUD* hud =[MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    if (error) {
        [hud setLabelText:error.localizedDescription];
    } else {
        [hud setLabelText:@"请求异常"];
    }
    [hud hide:YES afterDelay:1];
}

#pragma mark - TableView delegate methods
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    BaseTableViewCell* cell = [[self cellClass] cellForTableViewExtInfo:tableView indexPath:indexPath];
//    //    cell.delegate = self;
//    id transObj=nil;
//    
//    if (self.paginator.results.count>indexPath.row) {
//        transObj = [self.paginator.results objectAtIndex:indexPath.row];
//    }
//    
//    if ([cell respondsToSelector:@selector(updateAtIndex:withInfo:)]) {
//        [cell updateAtIndex:indexPath.row withInfo:transObj];
//    }
//    return cell;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    int iCount = [self.paginator.results count];
//    return iCount;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell* cell = [[self cellClass] cellForTableViewExtInfo:tableView indexPath:indexPath numbersOfColumn:self.numbersOfColumn];
//    cell.delegate = self;
    
    id transObj=nil;
    if (self.numbersOfColumn>1) {
        transObj = self.paginator.results;
    }
    else{
        if (self.paginator.results.count>indexPath.row) {
            transObj = [self.paginator.results objectAtIndex:indexPath.row];
        }
    }
    if ([cell respondsToSelector:@selector(updateAtIndex:withInfo:)]) {
        [cell updateAtIndex:indexPath.row*_numbersOfColumn withInfo:transObj];
    }
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int iCount = [self.paginator.results count];
    // iCount =(int) floor(iCount*1.0/self.numbersOfColumn);
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
#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // when reaching bottom, load a new page
    if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.bounds.size.height)
    {
        // ask next page only if we haven't reached last page
        if(![self.paginator reachedLastPage])
        {
            // fetch next page of results
            [self fetchNext];
        }
    }
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeight:indexPath];
}

-(Class)PaginatorClass{
    return [MyPaginator class];
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

- (void)dealloc {
    [self.paginator removeObserver:self forKeyPath:@"requestStatus"];
}
-(BOOL)loadReFreshFooter{
    return YES;
}
@end
