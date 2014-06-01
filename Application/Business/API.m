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
#import "LoginVC.h"
@implementation API

+ (AFHTTPRequestOperation *)login:(NSString*)loginID
                              pwd:(NSString*)pwd
                          success:(void (^)(id data))success
                         failture:(void (^)(NSError *error))failture{
    NSDictionary* params = @{@"logincode":loginID,@"userpass":pwd};
    AFHTTPRequestOperation* oper =[[ReqManager sharedManager] postWithPath:@"api/login" signParameters:nil parameters:params success:^(APIResponse* obj) {
        if (obj.code==0) {
            SAFE_BLOCK_CALL(success,obj.data);
        }else{
            NSError* error =[NSError errorWithMsg:obj.msg code:obj.code];
            SAFE_BLOCK_CALL(failture,error);
        }
    } failture:^(NSError *error) {
        SAFE_BLOCK_CALL(failture,error);
    }];
    return oper;
}

+(AFHTTPRequestOperation *)logOutWithsuccess:(void (^)(id data))success
                                    failture:(void (^)(NSError *error))failture{
    [LoginVC logout];
    SAFE_BLOCK_CALL(success,nil);
    
    return  nil;
    
}

@end
