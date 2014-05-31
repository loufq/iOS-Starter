//
//  MonthYearPickerVC.m
//  TollCollector
//
//  Created by loufq on 14-5-26.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "MonthYearPickerVC.h"
#import "NTMonthYearPicker.h"

@interface MonthYearPickerVC (){
    NTMonthYearPicker *picker;
}

@end

@implementation MonthYearPickerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDate* dateFrom = [NSDate date];
    if (self.keyFilter_CustomDate.length) {
        dateFrom =  [NSUserDefaults objectForKey:self.keyFilter_CustomDate];
    }
    if (!dateFrom) {
        dateFrom = [NSDate date];
    }

    // Initialize the picker
    picker = [[NTMonthYearPicker alloc] init];
    [picker addTarget:self action:@selector(onDatePicked:) forControlEvents:UIControlEventValueChanged];
   
    // Set mode to month + year
    // This is optional; default is month + year
    picker.datePickerMode = NTMonthYearPickerModeMonthAndYear;
 
    picker.date = dateFrom;
    [self.view addSubview:picker];
}

- (void)onDatePicked:(NTMonthYearPicker *)sender {
    [NSUserDefaults setObject:sender.date forKey:self.keyFilter_CustomDate];
}

@end
