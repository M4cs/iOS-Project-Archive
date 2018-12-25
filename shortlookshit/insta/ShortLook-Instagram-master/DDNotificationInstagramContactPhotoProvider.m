#import "DDNotificationInstagramContactPhotoProvider.h"

@implementation DDNotificationInstagramContactPhotoProvider

- (DDNotificationContactPhotoPromiseOffer *)contactPhotoPromiseOfferForNotification:(DDUserNotification *)notification {
    // Get profile URL from Instagram
    NSString *profileURLStr = notification.applicationUserInfo[@"a"];
    if (!profileURLStr) return nil;
    NSURL *profileURL = [NSURL URLWithString:profileURLStr];
    if (!profileURL) return nil;

    // Tell ShortLook we'd like to download it
    return [NSClassFromString(@"DDNotificationContactPhotoPromiseOffer") offerDownloadingPromiseWithPhotoIdentifier:profileURLStr fromURL:profileURL];
}

@end