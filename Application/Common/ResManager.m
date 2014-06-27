//
//  ResManager.m
//  WQMobile
//
//  Created by loufq on 11-12-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ResManager.h"
#import "MacroFunctions.h"
@implementation ResManager

#define DOCUMENTS_DIR ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject])
//app 存储应用自带的打包资源目录 
+(NSString*)navDocumentPath{
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Documents"];
}
    //app 存储内容的目录，区别系统的document目录，考虑iClound备份的情况
+ (NSString *)documentPath{ 
	return DOCUMENTS_DIR;
}


+(UIImage*)getSkinImage:(NSString*)aPath{
    NSString* skinName = [[NSUserDefaults standardUserDefaults] objectForKey:@"skin_name"];
    if (!skinName.length) {
        skinName =@"default";
        [[NSUserDefaults standardUserDefaults] setObject:skinName forKey:@"skin_name"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    NSString* path =  [[[self navDocumentPath] stringByAppendingPathComponent:MF_SWF(@"skin/%@/",skinName)] stringByAppendingPathComponent:aPath];
    if (![path containsString:@"@2x"]) {
        path = [path stringByAppendingString:@"@2x.png"];
    }
    UIImage* img =[UIImage imageWithContentsOfFile:path];
    return img;
}

+(UIImage*)getResImage:(NSString*)aPath{
    NSString* path =  [self atDocumentPath:aPath];
    return [UIImage imageWithContentsOfFile:path];
}


+(NSString*)atNavDocumentPath:(NSString*)aPath{
    NSString* path =  [[self navDocumentPath] stringByAppendingPathComponent:aPath];    
    return path;
}

+(NSString *)atDocumentPath:(NSString*)aShortPath{
    return [[self documentPath] stringByAppendingPathComponent:aShortPath];
}

+(NSString *)getContentAtNavPath:(NSString*)aPath{ 
    NSString* path =[[self navDocumentPath] stringByAppendingPathComponent:aPath];
    NSString* c =[NSString stringWithContentsOfFile:path encoding:4 error:nil];
    return c;
}

+(UIImage*)getBgImage{
 
    return [UIImage imageNamed:@"LaunchImage-700-Landscape~ipad.png"];
}
@end
