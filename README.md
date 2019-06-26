# pixlee-ios-sdk-carthage

This SDK makes it easy for Pixlee customers to easily include Pixlee albums in their native iOS apps. It includes a native wrapper to the Pixlee album API as well as some drop-in and customizable UI elements to quickly get you started.

## Getting Started

This repo includes both the Pixlee iOS SDK and an example project to show you how it's used.

### SDK

Before accessing the Pixlee API, you must initialize the `PXLClient`. To set the API key, call `setApiKey:` on `[PXLClient sharedClient]`. You can then use that singleton instance to make calls against the Pixlee API.

To load the photos in an album there are two methods https://developers.pixlee.com/reference#get-approved-content-from-album or https://developers.pixlee.com/reference#get-approved-content-for-product. 

If you are retriving the content for one album you'll want to use the `PXLAlbum` class. Create an instance by calling `[PXLAlbum albumWithIdentifier:<ALBUM ID HERE>]`. You can then set `sortOptions` and `filterOptions` as necessary (see the header files for more details) before calling `loadNextPageOfPhotos:` to load photos. An album will load its photos as pages, and calling `loadNextPageOfPhotos:` successively will load each page in turn.

Example
```
//Create an Instance of Album with the sku Identifier
PXLAlbum *album = [PXLAlbum albumWithIdentifier:PXLSkuAlbumIdentifier];

// Create and set filter options on the album.
PXLAlbumFilterOptions *filterOptions = [PXLAlbumFilterOptions new];
filterOptions.submittedDateStart = [[NSDate date] dateByAddingTimeInterval:-60 * 60 * 24 * 20]; // submitted within the last 20 days
album.filterOptions = filterOptions;

// Create and set sort options on the album.
PXLAlbumSortOptions *sortOptions = [PXLAlbumSortOptions new];
sortOptions.sortType = PXLAlbumSortTypePhotoRank;
album.sortOptions = sortOptions;
album.perPage = 100;

[album loadNextPageOfPhotos:^(NSArray *photos, NSError *error) {
    NSLog(@"%@",error);
    if (photos.count) {
        NSMutableArray *indexPaths = @[].mutableCopy;
        NSInteger firstIndex = [album.photos indexOfObject:[photos firstObject]];
        NSLog(@"%@", [album.photos objectAtIndex:0]);
    }
}];

```

If you are retriving the content for a sku you'll want to use the `PXLAlbum` class. Create an instance by calling `[PXLAlbum albumWithSkuIdentifier:<SKU ID HERE>]`. You can then set `sortOptions` and `filterOptions` as necessary (see the header files for more details) before calling `loadNextPageOfPhotosFromSku:` to load photos. An album will load its photos as pages, and calling `loadNextPageOfPhotosFromSku:` successively will load each page in turn.

Example
```
//Create an Instance of Album with the sku Identifier
PXLAlbum *album = [PXLAlbum albumWithSkuIdentifier:PXLSkuAlbumIdentifier];

// Create and set filter options on the album.
PXLAlbumFilterOptions *filterOptions = [PXLAlbumFilterOptions new];
filterOptions.submittedDateStart = [[NSDate date] dateByAddingTimeInterval:-60 * 60 * 24 * 20]; // submitted within the last 20 days
album.filterOptions = filterOptions;

// Create and set sort options on the album.
PXLAlbumSortOptions *sortOptions = [PXLAlbumSortOptions new];
sortOptions.sortType = PXLAlbumSortTypePhotoRank;
album.sortOptions = sortOptions;
album.perPage = 100;

[album loadNextPageOfPhotosFromSku:^(NSArray *photos, NSError *error) {
    NSLog(@"%@",error);
    if (photos.count) {
        NSMutableArray *indexPaths = @[].mutableCopy;
        NSInteger firstIndex = [album.photos indexOfObject:[photos firstObject]];
        NSLog(@"%@", [album.photos objectAtIndex:0]);
    }
}];

```

Additionally, you can control how an album loads its data using `PXLAlbumFilterOptions` and `PXLAlbumSortOptions`. To use these, create a new instance with `[PXLAlbumFilterOptions new]` or `[PXLAlbumSortOptions new]`, set the necessary properties, and then set those objects to the `filterOptions` and `sortOptions` properties on your album. Make sure to set these before calling `loadNextPageOfPhotos:`.

Once an album has loaded photos from the server, it will instantiate `PXLPhoto` objects that can be consumed by your UI. `PXLPhoto` exposes all of the data for a photo available through the Pixlee API and offers several image url sizes depending on your needs.

To help you quickly get started, we've also built an album view controller and photo detail view controller that can be used and customized in your app. `PXLAlbumViewController` uses a `UICollectionView` to display the photos in an album and includes a toggle to switch between a grid and list view. Use `albumViewControllerWithAlbumId:` to create an instance or set the `album` property if you need to create an instance through other means. Once the album has been set, you can call `loadNextPageOfPhotos` to start the loading process. The album view controller is set up to automatically load more pages of photos as the user scrolls, giving it an infinite scroll effect.

If a user taps on a photo in the `PXLAlbumViewController`, we present a detail view with `PXLPhotoDetailViewController`. You may present a detail view yourself by instantiating an instance of `PXLPhotoDetailViewController` and setting its `photo` property. The photo detail view is configured to display:
* the large photo
* the username of the poster
* a timestamp showing when the photo was posted
* the platform source of the photo (e.g. Instagram)
* the photo's caption (if one is available)
* any products associated with that photo (displayed as a horizontal list of products)

### Including Pixlee SDK
##### If you're building for iOS, tvOS, or watchOS
1. Create a Cartfile that lists the frameworks you’d like to use in your project.
1. Run `carthage update`. This will fetch dependencies into a Carthage/Checkouts folder, then build each one or download a pre-compiled framework.
1. On your application targets’ “General” settings tab, in the “Linked Frameworks and Libraries” section, drag and drop each framework you want to use from the Carthage/Build folder on disk.
1. On your application targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase”. Create a Run Script in which you specify your shell (ex: `/bin/sh`), add the following contents to the script area below the shell:

  ```sh
  /usr/local/bin/carthage copy-frameworks
  ```

  and add the paths to the frameworks you want to use under “Input Files”, e.g.:

  ```
  $(SRCROOT)/Carthage/Build/iOS/Box.framework
  $(SRCROOT)/Carthage/Build/iOS/Result.framework
  $(SRCROOT)/Carthage/Build/iOS/ReactiveCocoa.framework
  ```
  This script works around an [App Store submission bug](http://www.openradar.me/radar?id=6409498411401216) triggered by universal binaries and ensures that necessary bitcode-related files and dSYMs are copied when archiving.

With the debug information copied into the built products directory, Xcode will be able to symbolicate the stack trace whenever you stop at a breakpoint. This will also enable you to step through third-party code in the debugger.

When archiving your application for submission to the App Store or TestFlight, Xcode will also copy these files into the dSYMs subdirectory of your application’s `.xcarchive` bundle.

### Important 
If you are using xcode 10, the new build system doesn't work with the example project. A temporary workaround seems to be switching to the legacy build system by going to (in Xcode) File -> Workspace Settings -> Build System -> Legacy Build System. But compiling with the CLI still doesnt work.


### Example

To run the example project, clone the repo, and run `carthage update` from the Example directory first. Then in `PXLAppDelegate.m` set `PXLClientAPIKey` to your API key (available from the Pixlee dashboard). Then in `PXLExampleAlbumViewController.m` set the album id that you wish to display as `PXLAlbumIdentifier`.

To run the project, open example.xcodeproj in Xcode.

Run the project and you should see a grid of photos from that album.

## Troubleshooting

If you get an error running `carthage update` on osx please clear your carthage cache by doing 
`rm -rf ~/Library/Caches/org.carthage.CarthageKit`. 

## License

pixlee-ios-sdk is available under the MIT license.
