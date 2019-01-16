//
//  AFN.h
//  Ilincar
//
//  Created by 单维龙 on 15/11/25.
//  Copyright © 2015年 com.ilincar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


typedef void (^GetAFN) (id responseObject, NSString *errorMsg);


@interface AFN : NSObject

+ (NSString *)toJSONString:(id)theData;

+ (AFHTTPRequestOperation *)uploadImageWithUrl:(NSString *)url parameters:(NSDictionary *)parameters image:(UIImage *)image currentView:(UIView *)currentView completion:(void(^)(id responseObject, NSString *errorMsg))block;


//  网络请求数据
+ (void)setPostWithUrl:(NSString *)urlStr parameters:(NSDictionary *)parameters currentView:(UIView *)currentView getAFNdata:(GetAFN)getAFNdata;


//  网络请求数据成功回调方法
+ (void)setPostWithUrl:(NSString *)urlStr parameters:(NSDictionary *)parameters currentView:(UIView *)currentView getAFNdata:(GetAFN)getAFNdata success:(void (^)(AFHTTPRequestOperation * operation,id responseObject))success;


/**
 *
 *同步请求
 */
+(NSString*)synGETwithURL:(NSString*)strurl;
@end
