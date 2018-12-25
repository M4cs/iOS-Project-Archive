#import <Preferences/Preferences.h>
// #import <CoreFoundation/CoreFoundation.h>

@interface _UIBackdropViewSettings : NSObject
+(id)settingsForStyle:(long long)arg1 ;
-(void)setBlurRadius:(CGFloat)arg1 ;
-(void)setColorTintAlpha:(CGFloat)arg1 ;
-(void)setGrayscaleTintAlpha:(CGFloat)arg1 ;
-(void)setGrayscaleTintLevel:(CGFloat)arg1 ;
@end

@interface _UIBackdropView : UIView
@property(retain, nonatomic) _UIBackdropViewSettings *inputSettings;
-(void)transitionToSettings:(id)arg1;
-(void)_setBlursBackground:(BOOL)arg1;
-(id)initWithStyle:(int)settings;
@end

@interface UIViewController (Private)
-(id)navigationController;
@end

@interface NBBackdropView : _UIBackdropView

@end

@interface NBPreViewController : PSListController <UITextFieldDelegate> {
	UIWindow *settingsView;
	NBBackdropView *blurView;
	UIAlertView * alert;
	UISlider *slider;
	UIBarButtonItem *valueButton;
	NSString *currentValue;
	CFStringRef key;
	int mode;
}
@end

@interface NBAlphaPreViewController : NBPreViewController
@end

@interface NBLevelPreViewController : NBPreViewController
@end