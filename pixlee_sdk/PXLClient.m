//
//  PXLClient.m
//  pixlee-ios-sdk
//
//  Created by Tim Shi on 4/30/15.
//
//

#import "PXLClient.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>


@interface PXLClient ()

@property (nonatomic, copy) NSString *_apiKey;
@property (nonatomic, copy) NSString *_secretKey;

@end

@implementation PXLClient

static NSString * const PXLClientBaseUrlString = @"https://distillery.pixlee.com/api/v2/";

+ (instancetype)sharedClient {
    static PXLClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:PXLClientBaseUrlString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

- (void)setApiKey:(NSString *)apiKey {
    self._apiKey = apiKey;
}

- (void)setSecretKey:(NSString *)secretKey {
    self._secretKey = secretKey;
}



- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters  progress:(void (^)(NSProgress * _Nonnull))downloadProgress  success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    NSAssert(self._apiKey != nil, @"Your Pixlee API Key must be set before making API calls.");
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    if (parameters == nil || [parameters isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutableParams = parameters ? ((NSDictionary *)parameters).mutableCopy : @{}.mutableCopy;
        mutableParams[@"api_key"] = self._apiKey;
        parameters = mutableParams;
    }
    return [super GET:URLString parameters:parameters progress:nil success:success failure:failure];
}


- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters  progress:(void (^)(NSProgress * _Nonnull))downloadProgress  success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    self.requestSerializer = serializer;
    
    NSAssert(self._apiKey != nil, @"Your Pixlee API Key must be set before making API calls.");
    if (parameters == nil || [parameters isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutableParams = parameters ? ((NSDictionary *)parameters).mutableCopy : @{}.mutableCopy;
        mutableParams[@"API_KEY"] = self._apiKey;
        parameters = mutableParams;
    }
    if(self._secretKey){
        //Conver the params into json string -> the payload
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters
                                                           options:0
                                                             error:&error];
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        //Conver the params into json string -> the payload
        const char *cKey  = [self._secretKey cStringUsingEncoding:NSASCIIStringEncoding];
        const char *cData = [jsonString cStringUsingEncoding:NSASCIIStringEncoding];
        unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
        
        CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
        NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                              length:sizeof(cHMAC)];
        
        NSString *hash = [HMAC base64EncodedStringWithOptions:0];
        
        NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
        NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
        
        [self.requestSerializer setValue:hash forHTTPHeaderField:@"Signature"];
        [self.requestSerializer setValue: [timeStampObj stringValue] forHTTPHeaderField:@"X-Authorization-Timestamp"];
        [self.requestSerializer setValue: jsonString forHTTPHeaderField:@"X-Authorization"];
    
    }
    return [super POST:URLString parameters:parameters progress:nil success:success failure:failure];
}


@end
