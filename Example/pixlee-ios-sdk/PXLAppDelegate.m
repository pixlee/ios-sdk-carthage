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
static NSString * const PXLClientAPIKey = @"zk4wWCOaHAo4Hi8HsE";


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    NSString *bundlePath = [[NSBundle bundleWithIdentifier:@"Pixlee.pixlee-sdk"] bundlePath];
    NSError *error = nil;
    
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:bundlePath error:&error];
    NSLog(@"directoryContents ====== %@",files);
    [[PXLClient sharedClient] setApiKey:PXLClientAPIKey];
    return YES;
}

@end
