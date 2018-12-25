#import "StatusNotificationController.h"

@interface UIStatusBar : UIView
@property (retain, nonatomic) SNTBannerNotificationViewController *bannerViewController;
@end

@interface SNTBannerNotificationController : UIViewController
@end

%hook UIStatusBar
%property (retain, nonatomic) SNTBannerNotificationViewController *bannerViewController;
-(void)layoutSubviews {
  %orig;
  if(!self.bannerViewController){
    self.bannerViewController = [[SNTBannerNotificationViewController alloc] init];
    StatusNotificationController *controller = [StatusNotificationController sharedInstance];
    controller.bannerViewController = self.bannerViewController;
    [self addSubview:self.bannerViewController.view];
  }
  self.bannerViewController.view.frame = self.bounds;
}
%end
