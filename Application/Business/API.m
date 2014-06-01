//
//  API.m
//  MagShow
//
//  Created by loufq on 14-5-31.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "API.h"
#import "ReqManager.h"
#import "APIResponse.h"

@implementation API

+ (AFHTTPRequestOperation *)login:(NSString*)loginID
                              pwd:(NSString*)pwd
                          success:(void (^)(APIResponse* res))success
                         failture:(void (^)(NSError *error))failture{
    NSDictionary* params = @{@"logincode":loginID,@"userpass":pwd};
    AFHTTPRequestOperation* oper =[[ReqManager sharedManager] postWithPath:@"api/login" signParameters:nil parameters:params success:^(APIResponse* obj) {
        SAFE_BLOCK_CALL(success,obj);
    } failture:^(NSError *error) {
        SAFE_BLOCK_CALL(failture,error);
    }];
    return oper;
}

+(AFHTTPRequestOperation *)logOutWithsuccess:(void (^)(APIResponse* res))success
                                    failture:(void (^)(NSError *error))failture{
    return  nil;
    
}

@end
