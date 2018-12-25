#import "SNTBannerNotificationViewController.h"

@implementation SNTBannerNotificationViewController
-(id)init {
  self = [super init];

  if (self) {
    self.notificationLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    self.notificationLabel.textColor = [UIColor whiteColor];
    self.notificationLabel.backgroundColor = [UIColor clearColor];
    self.notificationLabel.font = [UIFont systemFontOfSize:10];
    self.notificationLabel.alpha = 0.0f;
    self.notificationLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.notificationLabel];

    self.appIconImage = [UIImageView alloc];
    self.appIconImage.frame = self.notificationLabel.bounds;
    self.appIconImage = [UIImage imageNamed:@"/layout/Library/ApplicationSupport/StatusNotifications/filler.png"];
    [self.view addSubview:self.appIconImage];
  }

  return self;
}
-(void)presentNotificationWithText:(NSString *)arg1 image:(UIImage *)arg2 animated:(BOOL)arg3 {
  self.notificationLabel.text = arg1;
  self.appIconImage.image = arg2;

  if(arg3){
    //Fade In
    [UIView animateWithDuration:0.3 delay:0 options:0 animations:^{
        self.notificationLabel.alpha = 1;
    } completion:nil];
    // Fade out
    [UIView animateWithDuration:0.3 delay:5 options:0 animations:^{
        self.notificationLabel.alpha = 0;
    } completion:nil];// We want animated so lets animate
  }
}
@end
