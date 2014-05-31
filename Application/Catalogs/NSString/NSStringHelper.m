//
//  NSStringHelper.m
//  CocoaHelpers
//
//  Created by Shaun Harrison on 10/14/08.
//  Copyright (c) 2008-2009 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "NSStringHelper.h"
#import <CommonCrypto/CommonDigest.h>

int const GGCharacterIsNotADigit = 10;

@implementation NSString (Helper)

- (BOOL)isNotEmpty {
    return [self length] > 0;
}
- (BOOL)isEmpty {
    return [self length] == 0;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isWhitespaceAndNewlines {
    NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![whitespace characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isEmptyOrWhitespace {
    return !self.length ||
    ![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
}


- (BOOL)containsString:(NSString *)string {
	return [self containsString:string options:NSCaseInsensitiveSearch];
}

- (BOOL)containsString:(NSString *)string options:(NSStringCompareOptions)options {
	return [self rangeOfString:string options:options].location == NSNotFound ? NO : YES;
}

#pragma mark -
#pragma mark Long conversions

- (long)longValue {
	return (long)[self longLongValue];
}

- (long long)longLongValue {
	NSScanner* scanner = [NSScanner scannerWithString:self];
	long long valueToGet;
	if([scanner scanLongLong:&valueToGet] == YES) {
		return valueToGet;
	} else {
		return 0;
	}
}

/*
 * Contact info@enormego.com if you're the author and we'll update this comment to reflect credit
 */

- (unsigned)digitValue:(unichar)c {

	if ((c>47)&&(c<58)) {
        return (c-48);
	}

	return GGCharacterIsNotADigit;
}

- (unsigned long long)unsignedLongLongValue {
	unsigned n = [self length];
	unsigned long long v,a;
	unsigned small_a, j;

	v=0;
	for (j=0;j<n;j++) {
		unichar c=[self characterAtIndex:j];
		small_a=[self digitValue:c];
		if (small_a==GGCharacterIsNotADigit) continue;
		a=(unsigned long long)small_a;
		v=(10*v)+a;
	}

	return v;

}

#pragma mark -
#pragma mark Hashes

/*
 * Contact info@enormego.com if you're the author and we'll update this comment to reflect credit
 */

- (NSString *)md5 {
	const char* string = [self UTF8String];
	unsigned char result[16];
	CC_MD5(string, strlen(string), result);
	NSString * hash = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                       result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                       result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];

	return [hash lowercaseString];
}

#pragma mark -
#pragma mark Truncation

/*
 * Contact info@enormego.com if you're the author and we'll update this comment to reflect credit
 */

- (NSString *)stringByTruncatingToLength:(int)length {
	return [self stringByTruncatingToLength:length direction:NSTruncateStringPositionEnd];
}

- (NSString *)stringByTruncatingToLength:(int)length direction:(NSTruncateStringPosition)truncateFrom {
	return [self stringByTruncatingToLength:length direction:truncateFrom withEllipsisString:@"..."];
}

- (NSString *)stringByTruncatingToLength:(int)length direction:(NSTruncateStringPosition)truncateFrom withEllipsisString:(NSString *)ellipsis {
	NSMutableString *result = [[NSMutableString alloc] initWithString:self];
	NSString *immutableResult;

	if([result length] <= length) {
		return self;
	}

	unsigned int charactersEachSide = length / 2;

	NSString * first;
	NSString * last;

	switch(truncateFrom) {
		case NSTruncateStringPositionStart:
			[result insertString:ellipsis atIndex:[result length] - length + [ellipsis length] ];
			immutableResult  = [[result substringFromIndex:[result length] - length] copy];
			return immutableResult;
		case NSTruncateStringPositionMiddle:
			first = [result substringToIndex:charactersEachSide - [ellipsis length]+1];
			last = [result substringFromIndex:[result length] - charactersEachSide];
			immutableResult = [[[NSArray arrayWithObjects:first, last, NULL] componentsJoinedByString:ellipsis] copy];
			return immutableResult;
		default:
		case NSTruncateStringPositionEnd:
			[result insertString:ellipsis atIndex:length - [ellipsis length]];
			immutableResult  = [[result substringToIndex:length] copy];
			return immutableResult;
	}
}

- (NSString *)trimWhiteSpace {
	NSMutableString *s = [self mutableCopy];
	CFStringTrimWhitespace ((CFMutableStringRef) s);
	return (NSString *) [s copy] ;
} /*trimWhiteSpace*/


// replaces string with new string, returns new var
- (NSString *)stringByReplacingString:(NSString *)searchString withString:(NSString *)newString {
    NSMutableString *mutable = [NSMutableString stringWithString:self];
    [mutable replaceOccurrencesOfString:searchString withString:newString options:NSCaseInsensitiveSearch range:NSMakeRange(0, [self length])];
    return [NSString stringWithString:mutable];
}

- (NSString *)URLEncodedString {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
                                                                           CFSTR("!*'();:@&=+$,/?%#[]<>"),
                                                                           kCFStringEncodingUTF8));
    return result;
}

- (NSString*)URLDecodedString {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                           (CFStringRef)self,
                                                                                           CFSTR(""),
                                                                                           kCFStringEncodingUTF8));

    return result;
}

- (NSURL *)ps_URL; {
    NSURL *url = nil;
    if ([self hasPrefix:@"http"]) {
        url = [NSURL URLWithString:self];
    }else if([self length] > 0) {
        url = [NSURL fileURLWithPath:self];
    }

    return url;
}

- (BOOL)isUrl{
    if ([self hasPrefix:@"http://"] || [self hasPrefix:@"https://"]) {
        return  YES;
    } else if ([self hasPrefix:@"www."]) {
        return  YES;
    }
     return  NO;
}
#pragma mark Utility
+ (NSString *)createGUID
{
	CFUUIDRef uuid = CFUUIDCreate(NULL);
	CFStringRef cfStr = CFUUIDCreateString(NULL, uuid);
	
	NSString *ret = [NSString stringWithString:CFBridgingRelease(cfStr)];
	
	CFRelease(uuid);
	// CFRelease(cfStr);
	
	return ret;
}

- (NSDate*) dateFromJSONString
{
    NSCharacterSet *charactersToRemove = [[ NSCharacterSet decimalDigitCharacterSet ] invertedSet ];
    NSString* milliseconds = [self stringByTrimmingCharactersInSet:charactersToRemove];
    
    if (milliseconds != nil && ![milliseconds isEqualToString:@"62135596800000"]) {
        NSTimeInterval  seconds = [milliseconds doubleValue] / 1000;
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    return nil;
}

-(BOOL)isNumber
{
    if (nil == self)
        return NO;
    NSError *error             = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:0 error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return numberOfMatches == self.length;
}
-(NSString *)encodeGB2312Str{
    CFStringRef nonAlphaNumValidChars = CFSTR("![        DISCUZ_CODE_1        ]’()*+,-./:;=?@_~");
    NSString *preprocessedString = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingGB_18030_2000));
    NSString *newStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)preprocessedString,NULL,nonAlphaNumValidChars,kCFStringEncodingGB_18030_2000));
    return newStr;
}
 
@end
