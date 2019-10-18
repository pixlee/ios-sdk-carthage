//
//  PXLClient.h
//  Pods
//
//  Created by Mohamed Rachidi on 10/14/19.
//

#ifndef PXLClient_h
#define PXLClient_h


#endif /* PXLClient_h */


#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

/**
 `PXLClient` wraps the Pixlee API and is used by `PXLAlbum` to load photos from the server. You must set the API Key before making any API calls.
 */

@interface PXLClient : AFHTTPSessionManager

/**
 Creates and returns the singleton `PXLClient` instance.
 */
+ (instancetype)sharedClient;

/**
 Sets the API Key for communicating with the Pixlee servers.
 
 @warning You must set the API Key before making calls to the Pixlee API.
 
 @param apiKey The API key used to access your albums.
 */
- (void)setApiKey:(NSString *)apiKey;


/**
 Sets the Secret Key for communicating with the Pixlee servers.
 
 @warning If you are making POST Request to the Pixlee API You must set the Secret Key.
 
 @param secretKey The secret key used to sign your payloads for POST calls.
 */
- (void)setSecretKey:(NSString *)secretKey;
@end
