#line 1 "Tweak.xm"
#import <objc/runtime.h>

#define PLIST_PATH @"/cygwin64/home/maxli/switcher/switcherPrefs/entry.plist" 

inline bool GetPrefBool(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}

inline int GetPrefInt(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] intValue];
}

inline float GetPrefFloat(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] floatValue];
}



@interface FBSystemService : NSObject
+(id)sharedInstance;
- (void)exitAndRelaunch:(bool)arg1;
@end


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class FBSystemService; @class SBAppSwitcherPageView; @class SBDeckSwitcherViewController; @class SBDeckSwitcherPageView; 
static void (*_logos_orig$_ungrouped$SBDeckSwitcherViewController$viewWillLayoutSubviews)(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBDeckSwitcherViewController$viewWillLayoutSubviews(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST, SEL); static SBDeckSwitcherPageView* (*_logos_orig$_ungrouped$SBDeckSwitcherPageView$initWithFrame$)(_LOGOS_SELF_TYPE_INIT SBDeckSwitcherPageView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static SBDeckSwitcherPageView* _logos_method$_ungrouped$SBDeckSwitcherPageView$initWithFrame$(_LOGOS_SELF_TYPE_INIT SBDeckSwitcherPageView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static void (*_logos_orig$_ungrouped$SBAppSwitcherPageView$setCornerRadius$)(_LOGOS_SELF_TYPE_NORMAL SBAppSwitcherPageView* _LOGOS_SELF_CONST, SEL, double); static void _logos_method$_ungrouped$SBAppSwitcherPageView$setCornerRadius$(_LOGOS_SELF_TYPE_NORMAL SBAppSwitcherPageView* _LOGOS_SELF_CONST, SEL, double); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$FBSystemService(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("FBSystemService"); } return _klass; }
#line 24 "Tweak.xm"
static void RespringDevice()
{
    [[_logos_static_class_lookup$FBSystemService() sharedInstance] exitAndRelaunch:YES];
}

static __attribute__((constructor)) void _logosLocalCtor_33e75ff0(int __unused argc, char __unused **argv, char __unused **envp)
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)RespringDevice, CFSTR("com.auxilium.switcherPrefs/respring"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately); 
}


static BOOL miniSettingsViewExists = NO;
UIView *miniSettingsView;



static void _logos_method$_ungrouped$SBDeckSwitcherViewController$viewWillLayoutSubviews(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (!miniSettingsViewExists) {
        miniSettingsView = [[UIView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.height/2 - 240, 480, 240, 72)]; 
        [miniSettingsView setBackgroundColor:[UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1]];
        [[miniSettingsView layer] setCornerRadius:25.0f]; 
        miniSettingsView.tag = 420;
        [self.view addSubview:miniSettingsView];
        miniSettingsViewExists = YES;
    }
    _logos_orig$_ungrouped$SBDeckSwitcherViewController$viewWillLayoutSubviews(self, _cmd);
}





static SBDeckSwitcherPageView* _logos_method$_ungrouped$SBDeckSwitcherPageView$initWithFrame$(_LOGOS_SELF_TYPE_INIT SBDeckSwitcherPageView* __unused self, SEL __unused _cmd, CGRect arg1) _LOGOS_RETURN_RETAINED {
    CGRect r = arg1;
    return _logos_orig$_ungrouped$SBDeckSwitcherPageView$initWithFrame$(self, _cmd, CGRectMake(r.origin.x, r.origin.y, r.size.width * 0.70, r.size.height * 0.70));
}





static void _logos_method$_ungrouped$SBAppSwitcherPageView$setCornerRadius$(_LOGOS_SELF_TYPE_NORMAL SBAppSwitcherPageView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, double arg1) {
    _logos_orig$_ungrouped$SBAppSwitcherPageView$setCornerRadius$(self, _cmd, 40);
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBDeckSwitcherViewController = objc_getClass("SBDeckSwitcherViewController"); MSHookMessageEx(_logos_class$_ungrouped$SBDeckSwitcherViewController, @selector(viewWillLayoutSubviews), (IMP)&_logos_method$_ungrouped$SBDeckSwitcherViewController$viewWillLayoutSubviews, (IMP*)&_logos_orig$_ungrouped$SBDeckSwitcherViewController$viewWillLayoutSubviews);Class _logos_class$_ungrouped$SBDeckSwitcherPageView = objc_getClass("SBDeckSwitcherPageView"); MSHookMessageEx(_logos_class$_ungrouped$SBDeckSwitcherPageView, @selector(initWithFrame:), (IMP)&_logos_method$_ungrouped$SBDeckSwitcherPageView$initWithFrame$, (IMP*)&_logos_orig$_ungrouped$SBDeckSwitcherPageView$initWithFrame$);Class _logos_class$_ungrouped$SBAppSwitcherPageView = objc_getClass("SBAppSwitcherPageView"); MSHookMessageEx(_logos_class$_ungrouped$SBAppSwitcherPageView, @selector(setCornerRadius:), (IMP)&_logos_method$_ungrouped$SBAppSwitcherPageView$setCornerRadius$, (IMP*)&_logos_orig$_ungrouped$SBAppSwitcherPageView$setCornerRadius$);} }
#line 70 "Tweak.xm"
