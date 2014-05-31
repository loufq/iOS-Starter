//
//  NSDate+CSCompare.m
//  CodansShareLibrary10
//
//  Created by 钟 平 on 11-10-28.
//  Copyright (c) 2011年 codans. All rights reserved.
//

#import "NSDate+CSCompare.h"

// Values defined as Google search for "How many seconds in ____"
const NSTimeInterval ONE_SECOND = 1.0;
const NSTimeInterval ONE_MINUTE = 60.0;
const NSTimeInterval ONE_HOUR = 3600.0;
const NSTimeInterval ONE_DAY = 86400.0;
const NSTimeInterval ONE_WEEK = 604800.0;
const NSTimeInterval ONE_MONTH = 2629743.83;
const NSTimeInterval TWENTY_EIGHT_DAYS = 2419200.0;
const NSTimeInterval THIRTY_DAYS = 2592000.0;
const NSTimeInterval THIRTY_ONE_DAYS = 2678400.0;
const NSTimeInterval ONE_YEAR = 31556926.0;

@implementation NSDate (CSCompare)

- (NSComparisonResult)compareDateOnly:(NSDate *)otherDate {
    NSUInteger dateFlags = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *selfComponents = [gregorianCalendar components:dateFlags fromDate:self];
    NSDate *selfDateOnly = [gregorianCalendar dateFromComponents:selfComponents];
    
    NSDateComponents *otherCompents = [gregorianCalendar components:dateFlags fromDate:otherDate];
    NSDate *otherDateOnly = [gregorianCalendar dateFromComponents:otherCompents];
    return [selfDateOnly compare:otherDateOnly];
}

@end
