//
//  UITableViewCellBase.h
//  iPodMenuPlus
//
//  Created by loufq on 11-5-16.
//  Copyright 2011 e0571.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//单元格所在的位置

@protocol BaseTableViewCellDelegate <NSObject>
@optional

-(void)baseTableViewCell:(id)cell detailFireAtIndex:(int)aIndex;
-(void)baseTableViewCell:(id)cell editFireAtIndex:(int)aIndex;
-(void)baseTableViewCell:(id)cell delFireAtIndex:(int)aIndex;

-(void)baseTableViewCell:(id)cell fireForObject:(id)obj WithTag:(int)tag;
@end


typedef enum {
    UITableViewCellPositionTop,
    UITableViewCellPositionMiddle,
    UITableViewCellPositionBottom,
} UITableViewCellPosition;



@interface BaseTableViewCell : UITableViewCell {
	id entity;
    NSInteger curIndex;
    NSInteger allCount;
}

@property(nonatomic,weak)id<BaseTableViewCellDelegate> delegate;

@property (nonatomic, retain) id entity;
@property (nonatomic, assign) NSInteger curIndex;//当前位置
@property (nonatomic, assign) NSInteger allCount;//总行数
@property (nonatomic, assign) UITableViewCellPosition curPosition;//位置
@property (nonatomic, assign) int numbersOfColumn;
-(void)initLayout;
-(void)configCell:(id)aEntity;
-(void)updateInfo:(id)aEntity;
-(void)updateAtIndex:(NSInteger)aIndex withInfo:(id)aEntity;
-(void)updateAtIndexPath:(NSIndexPath*)aIndexPath withInfo:(id)aEntity;

+ (id)cellForTableView:(UITableView *)tableView cellIdentifier:(NSString*)cellIdentifier;
+ (id)cellForTableViewExtInfo:(UITableView *)tableView indexPath:(NSIndexPath*)aIndexPath numbersOfColumn:(int)numbersOfColumn;

+ (id)cellForTableView:(UITableView *)tableView;
+ (id)cellForTableView:(UITableView *)tableView withStyle:(UITableViewCellStyle)style;
+ (id)cellForTableViewExtInfo:(UITableView *)tableView indexPath:(NSIndexPath*)aIndexPath;
+ (NSString *)cellIdentifier;
- (id)initWithCellIdentifier:(NSString *)cellID;
//更新风格
-(void)updateStyle;




@end






