#line 1 "Tweak.xm"
@interface SBLockScreenDateViewController : UIView
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

@class SBLockscreenDateViewController; 
static void (*_logos_orig$_ungrouped$SBLockscreenDateViewController$viewWillAppear)(_LOGOS_SELF_TYPE_NORMAL SBLockscreenDateViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBLockscreenDateViewController$viewWillAppear(_LOGOS_SELF_TYPE_NORMAL SBLockscreenDateViewController* _LOGOS_SELF_CONST, SEL); 

#line 4 "Tweak.xm"


static void _logos_method$_ungrouped$SBLockscreenDateViewController$viewWillAppear(_LOGOS_SELF_TYPE_NORMAL SBLockscreenDateViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {

	_logos_orig$_ungrouped$SBLockscreenDateViewController$viewWillAppear(self, _cmd) self.setTint = [UIColor redColor];
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBLockscreenDateViewController = objc_getClass("SBLockscreenDateViewController"); MSHookMessageEx(_logos_class$_ungrouped$SBLockscreenDateViewController, @selector(viewWillAppear), (IMP)&_logos_method$_ungrouped$SBLockscreenDateViewController$viewWillAppear, (IMP*)&_logos_orig$_ungrouped$SBLockscreenDateViewController$viewWillAppear);} }
#line 12 "Tweak.xm"
