#line 1 "Tweak.xm"
#import <libcolorpicker.h>

@implementation MacsClass
+(id)sharedInstance{
  static MacsClass *sharedInstance = nil;
  @synchronized(self){
  if (sharedInstance == nil){
      sharedInstance = [[self alloc] init];
      sharedInstance.hasShownWelcome = NO;
      
      
    }
    return sharedInstance;
  }
}
@end

@interface SBAppSwitcherScrollView: UIScrollView
@end


SBAppSwitcherScrollView *switcherView = nil;

CGFloat fadeDuration = 0.2f;

BOOL hasShownWelcome = NO;


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

@class SBLockScreenManager; @class SBDeckSwitcherViewController; @class SBAppSwitcherScrollView; 
static void (*_logos_orig$_ungrouped$SBAppSwitcherScrollView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL SBAppSwitcherScrollView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBAppSwitcherScrollView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL SBAppSwitcherScrollView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$SBDeckSwitcherViewController$_handleDismissTapGesture$)(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$SBDeckSwitcherViewController$_handleDismissTapGesture$(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$SBDeckSwitcherViewController$willMoveToParentViewController$)(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$SBDeckSwitcherViewController$willMoveToParentViewController$(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST, SEL, id); static bool (*_logos_orig$_ungrouped$SBDeckSwitcherViewController$handleHomeButtonSinglePressUp)(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST, SEL); static bool _logos_method$_ungrouped$SBDeckSwitcherViewController$handleHomeButtonSinglePressUp(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST, SEL); 

#line 28 "Tweak.xm"
static bool (*_logos_orig$springboardHooks$SBLockScreenManager$_finishUIUnlockFromSource$withOptions$)(_LOGOS_SELF_TYPE_NORMAL SBLockScreenManager* _LOGOS_SELF_CONST, SEL, int, id); static bool _logos_method$springboardHooks$SBLockScreenManager$_finishUIUnlockFromSource$withOptions$(_LOGOS_SELF_TYPE_NORMAL SBLockScreenManager* _LOGOS_SELF_CONST, SEL, int, id); 


static bool _logos_method$springboardHooks$SBLockScreenManager$_finishUIUnlockFromSource$withOptions$(_LOGOS_SELF_TYPE_NORMAL SBLockScreenManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, int arg1, id arg2){
  if (MacsClass.hasShownWelcome == NO){
    		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Thank you for Downloading!"
		message:@"ColorSwitcher is a free tweak but if you would like to pay for it you can do so. We don't charge for most of our tweaks and the reasoning behind it is we want to help the community and those of you who cant afford it. You can donate in 2 ways, through Paypal or through Patreon. Please check out the preferences in your Settings app to find links to these services. Thanks again! - Macs." preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil];
		[alertController addAction:actionOk];
		[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    MacsClass.hasShownWelcome = YES;
  }
  return _logos_orig$springboardHooks$SBLockScreenManager$_finishUIUnlockFromSource$withOptions$(self, _cmd, arg1, arg2);
}




static NSMutableDictionary *coloursettings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.macs.colorswitcher.plist"];


static void _logos_method$_ungrouped$SBAppSwitcherScrollView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL SBAppSwitcherScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    _logos_orig$_ungrouped$SBAppSwitcherScrollView$layoutSubviews(self, _cmd);
    if (switcherView == nil){
      switcherView = self;
      switcherView.backgroundColor = LCPParseColorString([coloursettings objectForKey:@"customColour"], @"#FF0000"); 
    }
    switcherView.backgroundColor = LCPParseColorString([coloursettings objectForKey:@"customColour"], @"#FF0000");
    switcherView.alpha = 0.52f;
    [UIView animateWithDuration:fadeDuration
    animations:^{
        switcherView.alpha = 0.52f;
        }
    ];
}





static void _logos_method$_ungrouped$SBDeckSwitcherViewController$_handleDismissTapGesture$(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
  _logos_orig$_ungrouped$SBDeckSwitcherViewController$_handleDismissTapGesture$(self, _cmd, arg1);
  [UIView animateWithDuration:fadeDuration
  animations:^{
      switcherView.alpha = 0.0f;
      }
  ];
}


static void _logos_method$_ungrouped$SBDeckSwitcherViewController$willMoveToParentViewController$(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
  _logos_orig$_ungrouped$SBDeckSwitcherViewController$willMoveToParentViewController$(self, _cmd, arg1);
  dispatch_async(dispatch_get_main_queue(), ^(void){
    [UIView animateWithDuration:fadeDuration
      animations:^{
        switcherView.alpha = 0.0f;
      }
    ];
  });
}


static bool _logos_method$_ungrouped$SBDeckSwitcherViewController$handleHomeButtonSinglePressUp(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
  dispatch_async(dispatch_get_main_queue(), ^(void){
    [UIView animateWithDuration:fadeDuration
      animations:^{
        switcherView.alpha = 0.0f;
      }
    ];
  });
  return _logos_orig$_ungrouped$SBDeckSwitcherViewController$handleHomeButtonSinglePressUp(self, _cmd);
}


static __attribute__((constructor)) void _logosLocalCtor_b711f7aa(int __unused argc, char __unused **argv, char __unused **envp){
  MacsClass *macsClass = [MacsClass sharedInstance];
  {Class _logos_class$_ungrouped$SBAppSwitcherScrollView = objc_getClass("SBAppSwitcherScrollView"); MSHookMessageEx(_logos_class$_ungrouped$SBAppSwitcherScrollView, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$SBAppSwitcherScrollView$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$SBAppSwitcherScrollView$layoutSubviews);Class _logos_class$_ungrouped$SBDeckSwitcherViewController = objc_getClass("SBDeckSwitcherViewController"); MSHookMessageEx(_logos_class$_ungrouped$SBDeckSwitcherViewController, @selector(_handleDismissTapGesture:), (IMP)&_logos_method$_ungrouped$SBDeckSwitcherViewController$_handleDismissTapGesture$, (IMP*)&_logos_orig$_ungrouped$SBDeckSwitcherViewController$_handleDismissTapGesture$);MSHookMessageEx(_logos_class$_ungrouped$SBDeckSwitcherViewController, @selector(willMoveToParentViewController:), (IMP)&_logos_method$_ungrouped$SBDeckSwitcherViewController$willMoveToParentViewController$, (IMP*)&_logos_orig$_ungrouped$SBDeckSwitcherViewController$willMoveToParentViewController$);MSHookMessageEx(_logos_class$_ungrouped$SBDeckSwitcherViewController, @selector(handleHomeButtonSinglePressUp), (IMP)&_logos_method$_ungrouped$SBDeckSwitcherViewController$handleHomeButtonSinglePressUp, (IMP*)&_logos_orig$_ungrouped$SBDeckSwitcherViewController$handleHomeButtonSinglePressUp);}
}
{
  apprestrict = [AppRestrict sharedInstance];
  if ([[[NSBundle mainBundle] bundleIdentifier] compare:@"com.apple.springboard"] == NSOrderedSame){
    {Class _logos_class$springboardHooks$SBLockScreenManager = objc_getClass("SBLockScreenManager"); MSHookMessageEx(_logos_class$springboardHooks$SBLockScreenManager, @selector(_finishUIUnlockFromSource:withOptions:), (IMP)&_logos_method$springboardHooks$SBLockScreenManager$_finishUIUnlockFromSource$withOptions$, (IMP*)&_logos_orig$springboardHooks$SBLockScreenManager$_finishUIUnlockFromSource$withOptions$);}
  }
}
