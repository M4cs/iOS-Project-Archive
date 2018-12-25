#line 1 "Tweak.xm"
#import <UIKit/UIKit.h>
#import "libcolorpicker.h"

@interface CCUIScrollView : UIView
@end

static UIColor *backgroundColor = [UIColor colorWithRed:0.35 green:0.78 blue:0.98 alpha:1];
CFStringRef kPrefsAppID = CFSTR("com.rustybalboa.colormycc");
static void loadSettings() {
NSDictionary *settings = nil;
CFPreferencesAppSynchronize(kPrefsAppID);

if (keyList) {
settings = (NSDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, kPrefsAppID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost));
CFRelease(keyList);
}
if (settings && settings[@"backgroundColor"]) backgroundColor = LCPParseColorString([settings[@"backgroundColor"] stringValue], @"#5ac8fa");
}


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

@class CCUIScrollView; 
static void _logos_method$_ungrouped$CCUIScrollView$didMoveToWindow(_LOGOS_SELF_TYPE_NORMAL CCUIScrollView* _LOGOS_SELF_CONST, SEL); 

#line 20 "Tweak.xm"



static void _logos_method$_ungrouped$CCUIScrollView$didMoveToWindow(_LOGOS_SELF_TYPE_NORMAL CCUIScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
self.backgroundColor = backgroundColor;
}



static __attribute__((constructor)) void _logosLocalCtor_533cf254(int __unused argc, char __unused **argv, char __unused **envp) {
loadSettings();
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$CCUIScrollView = objc_getClass("CCUIScrollView"); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$CCUIScrollView, @selector(didMoveToWindow), (IMP)&_logos_method$_ungrouped$CCUIScrollView$didMoveToWindow, _typeEncoding); }} }
#line 32 "Tweak.xm"
