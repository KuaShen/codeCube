//
//  AFN.m
//  Ilincar
//
//  Created by 单维龙 on 15/11/25.
//  Copyright © 2015年 com.ilincar. All rights reserved.
//

#import "AFN.h"
#import "MBProgressHUD.h"

@implementation AFN

+ (void)setPostWithUrl:(NSString *)urlStr parameters:(NSDictionary *)parameters currentView:(UIView *)currentView getAFNdata:(GetAFN)getAFNdata success:(void (^)( AFHTTPRequestOperation * operation,id responseObject))success{


//    MBProgressHUD *flashHud = [MBProgressHUD showHUDAddedTo:currentView animated:YES];
//    flashHud.removeFromSuperViewOnHide = YES;
//    flashHud.userInteractionEnabled = NO;
    //    [self checkNetWorkStatus:currentView];
    
    /******************************  本地缓存设置  *********************************************/
    
    //本地缓存设置，沙盒路径设置
    NSArray *path =NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    NSString *pathString =path.lastObject;
    
    NSString *pathLast =[NSString stringWithFormat:@"/Caches/com.hackemist.SDWebImageCache.default/%lu.text", (unsigned long)[urlStr hash]];
    //创建字符串文件存储路径
    NSString *PathName =[pathString stringByAppendingString:pathLast];
    

    
    
    
    /**********************************  网络请求设置  ******************************************/
    
    
    
    AFNetworkReachabilityManager *netWorkManager = [AFNetworkReachabilityManager sharedManager];
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/x-javascript",nil];
    
    
    
    /**
     *  cookie设置
     */
    NSURL *dataUrl = [NSURL URLWithString:urlStr];
    
    NSArray *arcCookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"sessionCookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in arcCookies){
        [cookieStorage setCookie: cookie];
    }
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:dataUrl];//id:NSHTTPCookie
    
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject:cookies];
    
    NSString *cookiesString = [[NSString alloc] initWithData:cookiesData encoding:NSUTF8StringEncoding];
    
    /**
     *  POST请求Content-Type设定
     */
    
    NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    /**
     *  获取设备UUID号
     */
    
//    NSString *clientId = [SSKeychain passwordForService:@"com.ilincar.ilincar" account:@"ilincar"];
    
//    if (clientId == nil) {
//        
//        clientId = [[NSUserDefaults standardUserDefaults] objectForKey:@"clientId"];
//        
//    }
    // 设置请求格式
    [manager.requestSerializer setValue:cookiesString forHTTPHeaderField:@"Cookie"];
//    [manager.requestSerializer setValue:APP_VERSION forHTTPHeaderField:@"appVer"];
    [manager.requestSerializer setValue:@"ios"  forHTTPHeaderField:@"os"];
//    [manager.requestSerializer setValue:clientId forHTTPHeaderField:@"clientId"];
    [manager.requestSerializer setValue:@"A001" forHTTPHeaderField:@"channelID"];
    [manager.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"app_version"];
    [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"updateType"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
    
    
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    //url地址转UTF8
    NSString *url = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
#pragma mark parameters转JSONString，此处根据后台所需数据来自行转换
    
    /**
     *  parameters body转JSONString，此处根据后台所需数据来自行转换
     */
    NSString *parametersJSONString = [self toJSONString:parameters];
    
    
    /**
     *  jsondata 设置
     */
    NSDictionary *parametersDictionary = [[NSDictionary alloc] init];
    if (nil != parametersJSONString) {
        
        parametersDictionary = @{@"jsondata":parametersJSONString};
        
    } else {
        

    }
    
    
    /**
     *  网络请求
     */
    [manager POST:url parameters:parametersDictionary success:^(AFHTTPRequestOperation * operation, id responseObject) {

        
        
        
//        [flashHud hide:YES];
        
        
        /**
         *  cookie存储
         */
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
     
        
        NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject:cookies];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: cookiesData forKey: @"sessionCookies"];
        [defaults synchronize];
        
        
        
        [netWorkManager stopMonitoring];
        
        
        
        
        
        
        //返回为数组或字典的调用这个方法
        //        block(responseObject);
        //        responseObject = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        //        [result writeToFile:PathName atomically:YES];
        
        
        //返回值为UTF8编码的，调用这个方法
        NSString *resultString = [operation.responseString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        /**
         *  网络请求成功回调，写入本地缓存
         */
        [resultString writeToFile:PathName atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        NSData *jsonData = [resultString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        
#pragma mark - 网络请求错误信息
        NSString *errorMsg = [result objectForKey:@"errorMsg"];
        
        if (![errorMsg isEqual:[NSNull null]]) {
            
            if (![errorMsg isEqualToString:@""]) {
                
           
                
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:currentView animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = errorMsg;
                hud.margin = 15.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1.5];
                
            }
            
        }
   
       getAFNdata(result, errorMsg);
        //成功调用此block
        if ([[result objectForKey:@"resultCode"] isEqual:@"00"]) {
         success(operation,responseObject);
        }
        
       } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
//        [flashHud hide:YES];
        
        NSString * cachePath = PathName;
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
            
            
            id responseObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:PathName] options:NSJSONReadingMutableContainers error:nil];
            
            NSString *errorMsg = [responseObject objectForKey:@"errorMsg"];
            
            
            getAFNdata(responseObject, errorMsg);
            
        }
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:currentView animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"未能连接到服务器\n请检查网络设置并重试";
        hud.margin = 15.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
        
  
    }];
    



}


#pragma mark - POST请求
+ (void)setPostWithUrl:(NSString *)urlStr parameters:(NSDictionary *)parameters currentView:(UIView *)currentView getAFNdata:(GetAFN)getAFNdata {
    
    
//    MBProgressHUD *flashHud = [MBProgressHUD showHUDAddedTo:currentView animated:YES];
//    flashHud.removeFromSuperViewOnHide = YES;
//    flashHud.userInteractionEnabled = NO;
//    [self checkNetWorkStatus:currentView];
    
    
    
    /******************************  本地缓存设置  *********************************************/
    
    //本地缓存设置，沙盒路径设置
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    NSString *pathString =path.lastObject;
    
    NSString *pathLast = [NSString stringWithFormat:@"/Caches/com.hackemist.SDWebImageCache.default/%lu.text", (unsigned long)[urlStr hash]];
    //创建字符串文件存储路径
    NSString *PathName =[pathString stringByAppendingString:pathLast];
    

    
    
    
    /**********************************  网络请求设置  ******************************************/
    
    
    
    AFNetworkReachabilityManager *netWorkManager = [AFNetworkReachabilityManager sharedManager];
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/x-javascript",nil];
    
    
    
    /**
     *  cookie设置
     */
    NSURL *dataUrl = [NSURL URLWithString:urlStr];
    
    NSArray *arcCookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"sessionCookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in arcCookies){
        [cookieStorage setCookie: cookie];
    }
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:dataUrl];//id:NSHTTPCookie
    
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject:cookies];
    
    NSString *cookiesString = [[NSString alloc] initWithData:cookiesData encoding:NSUTF8StringEncoding];
    
    /**
     *  POST请求Content-Type设定
     */
    
    NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    /**
     *  获取设备UUID号
     */
    
//    NSString *clientId = [SSKeychain passwordForService:@"com.ilincar.ilincar" account:@"ilincar"];
    
//    if (clientId == nil) {
//        
//        clientId = [[NSUserDefaults standardUserDefaults] objectForKey:@"clientId"];
//        
//    }

    
    // 设置请求格式
    [manager.requestSerializer setValue:cookiesString forHTTPHeaderField:@"Cookie"];
//    [manager.requestSerializer setValue:APP_VERSION forHTTPHeaderField:@"appVer"];
    [manager.requestSerializer setValue:@"ios"  forHTTPHeaderField:@"os"];
//    [manager.requestSerializer setValue:clientId forHTTPHeaderField:@"clientId"];
    [manager.requestSerializer setValue:@"A001" forHTTPHeaderField:@"channelID"];
    [manager.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"app_version"];
    [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"updateType"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
    
    
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    //url地址转UTF8
    NSString *url = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
#pragma mark parameters转JSONString，此处根据后台所需数据来自行转换
    
    /**
     *  parameters body转JSONString，此处根据后台所需数据来自行转换
     */
    NSString *parametersJSONString = [self toJSONString:parameters];
    
    
    /**
     *  jsondata 设置
     */
    NSDictionary *parametersDictionary = [[NSDictionary alloc] init];
    if (nil != parametersJSONString) {
        
        parametersDictionary = @{@"jsondata":parametersJSONString};
        
    } else {
        

    }
        

    
    /**
     *  网络请求
     */
    [manager POST:url parameters:parametersDictionary success:^(AFHTTPRequestOperation * operation, id responseObject) {
        

        
        
        
//        [flashHud hide:YES];
        
        
        /**
         *  cookie存储
         */
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
//        for (NSHTTPCookie *cookie in cookies) {
//            // Here I see the correct rails session cookie

//        }
        
        NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject:cookies];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: cookiesData forKey: @"sessionCookies"];
        [defaults synchronize];
        
        
        
        [netWorkManager stopMonitoring];
        
        
        
     
        
        
        //返回为数组或字典的调用这个方法
        //        block(responseObject);
        //        responseObject = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        //        [result writeToFile:PathName atomically:YES];
        
        
        //返回值为UTF8编码的，调用这个方法
        NSString *resultString = [operation.responseString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        /**
         *  网络请求成功回调，写入本地缓存
         */
        [resultString writeToFile:PathName atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        NSData *jsonData = [resultString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        
#pragma mark - 网络请求错误信息
        NSString *errorMsg = [result objectForKey:@"errorMsg"];
        
        if (![errorMsg isEqual:[NSNull null]]) {
            
            if (![errorMsg isEqualToString:@""]) {
                
                
//                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:currentView animated:YES];
//                hud.mode = MBProgressHUDModeText;
//                hud.labelText = [errorMsg stringByReplacingOccurrencesOfString:@"增加或者消费积分失败002" withString:@"领取积分失败"];
//                hud.margin = 15.f;
//                hud.removeFromSuperViewOnHide = YES;
//                [hud hide:YES afterDelay:1.5];
       
            }
            
        }
 

        getAFNdata(result, errorMsg);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
//        [flashHud hide:YES];

        NSString * cachePath = PathName;
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
            
            
            id responseObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:PathName] options:NSJSONReadingMutableContainers error:nil];
            
            NSString *errorMsg = [responseObject objectForKey:@"errorMsg"];
            
            
            getAFNdata(responseObject, errorMsg);
            
        }
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:currentView animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"未能连接到服务器\n请检查网络设置并重试";
        hud.margin = 15.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];

    }];
    
    
}







#pragma mark - 上传图片

+ (AFHTTPRequestOperation *)uploadImageWithUrl:(NSString *)urlStr parameters:(NSDictionary *)parameters image:(UIImage *)image currentView:(UIView *)currentView completion:(void(^)(id responseObject, NSString *errorMsg))block {

    /**
     *  cookie设置
     */
    NSURL *dataUrl = [NSURL URLWithString:urlStr];
    
    
    NSArray *arcCookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"sessionCookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in arcCookies){
        [cookieStorage setCookie: cookie];
    }
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:dataUrl];//id:NSHTTPCookie
    
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject:cookies];
    
    NSString *cookiesString = [[NSString alloc] initWithData:cookiesData encoding:NSUTF8StringEncoding];

    
    
    
    /**
     *  AFHTTPRequestOperationManager设置
     */
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    /**
     *  获取设备UUID号
     */
//    NSString *clientId = [SSKeychain passwordForService:@"com.ilincar.ilincar" account:@"ilincar"];
    /**
     *  上传Content-Type设定
     */
    NSString *stringBoundary = @"----------";
    
    // 设置请求格式
    [manager.requestSerializer setValue:cookiesString forHTTPHeaderField:@"Cookie"];
//    [manager.requestSerializer setValue:clientId forHTTPHeaderField:@"clientId"];
//    [manager.requestSerializer setValue:APP_VERSION forHTTPHeaderField:@"appVer"];
    [manager.requestSerializer setValue:@"ios"  forHTTPHeaderField:@"os"];
    [manager.requestSerializer setValue:@"A001" forHTTPHeaderField:@"channelID"];
    [manager.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"app_version"];
    [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"updateType"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", stringBoundary] forHTTPHeaderField:@"Content-Type"];
    
    
    
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    //url地址转UTF8
    NSString *url = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
#pragma mark parameters转JSONString，此处根据后台所需数据来自行转换
    
    /**
     *  parameters body转JSONString，此处根据后台所需数据来自行转换
     */
    NSString *parametersJSONString = [self toJSONString:parameters];
    
    //jsondata 设置
    NSDictionary *parametersDictionary = [[NSDictionary alloc] init];
    if (nil != parametersJSONString) {
        
        parametersDictionary = @{@"jsondata":parametersJSONString};
        
    } else {
        

    }
    
   
    AFHTTPRequestOperation *op = [manager POST:url parameters:parametersDictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSData *imageData = UIImagePNGRepresentation(image);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"png"];
 
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //返回值为UTF8编码的，调用这个方法
        NSString *resultString = [operation.responseString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSData *jsonData = [resultString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
#pragma mark - 网络请求错误信息
        NSString *errorMsg = [result objectForKey:@"errorMsg"];
        
        if (![errorMsg isEqual:[NSNull null]]) {
            
            if (![errorMsg isEqualToString:@""]) {
                

                
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:currentView animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = errorMsg;
                hud.margin = 15.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1.5];
                
            }
        }
        

        
        block(result, errorMsg);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:currentView animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"未能连接到服务器\n请检查网络设置";
        hud.margin = 15.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.5];
        
        
    }];
    
    return op;  
}

#pragma mark - 转成JSONString
+ (NSString *)toJSONString:(id)theData{
    
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (jsonString != nil && error == nil){
        
        return jsonString;
        
    }else{
        
        return nil;
        
    }
}




#pragma mark - 检查网络状态
+ (void)checkNetWorkStatus:(UIView *)currentView {
    
    /**
     *  AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     *  AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     *  AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
     *  AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络Wifi
     */
    
    // 如果要检测网络状态的变化, 必须要用检测管理器的单例startMoitoring
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusNotReachable){
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:currentView animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"网络连接已断开\n请检查您的网络设置";
            hud.margin = 15.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1.5];
            
            

            return ;
        }
    }];
    
}

//同步get请求
+(NSString*)synGETwithURL:(NSString*)strurl{

    //首先创建请求的url
    NSURL * url = [NSURL URLWithString:strurl];
    //创建请求对象：(同时对请求对象的缓存和超时时间的设置)
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    
    //添加header
    NSMutableURLRequest *mutableRequest = [request mutableCopy];    //拷贝request
//    [mutableRequest addValue:APP_VERSION forHTTPHeaderField:@"appVer"];
    [mutableRequest addValue:@"ios"  forHTTPHeaderField:@"os"];
    request = [mutableRequest copy];        //拷贝回去
    /**********************************************/
   // NSLog(@"%@", request.allHTTPHeaderFields);
    //发送请求 并得到响应。
    //创建服务端回应的对象
    NSHTTPURLResponse * response = nil;
    NSData * returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString * returnStr = [[NSString alloc]initWithData:returnData encoding:4];
   
    return returnStr;
    
    
}



@end
