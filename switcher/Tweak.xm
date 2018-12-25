#import <objc/runtime.h>
//Prefs
#define PLIST_PATH @"/cygwin64/home/maxli/switcher/switcherPrefs/entry.plist" //Change to your entry.plist path. Include file extension.

inline bool GetPrefBool(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}

inline int GetPrefInt(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] intValue];
}

inline float GetPrefFloat(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] floatValue];
}
//End Prefs

//Respring function
@interface FBSystemService : NSObject
+(id)sharedInstance;
- (void)exitAndRelaunch:(bool)arg1;
@end

static void RespringDevice()
{
    [[%c(FBSystemService) sharedInstance] exitAndRelaunch:YES];
}

%ctor
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)RespringDevice, CFSTR("com.auxilium.switcherPrefs/respring"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately); //Your Prefs Bundle + "/respring" (different form tweak bundle) See reference in /prefs/MotusPrefsRootListController.m
}
//End Respring

static BOOL miniSettingsViewExists = NO;
UIView *miniSettingsView;


%hook SBDeckSwitcherViewController
-(void)viewWillLayoutSubviews {
    if (!miniSettingsViewExists) {
        miniSettingsView = [[UIView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.height/2 - 240, 480, 240, 72)]; // 320, 96 both * 0.75
        [miniSettingsView setBackgroundColor:[UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1]];
        [[miniSettingsView layer] setCornerRadius:25.0f]; //35 for sicccckk circle dock
        miniSettingsView.tag = 420;
        [self.view addSubview:miniSettingsView];
        miniSettingsViewExists = YES;
    }
    %orig;
}

%end

%hook SBDeckSwitcherPageView

-(id)initWithFrame:(CGRect)arg1 {
    CGRect r = arg1;
    return %orig(CGRectMake(r.origin.x, r.origin.y, r.size.width * 0.70, r.size.height * 0.70));
}

%end

%hook SBAppSwitcherPageView

-(void)setCornerRadius:(double)arg1 {
    %orig(40);
}

%end