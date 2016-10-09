//
//  CCMeetListingRequest.m
//  24HMB
//
//  Created by 24hmb on 16/3/25.
//  Copyright © 2016年 24hmb. All rights reserved.
//

#import "CCMeetListingRequest.h"

@interface CCNetRequest (manager)
+(AFHTTPSessionManager *)manager;
@end

@implementation CCNetRequest (manager)

+(AFHTTPSessionManager *)manager{
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager *_manager;
    dispatch_once(&onceToken, ^
                  {
                      _manager = [AFHTTPSessionManager manager];
                      //_manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                      _manager.requestSerializer.timeoutInterval = 10.f;
                  });
    return _manager;
    
}


@end

static CCNetRequest *MeetRequest = nil;

@interface CCNetRequest ()

//@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation CCNetRequest


+ (void)cancelAllHttpRequestByApiPath:(NSString *)path{
    CCMeetListingRequest.manager.operationQueue.suspended = YES;
    [CCMeetListingRequest.manager.operationQueue cancelAllOperations];
}

+ (void)httpsRequestWithBaseUrl:(NSString *)baseUrl
                     parameters:(id)parameters
                    certificate:(NSString *)certificate
                        success:(successCallback)success
                        failure:(failureCallback)failure {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificate ofType:@"cer"];
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    securityPolicy.pinnedCertificates = [NSSet setWithObject:cerData];
    [CCNetRequest.manager POST:baseUrl parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"parameters === %@\nrequestURL === %@\n  responeObject == %@",parameters,baseUrl,responseObject);
        if ([responseObject[@"code"] integerValue] == 0) {
            success(task,responseObject);
        }else{
            NSError *error = [NSError errorWithDomain:responseObject[@"message"] code:0 userInfo:nil];
            NSLog(@"parameters === %@\nrequestURL === %@\nerror == %@",parameters,baseUrl,error);
            failure(task,error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"parameters === %@\nrequestURL === %@\nerror == %@",parameters,baseUrl,error);
        failure(task,error);
    }];
}

+ (void)postWithBaseUrl:(NSString *)baseUrl
            parameters:(id)parameters
                success:(successCallback)success
                failure:(failureCallback)failure{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [CCNetRequest.manager POST:baseUrl parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"parameters === %@\nrequestURL === %@\n  responeObject == %@",parameters,baseUrl,responseObject);
        if ([responseObject[@"code"] integerValue] == 0) {
            success(task,responseObject);
        }else{
            NSError *error = [NSError errorWithDomain:responseObject[@"message"] code:0 userInfo:nil];
            NSLog(@"parameters === %@\nrequestURL === %@\nerror == %@",parameters,baseUrl,error);
            failure(task,error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"parameters === %@\nrequestURL === %@\nerror == %@",parameters,baseUrl,error);
        failure(task,error);
    }];
}

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
               failure:(failureCallback)failure{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [CCNetRequest.manager GET:baseUrl parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"parameters === %@\nrequestURL === %@\n  responeObject == %@",parameters,baseUrl,responseObject);
        if ([responseObject[@"code"] integerValue] == 0) {
            success(task,responseObject);
        }else{
            NSError *error = [NSError errorWithDomain:responseObject[@"message"] code:0 userInfo:nil];
            NSLog(@"parameters === %@\nrequestURL === %@\nerror == %@",parameters,baseUrl,error);
            failure(task,error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"parameters === %@\nrequestURL === %@\nerror == %@",parameters,baseUrl,error);
        failure(task,error);
    }];
}

@end
