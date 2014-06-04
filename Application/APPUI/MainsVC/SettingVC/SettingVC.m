//
//  SettingVC.m
//  Application
//
//  Created by loufq on 14-6-4.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "SettingVC.h"
#import "DemoBButtonVC.h"
//////////////////////////////////////////////////////////////
/**
 *  SettingVCCell
 */
@interface SettingVCCell : BaseTableViewCell{}@end
@implementation SettingVCCell
-(void)updateAtIndex:(NSInteger)aIndex withInfo:(id)aEntity{
    self.textLabel.text= [aEntity valueForKey:@"title"];
}
@end
//////////////////////////////////////////////////////////////
/**
 *SettingVC
 */
@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设置";
    self.dataList = @[@{@"title": @"设置1"},
                      @{@"title": @"设置2"},
                      @{@"title": @"设置3"},
                      @{@"title": @"BButtonDemo"},
                      ];
    [self.tableView reloadData];
    
}

-(Class)cellClass{
    return [SettingVCCell class];
}
- (float)cellHeight:(NSIndexPath*)aIndexPath{
    return 60.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    pushVCClass([DemoBButtonVC class]);
    
}
@end
