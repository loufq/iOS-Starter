//
//  FileUtil.h
//  iHotelShow
//
//  Created by loufq on 11-5-14.
//  Copyright 2011 e0571.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Root_DIR ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:[[[NSBundle mainBundle] infoDictionary] objectForKey: @"CFBundleName"]])

@interface FileUtil : NSObject {

}

+(BOOL) isDirectory:(NSString*)path;
+(BOOL) pathContainsDirectory:(NSString*)path;
+(void) directoryStats:(NSString*)path traverse:(BOOL)traverse count:(int*)count size:(double*)size;
+(NSArray*) getSubDirectories:(NSString*)path;
+(NSArray*) getFiles:(NSString*)path;
+(BOOL) ensureDirectoryExists:(NSString*)p;

+(float) getFileSizeInMB:(NSString*)path;
+(void) readDir:(NSString*)path array:(NSMutableArray*)array skipDescendants:(BOOL)skipDescendants;
+(void) readDir:(NSString*)path array:(NSMutableArray*)array skipDescendants:(BOOL)skipDescendants ext:(NSString*)ext;
+(NSDate*) getModificationDate:(NSString*)path;

+(BOOL) removeFile:(NSString*)dir;
+(BOOL) touch:(NSString*)path;
+(FileUtil*) handler;

+(BOOL)fileExist:(NSString*)aPath;
+(BOOL)fileNotExist:(NSString*)aPath;
@end
