//
//  IFBase.m
//  IFBase
//
//  Created by yangxh on 13-1-25.
//  Copyright (c) 2013年 杭州引力网络技术有限公司. All rights reserved.
//

#import "IFBase.h"

#import <objc/runtime.h>


@interface IFBase ()

- (NSDictionary *)mappingsByClass:(Class)class;
- (BOOL)isNumberForKey:(NSString *)key;
- (BOOL)canSetNilForKey:(NSString *)key;

@end

@implementation IFBase

static Class null_class, array_class, dictionary_class, ifbase_class, string_class, number_class, date_class;
static NSMutableDictionary *mappingCache = nil;
static NSMutableDictionary *numberCache = nil;
static NSDateFormatter *dateFormatter = nil;

+ (id)createWithArray:(NSArray *)array{
    NSMutableArray* temp =[NSMutableArray array];
    for (id sender in array) {
        [temp addObject:[self createWithDictionary:sender]];
    }
    return temp;
}

+ (id)createWithDictionary:(NSDictionary *)dictionary{
    return [[self alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        if ([dictionary isKindOfClass:dictionary_class]) {
            
            NSString *mappingKey = NSStringFromClass(self.class);
            NSDictionary *mappings = mappingCache[mappingKey];
            if (!mappings) {
                mappings = [self mappings];
                mappingCache[mappingKey] = mappings;
            }
            
            [mappings enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                [self setValue:dictionary[key] forKey:obj];
            }];
        }
        
        [self customOperation:dictionary];
    }
    return self;
}


-(void)fillWithDictionary:(NSDictionary *)dictionary{
    if ([dictionary isKindOfClass:dictionary_class]) {
        NSString *mappingKey = NSStringFromClass(self.class);
        NSDictionary *mappings = mappingCache[mappingKey];
        if (!mappings) {
            mappings = [self mappings];
            mappingCache[mappingKey] = mappings;
        }
        [mappings enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [self setValue:dictionary[key] forKey:obj];
        }];
    }
}

- (void)customOperation:(NSDictionary *)dict {}

#pragma mark - Mappings

- (NSDictionary *)mappings
{
    return [self mappingsByClass:self.class];
}

- (NSDictionary *)mappingsByClass:(Class)class
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(class, &outCount);
    NSMutableDictionary *mappings = [NSMutableDictionary dictionaryWithCapacity:outCount];
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithCString:property_getName(property)
                                           encoding:NSUTF8StringEncoding];
        [mappings setObject:key forKey:key];
    }
    free(properties);
    
    // Super class
    Class superClass = class_getSuperclass(class);
    if (superClass && superClass != [NSObject class]) {
        NSDictionary *mappings_super = [self mappingsByClass:superClass];
        [mappings addEntriesFromDictionary:mappings_super];
    }
    
    return mappings;
}

- (id)transformForKey:(NSString *)key value:(id)value
{
    return nil;
}

- (Class)classForKey:(NSString *)key
{
    return nil;
}

- (BOOL)isNumberForKey:(NSString *)key
{
    __block BOOL result = NO;
    
    objc_property_t property = class_getProperty(self.class, key.UTF8String);
    NSString *attributes = [NSString stringWithUTF8String:property_getAttributes(property)];
    [[attributes componentsSeparatedByString:@","] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *typeEncoding = (NSString *)obj;
        if ([typeEncoding hasPrefix:@"T"]) {
            typeEncoding = [typeEncoding substringFromIndex:1];
            result = ([typeEncoding isEqualToString: @"i"]
                      || [typeEncoding isEqualToString: @"I"]
                      || [typeEncoding isEqualToString: @"s"]
                      || [typeEncoding isEqualToString: @"S"]
                      || [typeEncoding isEqualToString: @"l"]
                      || [typeEncoding isEqualToString: @"L"]
                      || [typeEncoding isEqualToString: @"q"]
                      || [typeEncoding isEqualToString: @"Q"]
                      || [typeEncoding isEqualToString: @"f"]
                      || [typeEncoding isEqualToString: @"d"]
                      || [typeEncoding isEqualToString: @"B"]
                      || [typeEncoding isEqualToString: @"c"]
                      || [typeEncoding isEqualToString: @"C"]
                      );
        }
    }];
    
    return result;
}

- (BOOL)canSetNilForKey:(NSString *)key {
    __block BOOL result = NO;
    
    objc_property_t property = class_getProperty(self.class, key.UTF8String);
    NSString *attributes = [NSString stringWithUTF8String:property_getAttributes(property)];
    [[attributes componentsSeparatedByString:@","] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *typeEncoding = (NSString *)obj;
        if ([typeEncoding hasPrefix:@"T@"]) {
            result = YES;
            *stop = YES;
        }
    }];
    
    return result;
}

#pragma mark - Override Super

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        null_class = [NSNull class];
        array_class = [NSArray class];
        dictionary_class = [NSDictionary class];
        ifbase_class = [IFBase class];
        string_class = [NSString class];
        number_class = [NSNumber class];
        mappingCache = [NSMutableDictionary dictionary];
        numberCache = [NSMutableDictionary dictionary];
        date_class = [NSDate class];
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    });
}

- (void)setValue:(id)value forKey:(NSString *)key
{    
    if ([value isKindOfClass:string_class] || [value isKindOfClass:number_class])  {
        
    } else if ([value isKindOfClass:null_class]) {
        value = nil;
    } else if ([value isKindOfClass:array_class] && [(NSArray *)value count] > 0) {
        Class target = [self classForKey:key];
        if (target && [target isSubclassOfClass:ifbase_class]) {
            NSMutableArray *_value = [NSMutableArray arrayWithCapacity:[(NSArray *)value count]];
            [(NSArray *)value enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if ([obj isKindOfClass:dictionary_class]) {
                    obj = [[target alloc] initWithDictionary:obj];
                    if (obj) {
                        [_value addObject:obj];
                    }
                }
            }];
            value = _value;
        }
    } else if ([value isKindOfClass:dictionary_class] && [(NSDictionary *)value count] > 0) {
        Class target = [self classForKey:key];
        if (target && [target isSubclassOfClass:ifbase_class]) {
            id _value = [[target alloc] initWithDictionary:value];
            if (_value) {
                value = _value;
            }
        }
    }
    
    // Apply Transform
    id transform = [self transformForKey:key value:value];
    if (transform) {
        value = transform;
    }
    
    [super setValue:value forKey:key];
}

- (void)setNilValueForKey:(NSString *)key
{    
    BOOL number = NO;
    NSString *numberKey = [NSStringFromClass(self.class) stringByAppendingFormat:@"---%@", key];
    NSNumber *isNumber = numberCache[numberKey];
    if (isNumber) {
        number = isNumber.boolValue;
    } else {
        number = [self isNumberForKey:key];
        numberCache[numberKey] = @(number);
    }
    
    if (number) {
        return [self setValue:@(0) forKey:key];
    }
    
    if ([self canSetNilForKey:key]) {
        [super setNilValueForKey:key];
    } else {
        NSLog(@"can't set nil for key: %@", key);
    }
}

- (NSString *)jsonString
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self objectAsDictionary] options:0 error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSString *)formatedJsonString {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self objectAsDictionary] options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

-(NSDictionary*) objectAsDictionary {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            id value = [self valueForKey:propertyName];
            
            if (value && (id)value != [NSNull null]) {
                
                if ([value isKindOfClass:ifbase_class]) {
                    value = [(IFBase *)value objectAsDictionary];
                } else if ([value isKindOfClass:array_class]) {
                    NSArray *valueOfArray = (NSArray *)value;
                    NSMutableArray *array = [NSMutableArray arrayWithCapacity:valueOfArray.count];
                    for (id obj in valueOfArray) {
                        if ([obj isKindOfClass:ifbase_class]) {
                            NSDictionary *dictValue = [(IFBase *)obj objectAsDictionary];
                            if (dictValue) {
                                [array addObject:dictValue];
                            }
                        } else {
                            [array addObject:obj];
                        }
                    }
                    value = array;
                } else if ([value isKindOfClass:date_class]) {
                    value = [dateFormatter stringFromDate:value];
                }
                
                if ([self canSetNilForKey:propertyName] || [self isNumberForKey:propertyName]) {
                    [dict setValue:value forKey:propertyName];
                } else {
                    NSLog(@"can't serialization json for key: %@", propertyName);
                }
            }
        }
    }
    free(properties);
    
    return dict;
}

- (NSString *)description {
    return [self formatedJsonString];
}

@end
