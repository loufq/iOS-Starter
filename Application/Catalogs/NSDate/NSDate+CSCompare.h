//
//  NSDate+CSCompare.h
//  CodansShareLibrary10
//
//  Created by 钟 平 on 11-10-28.
//  Copyright (c) 2011年 codans. All rights reserved.
//

#import <Foundation/Foundation.h>

// 时间常量
extern const NSTimeInterval ONE_SECOND;
extern const NSTimeInterval ONE_MINUTE;
extern const NSTimeInterval ONE_HOUR;
extern const NSTimeInterval ONE_DAY;
extern const NSTimeInterval ONE_WEEK;
extern const NSTimeInterval ONE_MONTH;
extern const NSTimeInterval TWENTY_EIGHT_DAYS;
extern const NSTimeInterval THIRTY_DAYS;
extern const NSTimeInterval THIRTY_ONE_DAYS;
extern const NSTimeInterval ONE_YEAR;

@interface NSDate (CSCompare)

- (NSComparisonResult)compareDateOnly:(NSDate *)otherDate;

@end
