//
//  UITableViewCellBase.m
//  iPodMenuPlus
//
//  Created by loufq on 11-5-16.
//  Copyright 2011 e0571.com. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell
@synthesize entity,curIndex,allCount;
@synthesize curPosition;

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (id)cellForTableView:(UITableView *)tableView cellIdentifier:(NSString*)cellIdentifier{
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[self alloc] initWithCellIdentifier:cellIdentifier];
    }
    return cell;
}

+ (id)cellForTableView:(UITableView *)tableView {
    NSString *cellID = [self cellIdentifier];
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc] initWithCellIdentifier:cellID];
    }
    return cell;
}

+ (id)cellForTableView:(UITableView *)tableView withStyle:(UITableViewCellStyle)style{
    int istyle = style;
    NSString *cellID = [[self cellIdentifier] stringByAppendingFormat:@"%d",istyle];
    BaseTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        
        cell = [[self alloc] initWithStyle:style reuseIdentifier:cellID];
        [cell initLayout];
        //      cell.backgroundColor =skinMainColor();
    }
    return cell;
}


+ (id)cellForTableViewExtInfo:(UITableView *)tableView indexPath:(NSIndexPath*)aIndexPath{
    NSString *cellID = [self cellIdentifier];
    BaseTableViewCell *cell = (BaseTableViewCell*)[tableView  dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc] initWithCellIdentifier:cellID];
    }
    
    cell.allCount = [tableView numberOfRowsInSection:aIndexPath.section];
    cell.curPosition = aIndexPath.row==0?UITableViewCellPositionTop:
    aIndexPath.row==cell.allCount-1?UITableViewCellPositionBottom:
    UITableViewCellPositionMiddle;
    
    [cell updateStyle];
    
    return cell;
}

- (id)initWithCellIdentifier:(NSString *)cellID {
    BaseTableViewCell* cell = [self initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:cellID];
    [cell initLayout];
    return cell;
}

+ (id)cellForTableViewExtInfo:(UITableView *)tableView indexPath:(NSIndexPath*)aIndexPath numbersOfColumn:(int)numbersOfColumn{
    NSString *cellID = [self cellIdentifier];
    BaseTableViewCell *cell = (BaseTableViewCell*)[tableView  dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc] initWithCellIdentifier:cellID numbersOfColumn:numbersOfColumn];
    }
    
    cell.allCount = [tableView numberOfRowsInSection:aIndexPath.section];
    cell.curPosition = aIndexPath.row==0?UITableViewCellPositionTop:
    aIndexPath.row==cell.allCount-1?UITableViewCellPositionBottom:
    UITableViewCellPositionMiddle;
    
    [cell updateStyle];
    
    return cell;
}

- (id)initWithCellIdentifier:(NSString *)cellID numbersOfColumn:(int)numbersOfColumn{
    BaseTableViewCell* cell = [self initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:cellID];
    cell.numbersOfColumn = numbersOfColumn;
    [cell initLayout];
    return cell;
}


-(void)initLayout{}
-(void)configCell:(id)aEntity{
	
}
-(void)updateInfo:(id)aEntity{}
-(void)updateAtIndex:(NSInteger)aIndex withInfo:(id)aEntity{
    self.curIndex = aIndex;
    self.entity = aEntity;
}
-(void)updateAtIndexPath:(NSIndexPath*)aIndexPath withInfo:(id)aEntity{
    self.entity = aEntity;
}

-(void)updateStyle{}
@end
