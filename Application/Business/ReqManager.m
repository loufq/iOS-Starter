//
//  ReqHelper.m
//  TollCollector
//
//  Created by loufq on 14-3-22.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import "ReqManager.h"

#import "AFURLRequestSerialization.h"
#import "APIResponse.h"


@interface ReqManager(){
}
@property(strong)AFHTTPRequestOperationManager *manager;
@end

@implementation ReqManager
static ReqManager* obj;

+(id)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj =[[ReqManager alloc] init];
        obj.manager =  [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://localhost:3000/"]];
        [obj.manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    });
    return obj;
}

-(AFHTTPRequestOperation*)requestWithMethod:(NSString*)method
                                       path:(NSString*)path
                             signParameters:(NSDictionary*)signParameters
                                 parameters:(NSDictionary*)parameters
                                      image:(UIImage*)image
                                    success:(void (^)(id obj))success
                                   failture:(void (^)(NSError *error))failture{
    if (!parameters.allKeys.count) {
        parameters = nil;
    }
    NSMutableURLRequest *request=nil;
    if (!image) {
        request = [self.manager.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:path relativeToURL:self.manager.baseURL] absoluteString] parameters:parameters error:nil];
    }else if (image) {
        request = [self.manager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:path relativeToURL:self.manager.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSData* data = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:data
                                        name:@"media[]"
                                    fileName:@"upload.jpg"
                                    mimeType:@"image/jpeg"];
        } error:nil];
    }
    
    AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success([APIResponse create:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSInteger statusCode = [[operation response] statusCode];
        failture(error);
    }];
    [self.manager.operationQueue addOperation:operation];
    return operation;
}


-(AFHTTPRequestOperation*)requestWithMethod:(NSString*)method
                                       path:(NSString*)path
                             signParameters:(NSDictionary*)signParameters
                                 parameters:(NSDictionary*)parameters
                                    success:(void (^)(id obj))success
                                   failture:(void (^)(NSError *error))failture{
    return [self requestWithMethod:method path:path signParameters:signParameters parameters:parameters image:nil success:success failture:failture];
}



-(AFHTTPRequestOperation*)getWithPath:(NSString*)path
                       signParameters:(NSDictionary*)signParameters
                           parameters:(NSDictionary*)parameters
                              success:(void (^)(id obj))success
                             failture:(void (^)(NSError *error))failture{
    return [self requestWithMethod:@"GET" path:path signParameters:signParameters parameters:parameters success:success failture:failture];
}

-(AFHTTPRequestOperation*)deleteWithPath:(NSString*)path
                          signParameters:(NSDictionary*)signParameters
                              parameters:(NSDictionary*)parameters
                                 success:(void (^)(id obj))success
                                failture:(void (^)(NSError *error))failture{
    return [self requestWithMethod:@"DELETE" path:path signParameters:signParameters parameters:parameters success:success failture:failture];
}

-(AFHTTPRequestOperation*)postWithPath:(NSString*)path
                        signParameters:(NSDictionary*)signParameters
                            parameters:(NSDictionary*)parameters
                               success:(void (^)(id obj))success
                              failture:(void (^)(NSError *error))failture{
    return [self requestWithMethod:@"POST" path:path signParameters:signParameters
                        parameters:parameters success:success failture:failture];
}
-(AFHTTPRequestOperation*)putWithPath:(NSString*)path
                       signParameters:(NSDictionary*)signParameters
                           parameters:(NSDictionary*)parameters
                              success:(void (^)(id obj))success
                             failture:(void (^)(NSError *error))failture{
    return [self requestWithMethod:@"PUT" path:path signParameters:signParameters
                        parameters:parameters success:success failture:failture];
}



-(NSError*)parseCommonError:(NSDictionary*)rObject{
    if ([[rObject valueForKeyPath:@"Result.ResultCode"] isEqualToString:@"successed"]) {
        return nil;
    }
    return [NSError errorWithMsg:[rObject valueForKeyPath:@"Result.ResultMsg"]];
}



@end
