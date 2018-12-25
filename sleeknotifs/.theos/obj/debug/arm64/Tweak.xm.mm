#line 1 "Tweak.xm"
@interface NCNotificationShortLookView : NCNotificationStaticContentAccepting
@end

@interface MTMaterialView : NCNotificationShortLookView
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

@class MTMaterialView; 
static void (*_logos_orig$_ungrouped$MTMaterialView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL MTMaterialView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$MTMaterialView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL MTMaterialView* _LOGOS_SELF_CONST, SEL); 

#line 7 "Tweak.xm"


static void _logos_method$_ungrouped$MTMaterialView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL MTMaterialView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	self.backgroundColor = [UIColor blackColor];
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$MTMaterialView = objc_getClass("MTMaterialView"); MSHookMessageEx(_logos_class$_ungrouped$MTMaterialView, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$MTMaterialView$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$MTMaterialView$layoutSubviews);} }
#line 14 "Tweak.xm"
