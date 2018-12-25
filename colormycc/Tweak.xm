#import <UIKit/UIKit.h>
#import "libcolorpicker.h"

@interface CCUIScrollView : UIView
@end

static UIColor *backgroundColor = [UIColor colorWithRed:0.35 green:0.78 blue:0.98 alpha:1];
CFStringRef kPrefsAppID = CFSTR("com.rustybalboa.colormycc");
static void loadSettings() {
NSDictionary *settings = nil;
CFPreferencesAppSynchronize(kPrefsAppID);
 CFArrayRef keyList = CFPreferencesCopyKeyList(kPrefsAppID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
if (keyList) {
settings = (NSDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, kPrefsAppID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost));
CFRelease(keyList);

static NSMutableDictionary *colorsettings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.rustbalboa.colormycc.plist"];

%hook CCUIScrollView

%new
-(void)didMoveToWindow {
self.backgroundColor = LCPParseColorString([colorsettings objectForKey:@"customColor"], @"#5AC8FA");;
}

%end

%ctor {
loadSettings();
}
