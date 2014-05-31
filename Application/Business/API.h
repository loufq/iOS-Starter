//
//  API.h
//  MagShow
//
//  Created by loufq on 14-5-31.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API : NSObject

+ (AFHTTPRequestOperation *)login:(NSString*)loginID
                              pwd:(NSString*)pwd
                          success:(void (^)(id obj))success
                         failture:(void (^)(NSError *error))failture;

+(AFHTTPRequestOperation *)logOutWithsuccess:(void (^)(id obj))success
                                    failture:(void (^)(NSError *error))failture;


@end
