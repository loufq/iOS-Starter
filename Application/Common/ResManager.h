//
//  ResManager.h
//  WQMobile
//
//  Created by loufq on 11-12-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define skinImage(_path) ([ResManager getSkinImage:_path])



@class AppResManager;


@interface ResManager : NSObject

+(UIImage*)getBgImage;

//基础目录--需要各个应用自己覆盖
+(NSString *) navDocumentPath;
+(NSString *) documentPath;
//get Image
+(UIImage *)getSkinImage:(NSString*)aPath;
+(UIImage *)getResImage:(NSString*)aPath;

//get Content
+(NSString *)getContentAtNavPath:(NSString*)aPath;
//getPath-form vedio media and others...
+(NSString *)atNavDocumentPath:(NSString*)aPath;
//读取路径
+(NSString *)atDocumentPath:(NSString*)aShortPath;




@end
