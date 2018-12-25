#line 1 "Tweak.xm"

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

@class UIDevice; 
static void (*_logos_orig$_ungrouped$UIDevice$_setBatteryState$)(_LOGOS_SELF_TYPE_NORMAL UIDevice* _LOGOS_SELF_CONST, SEL, UIDeviceBatteryState); static void _logos_method$_ungrouped$UIDevice$_setBatteryState$(_LOGOS_SELF_TYPE_NORMAL UIDevice* _LOGOS_SELF_CONST, SEL, UIDeviceBatteryState); 

#line 1 "Tweak.xm"



static void _logos_method$_ungrouped$UIDevice$_setBatteryState$(_LOGOS_SELF_TYPE_NORMAL UIDevice* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIDeviceBatteryState state) {
	if (state == 1) {
		
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"UnPlugged"
		message:@"Your device has stopped charging." preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
		[alertController addAction:actionOk];
		[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
	}
	else {
		return nil;
	}
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$UIDevice = objc_getClass("UIDevice"); MSHookMessageEx(_logos_class$_ungrouped$UIDevice, @selector(_setBatteryState:), (IMP)&_logos_method$_ungrouped$UIDevice$_setBatteryState$, (IMP*)&_logos_orig$_ungrouped$UIDevice$_setBatteryState$);} }
#line 20 "Tweak.xm"
