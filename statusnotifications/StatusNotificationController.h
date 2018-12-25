#import "SNTBannerNotificationViewController.h"
#import "SNTNotificationRequestController.h"

@interface StatusNotificationController : NSObject
@property (retain, nonatomic) SNTBannerNotificationViewController *bannerViewController;
+(id)sharedInstance;
@end
