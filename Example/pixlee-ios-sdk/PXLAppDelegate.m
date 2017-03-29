//
//  PXLAppDelegate.m
//  pixlee-ios-sdk
//
//  Created by CocoaPods on 04/30/2015.
//

#import "PXLAppDelegate.h"

#import <sdk/PXLClient.h>
#import <sdk/PXLAlbum.h>

@implementation PXLAppDelegate

#warning Replace with your Pixlee API key.
static NSString * const PXLClientAPIKey = @"zk4wWCOaHAo4Hi8HsE";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[PXLClient sharedClient] setApiKey:PXLClientAPIKey];
    return YES;
}

@end
