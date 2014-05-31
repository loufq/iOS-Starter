//
//  NSString+FileManager.h
//  CodansShareLibrary10
//
//  Created by yangxh yang on 11-11-14.
//  Copyright (c) 2011年 codans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FileManager)

/*
 * exist
 */
- (BOOL)fileExist;
- (BOOL)fileExist:(BOOL *)isDirectory;

/*
 * delete
 */ 
- (BOOL)fileRemove:(NSError **)error;

/*
 * create
 */ 
- (BOOL)directoryCreate:(NSError **)error;

/***
 * copy
 */
- (BOOL)fileCopyTo:(NSString *)path error:(NSError **)error;

/***
 * file size
 */
- (int)fileSize;

@end
