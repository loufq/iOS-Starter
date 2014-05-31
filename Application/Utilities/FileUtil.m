//
//  FileUtil.m
//  iHotelShow
//
//  Created by loufq on 11-5-14.
//  Copyright 2011 e0571.com. All rights reserved.
//

#import "FileUtil.h"


@implementation FileUtil
+(BOOL) isDirectory:(NSString*)path {
	
	BOOL isFile = FALSE;
	BOOL isFolder = FALSE;
	isFile = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isFolder];

	return isFile && isFolder;
}

+(BOOL) pathContainsDirectory:(NSString*)path {
	return ([[path pathComponents] count] > 1);
}

+(BOOL) removeFile:(NSString*)path {
	BOOL ok = [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
	return ok;
}

+(BOOL) touch:(NSString*)path {
	return [[NSFileManager defaultManager] createFileAtPath:path contents:[NSData data] attributes:nil];
}

/**
 * Get the subdirectory listing.
 */
+(NSArray*) getSubDirectories:(NSString*)path {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:path];
	
	NSMutableArray *subDirs = [NSMutableArray arrayWithCapacity:10];
	
	NSString* file;
	while (file = [enumerator nextObject]) {
		NSString *f = [path stringByAppendingPathComponent:file];
		if ([FileUtil isDirectory:f]) {
			[subDirs addObject:file];
		}
	}
	return subDirs;
}

+(NSArray*) getFiles:(NSString*)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:path];
	
	NSMutableArray *files = [NSMutableArray arrayWithCapacity:10];
	
	NSString* file;
	while (file = [enumerator nextObject]) {
		NSString *f = [path stringByAppendingPathComponent:file];
		if (![FileUtil isDirectory:f]&&[f hasSuffix:@".jpg"]) {
			[files addObject:[path stringByAppendingPathComponent:file]];
		}
	}
	return files;
}
/**
 * Get directory statistics, count and total file size.
 */
+(void) directoryStats:(NSString*)path traverse:(BOOL)traverse count:(int*)count size:(double*)size {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:path];
	
	NSString* file;
	while (file = [enumerator nextObject]) {
		file = [path stringByAppendingPathComponent:file];
		if ([FileUtil isDirectory:file]) {
			if (!traverse) [enumerator skipDescendents];
			continue;
		}
		//NSDictionary *fattrs = [fileManager fileAttributesAtPath:file traverseLink:NO];
		//NSDictionary *fattrs = [fileManager fileSystemAttributesAtPath:file];
		NSDictionary *fattrs = [fileManager attributesOfFileSystemForPath:file error:nil]; 
		
		NSNumber *fsize;
		if ((fsize = [fattrs objectForKey:NSFileSize])) {
			double mb = [fsize floatValue]/1048576.0;
			(*size) += mb;
			(*count)++;
		}
		
	}
}

/**
 * Ensure the directory exists for the specified path.
 */
#pragma mark todo
+(BOOL) ensureDirectoryExists:(NSString*)p {
	if (!p) {
		return NO;
	}
	if ([[NSFileManager defaultManager] fileExistsAtPath:p]) return YES;
	BOOL ok = YES;
	NSString *path = [p stringByExpandingTildeInPath];
	NSArray *pathArray = [path pathComponents];
	NSString *tmpPath = @"";
	int i;
	for (i = 0; i < [pathArray count]-1; i++) {//
		tmpPath = [tmpPath stringByAppendingPathComponent:[pathArray objectAtIndex:i]];
        
		if (![[NSFileManager defaultManager] fileExistsAtPath:tmpPath]) {
			//DebugLog(@"Trying to create path: %@", tmpPath);
			//ok &= [[NSFileManager defaultManager] createDirectoryAtPath:tmpPath attributes:NULL];
			ok &= [[NSFileManager defaultManager] createDirectoryAtPath:tmpPath
											withIntermediateDirectories:YES
															 attributes:NULL
																  error:nil];
			//if (ok) DebugLog(@"Created path: %@", tmpPath);
			//else DebugLog(@"Error creating path");
		} //else RWLog(@"Path exists: %@", tmpPath);
		
		if (!ok) return NO;
	}
	
	return ok;
}

/**
 * Get modification date.
 * @return nil if an error occurred
 */
+(NSDate*) getModificationDate:(NSString*)path {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	//NSDictionary *fattrs = [fileManager fileAttributesAtPath:path traverseLink:NO];
	NSDictionary *fattrs = [fileManager attributesOfItemAtPath:path error:nil];
	return [fattrs objectForKey:NSFileModificationDate];
}

/**
 * Get file size in mega bytes (MiB).
 * @return -1 if an error occured
 */
+(float) getFileSizeInMB:(NSString*)path {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	//NSDictionary *fattrs = [fileManager fileAttributesAtPath:path traverseLink:NO];
	NSDictionary *fattrs = [fileManager attributesOfItemAtPath:path error:nil];
	NSNumber *fsize;
	if ((fsize = [fattrs objectForKey:NSFileSize])) {
		float mb = [fsize floatValue]/1024000.0;
		return mb;
	}
	return -1;
}

/**
 * Get directory listing.
 */
+(void) readDir:(NSString*)path array:(NSMutableArray*)array skipDescendants:(BOOL)skipDescendants {
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:path];
	
	NSString* file;
	while (file = [enumerator nextObject]) {                                
		file = [path stringByAppendingPathComponent:file];
		if ([FileUtil isDirectory:file] && skipDescendants) {
			[enumerator skipDescendents];
			continue;
		}
		[array addObject:file];
	}
}

/**
 * Get directory listing.
 */
+(void) readDir:(NSString*)path array:(NSMutableArray*)array skipDescendants:(BOOL)skipDescendants ext:(NSString*)ext{
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:path];
	
	NSString* file;
	while (file = [enumerator nextObject]) {                                
		file = [path stringByAppendingPathComponent:file];
		if ([FileUtil isDirectory:file] && skipDescendants) {
			[enumerator skipDescendents];
			continue;
		}
        
        if ([file hasSuffix:ext]) {
            [array addObject:file];     
        }
	}
}

+(BOOL)fileExist:(NSString*)aPath{
    NSFileManager* fm =[NSFileManager defaultManager];
    return [fm fileExistsAtPath:aPath];
}

+(BOOL)fileNotExist:(NSString*)aPath{
    return ![self fileExist:aPath];
}


/**
 * Get file util handler.
 */
+(FileUtil*) handler {
	return [[FileUtil alloc] init];
}

/**
 * Error listener delegate.
 */
-(BOOL)fileManager:(NSFileManager *)manager shouldProceedAfterError:(NSDictionary *)errorInfo {
	//DebugLog(@"Possible error: %@", errorInfo);
	return NO;
}

//- (void)fileManager:(NSFileManager *)manager willProcessPath:(NSString *)path { }
@end
