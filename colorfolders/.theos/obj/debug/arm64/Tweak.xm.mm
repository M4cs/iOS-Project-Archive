#line 1 "Tweak.xm"
@interface SBFolderView : SBFloatyDockView
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

@class SBFolderView; 
static void (*_logos_orig$_ungrouped$SBFolderView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL SBFolderView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBFolderView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL SBFolderView* _LOGOS_SELF_CONST, SEL); 

#line 4 "Tweak.xm"


static void _logos_method$_ungrouped$SBFolderView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL SBFolderView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	_logos_orig$_ungrouped$SBFolderView$layoutSubviews(self, _cmd);
	self.backgroundColor = [UIColor redColor];
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBFolderView = objc_getClass("SBFolderView"); MSHookMessageEx(_logos_class$_ungrouped$SBFolderView, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$SBFolderView$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$SBFolderView$layoutSubviews);} }
#line 12 "Tweak.xm"
