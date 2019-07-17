//
//  PXLViewController.m
//  pixlee-ios-sdk
//
//  Created by Tim Shi on 04/30/2015.
//

#import "PXLExampleAlbumViewController.h"\

#import <pixlee_sdk/PXLAlbum.h>
#import <pixlee_sdk/PXLPhoto.h>
#import <pixlee_sdk/PXLAlbumFilterOptions.h>
#import <pixlee_sdk/PXLAlbumSortOptions.h>
#import <pixlee_sdk/PXLClient.h>
#import <pixlee_sdk/PXLAnalytics.h>

@interface PXLExampleAlbumViewController ()

@end

@implementation PXLExampleAlbumViewController

#warning Replace with your Pixlee album identifier.
static NSString * const PXLAlbumIdentifier = @"4515393";
static NSString * const PXLSkuAlbumIdentifier = @"300152";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a new album instance.
    // If you are using api/v2/album/@album_id/Photos
    // PXLAlbum *album = [PXLAlbum albumWithIdentifier:<#(NSString *)#>:PXLAlbumIdentifier];
    // If you are using api/v2/album/sku_from
    PXLAlbum *album = [PXLAlbum albumWithSkuIdentifier:PXLSkuAlbumIdentifier];
    
    // Create and set filter options on the album.
    PXLAlbumFilterOptions *filterOptions = [PXLAlbumFilterOptions new];



    //These parameters are examples. Please adjust, add or remove them during implementation.
    NSString *dateStr = @"20190101";
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    
    filterOptions.submittedDateStart = date;

    //These parameters are examples. Please adjust, add or remove them during implementation.
    //Boolean tests
    filterOptions.hasPermission = true;
    filterOptions.hasProduct = false;
    
    //NsuInteger Test
    filterOptions.minInstagramFollowers = 200;
    
    //NSMutableArray
    NSString *source = @"instagram";
    filterOptions.contentSource = [NSMutableArray arrayWithObjects:source,nil];
    
    //NsDictionnary -> Json
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:10];
    
    NSString *c1 = @"tonystark";
    NSString *c2 = @"thanos";
    [dict setObject:[NSMutableArray arrayWithObjects:c1,c2,nil] forKey:@"contains"];
    filterOptions.filterByUserhandle = dict;

    NSString* identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString]; // IOS 6+
    NSLog(@"output is : %@", identifier);
    
    album.filterOptions = filterOptions;
    
    // Create and set sort options on the album.
    PXLAlbumSortOptions *sortOptions = [PXLAlbumSortOptions new];
    sortOptions.sortType = PXLAlbumSortTypeRandom;
    sortOptions.ascending = true;
    album.sortOptions = sortOptions;
    album.perPage = 3;
    
    // Set the album to load.
    self.album = album;
    // Example of loading a photo with an identifier
    [PXLPhoto getPhotoWithId:@"187542438" callback:^(PXLPhoto *photo, NSError *error) {
        NSLog(@"%@", photo.cdnOriginalUrl);
        NSLog(@"%@", photo.cdnLargeUrl);
        NSLog(@"%@", photo.cdnMediumUrl);
        NSLog(@"%@", photo.cdnSmallUrl);
        NSLog(@"%@",error);
    }];
    
    

    
    //Conversion Analytics Events
    //Setup some constants
    static NSString * const currency = @"USD";
    //Product_1
    static NSString * const product_sku = @"SL-BENJ";
    static NSString * const price = @"13.00";
    NSNumber * const quantity = @2;
    //product_2
    static NSString * const product_sku2 = @"AD-1324S";
    static NSString * const price2 = @"53.07";
    NSNumber * const quantity2 = @5;
    
    
    
    [PXLAnalytics triggerEventAddCart:product_sku :quantity :price :currency callback:^(NSError *error) {
        NSLog(@"logged");
    }];
    
    //Add_to_cart Analytics Events
    //Setup some constants
    NSMutableDictionary *cart1 = [[NSMutableDictionary alloc]initWithCapacity:10];
    [cart1 setObject:price forKey:@"price"];
    [cart1 setObject:product_sku forKey:@"product_sku"];
    [cart1 setObject:quantity forKey:@"quantity"];
    NSMutableDictionary *cart2 = [[NSMutableDictionary alloc]initWithCapacity:10];
    [cart2 setObject:price2 forKey:@"price"];
    [cart2 setObject:product_sku2 forKey:@"product_sku"];
    [cart2 setObject:quantity2 forKey:@"quantity"];
    
    NSNumber *  quantity_total = @7;
    NSNumber * const order_id = @234232;
    NSNumber * const cart_total = @18.00;
    
    NSMutableArray *cart_contents =[NSMutableArray arrayWithObjects:cart1,cart2,nil];
    
    [PXLAnalytics triggerEventConvertedPhoto:cart_contents :cart_total :quantity_total :order_id :currency callback:^(NSError *error) {
        NSLog(@"logged");
    }];

    // If you are using  https://developers.pixlee.com/reference#get-approved-content-from-album // api/v2/album/@album_id/Photos
//    [self loadNextPageOfPhotos];
    // If you are using api/v2/album/sku_from
    [self loadNextPageOfPhotosFromSku callback:^(PXLPhoto *photo, NSError *error) {
        NSLog(@"%@", photo.cdnOriginalUrl);
        NSLog(@"%@", photo.cdnLargeUrl);
        NSLog(@"%@", photo.cdnMediumUrl);
        NSLog(@"%@", photo.cdnSmallUrl);
        NSLog(@"%@",error);
    }];

    
    //Analytics Events Example
    //openedLightbox
    [self.album triggerEventOpenedWidget:@"horizontal" callback:^(NSError *error) {
        NSLog(@"logged");
    }];
    
    
    
    //openedWidget
    [self.album triggerEventOpenedLightbox:@"187542438" callback:^(NSError *error) {
        NSLog(@"logged");
    }];
}

@end
