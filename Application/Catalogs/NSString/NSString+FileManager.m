//
//  NSString+FileManager.m
//  CodansShareLibrary10
//
//  Created by yangxh yang on 11-11-14.
//  Copyright (c) 2011年 codans. All rights reserved.
//

#import "NSString+FileManager.h"

@implementation NSString (FileManager)

- (BOOL)fileExist {
    return [[NSFileManager defaultManager] fileExistsAtPath:self];
}

- (BOOL)fileExist:(BOOL *)isDirectory {
    return [[NSFileManager defaultManager] fileExistsAtPath:self isDirectory:isDirectory];
}

- (BOOL)fileRemove:(NSError **)error {
    return [[NSFileManager defaultManager] removeItemAtPath:self error:error];
}

- (BOOL)directoryCreate:(NSError **)error {
    if (![self fileExist]) {
        return [[NSFileManager defaultManager] createDirectoryAtPath:self withIntermediateDirectories:YES attributes:nil error:error];
    }
    return YES;
}

- (BOOL)fileCopyTo:(NSString *)path error:(NSError **)error {
    return [[NSFileManager defaultManager] copyItemAtPath:self toPath:path error:error];
}

- (int)fileSize
{
    int result = 0;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:self error:nil];
    
    if (fileAttributes != nil) {
        NSNumber *size = [fileAttributes objectForKey:NSFileSize];
        result = size.intValue;
    }
    
    return result;
}

@end
