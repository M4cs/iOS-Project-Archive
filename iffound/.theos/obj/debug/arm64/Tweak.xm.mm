#line 1 "Tweak.xm"
static UIWindow *window = nil;


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

@class SBLockScreenDateViewController; 
static void (*_logos_orig$_ungrouped$SBLockScreenDateViewController$viewDidAppear)(_LOGOS_SELF_TYPE_NORMAL SBLockScreenDateViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBLockScreenDateViewController$viewDidAppear(_LOGOS_SELF_TYPE_NORMAL SBLockScreenDateViewController* _LOGOS_SELF_CONST, SEL); 

#line 3 "Tweak.xm"


static void _logos_method$_ungrouped$SBLockScreenDateViewController$viewDidAppear(_LOGOS_SELF_TYPE_NORMAL SBLockScreenDateViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
  if (!window){

  window = [[UIWindow alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-175,150,350,400)];

            window.hidden = NO;
            window.windowLevel = UIWindowLevelStatusBar;
            window.layer.masksToBounds = YES;
            window.layer.cornerRadius = 30;
            [self addSubview:window];

  UIVisualEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
  UIVisualEffectView *vView = [[UIVisualEffectView alloc]initWithEffect:blur];

            vView.frame = window.bounds;
            [window addSubview:vView];

  UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-50,40,100,50)];
                    label.text = @"IfFound";
                    label.textColor = [UIColor greenColor];
                    [window addSubview:label];



  
}

}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBLockScreenDateViewController = objc_getClass("SBLockScreenDateViewController"); MSHookMessageEx(_logos_class$_ungrouped$SBLockScreenDateViewController, @selector(viewDidAppear), (IMP)&_logos_method$_ungrouped$SBLockScreenDateViewController$viewDidAppear, (IMP*)&_logos_orig$_ungrouped$SBLockScreenDateViewController$viewDidAppear);} }
#line 35 "Tweak.xm"
