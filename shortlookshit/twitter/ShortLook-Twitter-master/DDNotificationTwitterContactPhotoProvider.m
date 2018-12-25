#import "DDNotificationTwitterContactPhotoProvider.h"

@implementation DDNotificationTwitterContactPhotoProvider

- (DDNotificationContactPhotoPromiseOffer *)contactPhotoPromiseOfferForNotification:(DDUserNotification *)notification {
    // Get profile URL from Twitter
    NSString *profileURLStr = [notification.applicationUserInfo valueForKeyPath:@"users.sender.profile_image_url"];
    if (!profileURLStr) return nil;
    profileURLStr = [profileURLStr stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *profileURL = [NSURL URLWithString:profileURLStr];
    if (!profileURL) return nil;

    // Tell ShortLook we'd like to download it
    return [NSClassFromString(@"DDNotificationContactPhotoPromiseOffer") offerDownloadingPromiseWithPhotoIdentifier:profileURLStr fromURL:profileURL];
}

@end