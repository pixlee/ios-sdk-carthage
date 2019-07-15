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
    


    // If you are using  https://developers.pixlee.com/reference#get-approved-content-from-album // api/v2/album/@album_id/Photos
//    [self loadNextPageOfPhotos];
    // If you are using api/v2/album/sku_from
     https://developers.pixlee.com/reference#get-approved-content-for-product.
    [self loadNextPageOfPhotosFromSku];

}

@end
