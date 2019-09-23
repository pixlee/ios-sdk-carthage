//
//  PXLAppDelegate.m
//  pixlee-ios-sdk
//
//  Created by CocoaPods on 04/30/2015.
//

#import "PXLAppDelegate.h"

#import <pixlee_sdk/PXLClient.h>
#import <pixlee_sdk/pixlee_sdk.h>
#import <pixlee_sdk/PXLClient.h>
#import <pixlee_sdk/PXLAlbum.h>

@implementation PXLAppDelegate

#warning Replace with your Pixlee API key.
static NSString * const PXLClientAPIKey = @"Hz7VLPHt7ow-oY992rJi";
#warning Replace with your Secret Key if you are making POST requests.
static NSString * const PXLCLIENTSECRETKEY = @"";


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[PXLClient sharedClient] setApiKey:PXLClientAPIKey];
    [[PXLClient sharedClient] setSecretKey:PXLCLIENTSECRETKEY];
    return YES;
}

@end
