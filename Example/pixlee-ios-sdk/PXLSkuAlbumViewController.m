//
//  PXLSkuAlbumViewController.m
//  pixlee-ios-sdk
//
// 
//

#import "PXLSkuAlbumViewController.h"\

#import <pixlee_sdk/PXLAlbum.h>
#import <pixlee_sdk/PXLPhoto.h>
#import <pixlee_sdk/PXLAlbumFilterOptions.h>
#import <pixlee_sdk/PXLAlbumSortOptions.h>
#import <pixlee_sdk/PXLClient.h>

@interface PXLExampleAlbumViewController ()

@end

@implementation PXLExampleAlbumViewController

#warning Replace with your sku identifier.
static NSString * const PXLSkuAlbumIdentifier = @"2";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a new album instance.
    PXLAlbum *album = [PXLAlbum albumWithSkuIdentifier:<#(NSString *)#>:<#(NSString *)#>:PXLSkuAlbumIdentifier];
    
    // Create and set filter options on the album.
    PXLAlbumFilterOptions *filterOptions = [PXLAlbumFilterOptions new];
    // Important Please CHange Parameters
    NSString *dateStr = @"20190101";


    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    NSDate *date = [dateFormat dateFromString:dateStr]; 
    
    filterOptions.submittedDateStart = date; // submitted within the last 20 days
    album.filterOptions = filterOptions;
    
    // Create and set sort options on the album.
    PXLAlbumSortOptions *sortOptions = [PXLAlbumSortOptions new];
    sortOptions.sortType = PXLAlbumSortTypePhotoRank;
    album.sortOptions = sortOptions;
    album.perPage = 100;
    
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
    


    
    [self loadNextPageOfPhotos];
}

@end
