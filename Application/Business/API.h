//
//  API.h
//  MagShow
//
//  Created by loufq on 14-5-31.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BaseUrl() (@"http://localhost:3000/")
@class APIResponse;

@interface API : NSObject

+ (AFHTTPRequestOperation *)login:(NSString*)loginID
                              pwd:(NSString*)pwd
                          success:(void (^)(id data))success
                         failture:(void (^)(NSError *error))failture;

+(AFHTTPRequestOperation *)logOutWithsuccess:(void (^)(id data))success
                                    failture:(void (^)(NSError *error))failture;


@end
