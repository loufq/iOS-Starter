//
//  IFBase.h
//  IFBase
//
//  Created by yangxh on 13-1-25.
//  Copyright (c) hzTuogu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^IFBaseTransformBlock)(id value);

@interface IFBase : NSObject

#pragma mark - Init

//ignorecase ??
+ (id)createWithArray:(NSArray *)array;
+ (id)createWithDictionary:(NSDictionary *)dictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;
-(void)fillWithDictionary:(NSDictionary *)dictionary;
#pragma mark - Mappings

- (NSDictionary *)mappings;
- (Class)classForKey:(NSString *)key;
- (id)transformForKey:(NSString *)key value:(id)value;

#pragma mark - --
- (void)customOperation:(NSDictionary *)dict;

//object to json string
- (NSString *)jsonString;

@end
