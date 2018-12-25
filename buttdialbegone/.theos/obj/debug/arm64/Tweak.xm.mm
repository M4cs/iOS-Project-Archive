#line 1 "Tweak.xm"
@interface DialerController : PhoneViewController
@end

static BOOL isEnabled = YES;


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

@class DialerController; 
static void (*_logos_orig$_ungrouped$DialerController$viewWillAppear)(_LOGOS_SELF_TYPE_NORMAL DialerController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$DialerController$viewWillAppear(_LOGOS_SELF_TYPE_NORMAL DialerController* _LOGOS_SELF_CONST, SEL); 

#line 6 "Tweak.xm"


static void _logos_method$_ungrouped$DialerController$viewWillAppear(_LOGOS_SELF_TYPE_NORMAL DialerController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd):(bool){
	if (isEnabled)
		UIAlertController *confirmationAlertController = [UIAlertController
									alertControllerWithTitle:@"Confirm Call"
									message:@"Are you sure you want to place this call?"
									preferredStyle:UIAlertControllerStyleAlert];



		UIAlertAction* confirmYes = [UIAlertAction
									actionWithTitle:@"Yes"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										
										_logos_orig$_ungrouped$DialerController$viewWillAppear(self, _cmd);
									}];

		UIAlertAction* confirmNo = [UIAlertAction
									actionWithTitle:@"No"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										
									}];

		[confirmationAlertController addAction:confirmNo];
		[confirmationAlertController addAction:confirmYes];

		[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:confirmationAlertController animated:YES completion:NULL];

}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$DialerController = objc_getClass("DialerController"); MSHookMessageEx(_logos_class$_ungrouped$DialerController, @selector(viewWillAppear), (IMP)&_logos_method$_ungrouped$DialerController$viewWillAppear, (IMP*)&_logos_orig$_ungrouped$DialerController$viewWillAppear);} }
#line 42 "Tweak.xm"
