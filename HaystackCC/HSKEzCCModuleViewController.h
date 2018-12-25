#import <Haystack/HSKControlCenterPage.h>

@interface MediaControlsPanelViewController : UIViewController
-(void)_updateOnScreenForStyle:(int)arg1;
-(void)setStyle:(int)arg1;
@end

@interface HSKEzCCModuleViewController : HSKControlCenterPage
@property(nonatomic, retain) MediaControlsPanelViewController *mediaViewController;
@end
