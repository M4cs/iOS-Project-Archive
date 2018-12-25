#line 1 "Tweak.xm"
#import <libcolorpicker.h>

@interface SBAppSwitcherScrollView: UIScrollView
@end


SBAppSwitcherScrollView *switcherView = nil;

CGFloat fadeDuration = 0.2f;

static NSMutableDictionary *colorsettings; static NSMutableDictionary *colorsettings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.macs.colorswitcherPrefs.plist"];


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

@class SBDeckSwitcherViewController; @class SBAppSwitcherScrollView; 
static void (*_logos_orig$_ungrouped$SBAppSwitcherScrollView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL SBAppSwitcherScrollView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBAppSwitcherScrollView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL SBAppSwitcherScrollView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$SBDeckSwitcherViewController$_handleDismissTapGesture$)(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$SBDeckSwitcherViewController$_handleDismissTapGesture$(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$SBDeckSwitcherViewController$willMoveToParentViewController$)(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$SBDeckSwitcherViewController$willMoveToParentViewController$(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST, SEL, id); static bool (*_logos_orig$_ungrouped$SBDeckSwitcherViewController$handleHomeButtonSinglePressUp)(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST, SEL); static bool _logos_method$_ungrouped$SBDeckSwitcherViewController$handleHomeButtonSinglePressUp(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST, SEL); 

#line 13 "Tweak.xm"

static void _logos_method$_ungrouped$SBAppSwitcherScrollView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL SBAppSwitcherScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    _logos_orig$_ungrouped$SBAppSwitcherScrollView$layoutSubviews(self, _cmd);
    if (switcherView == nil){
      switcherView = self;
      switcherView.backgroundColor = LCPParseColorString([colorsettings objectForKey:@"customColor"], @"#FF0000"); 
    }
	switcherView.backgroundColor = LCPParseColorString([colorsettings objectForKey:@"customColor"], @"#FF0000");
    switcherView.alpha = 0.72f;
    [UIView animateWithDuration:fadeDuration
    animations:^{
        switcherView.alpha = 0.72f;
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

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBAppSwitcherScrollView = objc_getClass("SBAppSwitcherScrollView"); MSHookMessageEx(_logos_class$_ungrouped$SBAppSwitcherScrollView, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$SBAppSwitcherScrollView$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$SBAppSwitcherScrollView$layoutSubviews);Class _logos_class$_ungrouped$SBDeckSwitcherViewController = objc_getClass("SBDeckSwitcherViewController"); MSHookMessageEx(_logos_class$_ungrouped$SBDeckSwitcherViewController, @selector(_handleDismissTapGesture:), (IMP)&_logos_method$_ungrouped$SBDeckSwitcherViewController$_handleDismissTapGesture$, (IMP*)&_logos_orig$_ungrouped$SBDeckSwitcherViewController$_handleDismissTapGesture$);MSHookMessageEx(_logos_class$_ungrouped$SBDeckSwitcherViewController, @selector(willMoveToParentViewController:), (IMP)&_logos_method$_ungrouped$SBDeckSwitcherViewController$willMoveToParentViewController$, (IMP*)&_logos_orig$_ungrouped$SBDeckSwitcherViewController$willMoveToParentViewController$);MSHookMessageEx(_logos_class$_ungrouped$SBDeckSwitcherViewController, @selector(handleHomeButtonSinglePressUp), (IMP)&_logos_method$_ungrouped$SBDeckSwitcherViewController$handleHomeButtonSinglePressUp, (IMP*)&_logos_orig$_ungrouped$SBDeckSwitcherViewController$handleHomeButtonSinglePressUp);} }
#line 66 "Tweak.xm"
