//
//  ReqHelper.h
//  TollCollector
//
//  Created by loufq on 14-3-22.
//  Copyright (c) 2014年 loufq. All rights reserved.
//

#import <Foundation/Foundation.h>
#define Error_Code_Password_reseted 10001
#define Error_Code_Need_Relogin 10002
@interface ReqManager : NSObject

+(id)sharedManager;
//GET
-(AFHTTPRequestOperation*)getWithPath:(NSString*)path
                           signParameters:(NSDictionary*)parameters
                           parameters:(NSDictionary*)parameters
                              success:(void (^)(id obj))success
                             failture:(void (^)(NSError *error))failture;
//POST
-(AFHTTPRequestOperation*)postWithPath:(NSString*)path
                        signParameters:(NSDictionary*)parameters
                            parameters:(NSDictionary*)parameters
                               success:(void (^)(id obj))success
                              failture:(void (^)(NSError *error))failture;
//Delete
-(AFHTTPRequestOperation*)deleteWithPath:(NSString*)path
                          signParameters:(NSDictionary*)signParameters
                              parameters:(NSDictionary*)parameters
                                 success:(void (^)(id obj))success
                                failture:(void (^)(NSError *error))failture;
//PUT
-(AFHTTPRequestOperation*)putWithPath:(NSString*)path
                       signParameters:(NSDictionary*)signParameters
                           parameters:(NSDictionary*)parameters
                              success:(void (^)(id obj))success
                             failture:(void (^)(NSError *error))failture;

//common req
-(AFHTTPRequestOperation*)requestWithMethod:(NSString*)method
                                       path:(NSString*)path
                             signParameters:(NSDictionary*)signParameters
                                 parameters:(NSDictionary*)parameters
                                    success:(void (^)(id obj))success
                                   failture:(void (^)(NSError *error))failture;
-(AFHTTPRequestOperation*)requestWithMethod:(NSString*)method
                                       path:(NSString*)path
                             signParameters:(NSDictionary*)signParameters
                                 parameters:(NSDictionary*)parameters
                                      image:(UIImage*)image
                                    success:(void (^)(id obj))success
                                   failture:(void (^)(NSError *error))failture;



@end
