//
//  API.m
//  MagShow
//
//  Created by loufq on 14-5-31.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "API.h"
#import "ReqManager.h"

#define BaseUrl() (@"http://fhylml.qiniudn.com/")
#define ApiUrl(name) ([NSString stringWithFormat:@"http://fhylml.qiniudn.com/%@",name])

@implementation API

+ (AFHTTPRequestOperation *)login:(NSString*)loginID
                              pwd:(NSString*)pwd
                          success:(void (^)(id obj))success
                         failture:(void (^)(NSError *error))failture{
    
    NSDictionary* params = @{@"logincode":loginID,@"userpass":pwd};
    
    AFHTTPRequestOperation* oper =[[ReqManager sharedManager] postWithPath:@"ParkingApi/api/security" signParameters:nil parameters:params success:^(id obj) {
        SAFE_BLOCK_CALL(success,obj);
    } failture:^(NSError *error) {
        SAFE_BLOCK_CALL(failture,error);
    }];
    return oper;
}

+(AFHTTPRequestOperation *)logOutWithsuccess:(void (^)(id obj))success
                                    failture:(void (^)(NSError *error))failture{
    return  nil;

}

@end
