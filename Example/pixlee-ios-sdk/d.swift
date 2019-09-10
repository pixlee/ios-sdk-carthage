//  The converted code is limited to 2 KB.
//  Upgrade your plan to remove this limitation.
//
//  Converted to Swift 5.1 by Swiftify v5.1.27756 - https://objectivec2swift.com/
//
//  PXLViewController.m
//  pixlee-ios-sdk
//
//  Created by Tim Shi on 04/30/2015.
//

import pixlee_sdk

#warning("Replace with your Pixlee album identifier.")
let PXLAlbumIdentifier = "4515393"
let PXLSkuAlbumIdentifier = "300152"

class PXLExampleAlbumViewController {
    ///---------------------------------------------------------------
    /// Analytics events refer to pixlee_sdk PXLAbum.h or The Readme or https://developers.pixlee.com/docs/analytics-events-tracking-pixel-guide
    ///---------------------------------------------------------------
    
    //Setup some constants
    static let viewDidLoadCurrency = "USD"
    //Product 1 example
    static let viewDidLoadProduct_sku = "SL-BENJ"
    static let viewDidLoadPrice = "13.00"
    //product 2 example
    static let viewDidLoadProduct_sku2 = "AD-1324S"
    static let viewDidLoadPrice2 = "53.07"
    
    //  Converted to Swift 5.1 by Swiftify v5.1.27756 - https://objectivec2swift.com/
    // Create a new album instance.
    // If you are using api/v2/album/@album_id/Photos
    // PXLAlbum *album = [PXLAlbum albumWithIdentifier:(NSString *):PXLAlbumIdentifier];
    // If you are using api/v2/album/sku_from
    
    // Create a new album instance.
    // If you are using api/v2/album/@album_id/Photos
    // PXLAlbum *album = [PXLAlbum albumWithIdentifier:<#(NSString *)#>:PXLAlbumIdentifier];
    // If you are using api/v2/album/sku_from
    let album = PXLAlbum(skuIdentifier: PXLSkuAlbumIdentifier)
    
    // Create and set filter options on the album.
    let filterOptions = PXLAlbumFilterOptions()
    
    
    
    //These parameters are examples. Please adjust, add or remove them during implementation.
    //    NSString *dateStr = @"20190101";
    // Convert string to date object
    //    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //    [dateFormat setDateFormat:@"yyyyMMdd"];
    //    NSDate *date = [dateFormat dateFromString:dateStr];
    
    //    filterOptions.submittedDateStart = date;
    
    //These parameters are examples. Please adjust, add or remove them during implementation.
    //Boolean tests
    //    filterOptions.hasPermission = false;
    //    filterOptions.hasProduct = false;
    
    //NsuInteger Test
    //    filterOptions.minInstagramFollowers = 200;
    
    //NSMutableArray
    //    NSString *source = @"instagram";
    //    filterOptions.contentSource = [NSMutableArray arrayWithObjects:source,nil];
    
    //NsDictionnary -> Json
    var dict = [AnyHashable : Any](minimumCapacity: 10)
    
    //    NSString *c1 = @"tonystark";
    //    NSString *c2 = @"thanos";
    //    [dict setObject:[NSMutableArray arrayWithObjects:c1,c2,nil] forKey:@"contains"];
    //    filterOptions.filterByUserhandle = dict;
    

    album.filtereOPtions = filterOptions
    
    // Create and set sort options on the album.
    let sortOptions = PXLAlbumSortOptions()
    sortOptions.sortType = PXLAlbumSortTypeRandom
    sortOptions.ascending = true
    album.sortOptions = sortOptions
    album.perPage = 1
    
    // Set the album to load.
    //album = album    // Skipping redundant initializing to itself
    // Example of loading a photo with an identifier
//    PXLPhoto.getWithId("299469263", callback: { photo, error in
//    print("hello there")
//    if let identifier = photo?.album.identifier {
//    print("\(identifier)")
//    }
//
//
//
//
//    let p = photo?.products[0] as? PXLProduct
//    let url = p?.link.absoluteString.removingPercentEncoding
//    print("\(url ?? "")")
//
//
//
//    photo?.triggerEventActionClicked(url, callback: { error in
//    print("triggered")
//    })
//
//    })

}
