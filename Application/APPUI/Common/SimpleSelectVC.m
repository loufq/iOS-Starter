//
//  SimpleSelectVC.m
//  ChinaCycling
//
//  Created by loufq on 13-11-19.
//  Copyright (c) 2013年 loufq. All rights reserved.
//

#import "SimpleSelectVC.h"

@interface SimpleSelectVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SimpleSelectVC


-(id)init{
    self = [super init];
    if (self) {
        self.selIndex = -1;
    }
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.ctitle) {
        self.title = self.ctitle;
    }else{
        self.title = @"选择";
    }
  
    CGRect  f = CGRectMake(0, 0, self.view.width, self.view.height-44);
    UITableView* tv =[[UITableView alloc] initWithFrame:f style:UITableViewStylePlain];
    tv.backgroundView = nil;
    tv.backgroundColor = [UIColor clearColor];
    tv.showsVerticalScrollIndicator = NO;
    tv.dataSource =self;
    tv.delegate = self;
    [self.view addSubview:tv];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell =[tableView dequeueReusableCellWithIdentifier:@"A"];
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"A"];
    }
    NSString* data =[self.datasource objectAtIndex:indexPath.row];
    cell.textLabel.text = data;
    BOOL isSelect =NO;
    if (self.selValue.length&&[self.selValue isEqualToString:data]) {
        isSelect =YES;
    }else if (self.selIndex>=0&&self.selIndex==indexPath.row) {
        isSelect =YES;
    }
    cell.accessoryType = isSelect?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(SimpleSelectVC:selectIndex:)]) {
        [self.delegate SimpleSelectVC:self selectIndex:indexPath.row];
    }
    popVC();
}

@end
