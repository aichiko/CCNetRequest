//
//  CCMeetListingRequest.h
//  24HMB
//
//  Created by 24hmb on 16/3/25.
//  Copyright © 2016年 24hmb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successCallback)(NSURLSessionDataTask *task, NSDictionary *responseObject);

typedef void(^failureCallback)(NSURLSessionDataTask *task, NSError *error);

@interface CCNetRequest : NSObject

/**
 *  取消所有的网络数据请求
 *cancel all http request
 *
 *  @param path
 */
+ (void)cancelAllHttpRequestByApiPath:(NSString *)path;

/**
 *  https请求
 *
 *  @param baseUrl    请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功
 *  @param failure    请求失败
 */
+ (void)httpsRequestWithBaseUrl:(NSString *)baseUrl
                     parameters:(id)parameters
                    certificate:(NSString *)certificate
                        success:(successCallback)success
                        failure:(failureCallback)failure;


/**
 *  post请求 
 *
 *  @param parameters 参数
 *  @param success    请求成功
 *  @param failure    请求失败
 */
+ (void)postWithBaseUrl:(NSString *)baseUrl
            parameters:(id)parameters
                success:(successCallback)success
                failure:(failureCallback)failure;

/**
 *  get请求
 *
 *  @param parameters 参数
 *  @param success    请求成功
 *  @param failure    请求失败
 */
+ (void)getWithBaseUrl:(NSString *)baseUrl
             parameters:(id)parameters
               success:(successCallback)success
               failure:(failureCallback)failure;

@end
