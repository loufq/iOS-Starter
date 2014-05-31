//
//  NSObject+JSON.h
//  NSObjectJSON
//
//  Created by Benjamin on 12/16/13.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (JSON)

+ (id)objectWithJSONString:(NSString *)jsonString;

- (void)fillInJSONObject:(NSDictionary *)jsonObj;

- (NSString *)toJSONString;
- (NSDictionary *)toJSONObject;

@end
