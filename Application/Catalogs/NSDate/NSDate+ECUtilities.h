// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------



@interface NSDate(ECUtilities)

+ (NSString *) formattedRelativeToInterval: (NSTimeInterval) interval;

- (NSString *) formattedRelativeTo: (NSDate*) date;
- (NSString *) formattedRelative;

- (NSString*) formattedRelativeWithDayTo: (NSDate*) date;
- (NSString *) formattedRelativeWithDay;
// MARK: - 根据指定格式格式化日期
// MM/dd/yyyy h:mm a
- (NSString *)formattedString:(NSString *)desiredFormat;

+ (NSDate *)dateWithString:(NSString *)formattedString format:(NSString *)format;
- (NSDate *)dateDay;
- (NSDate *)dateTime;
@end
