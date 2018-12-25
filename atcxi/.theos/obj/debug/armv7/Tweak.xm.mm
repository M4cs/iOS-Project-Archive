#line 1 "Tweak.xm"
@interface DialerController : UIViewController
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

@class DialerController; 
static void (*_logos_orig$_ungrouped$DialerController$_callButtonPressed$)(_LOGOS_SELF_TYPE_NORMAL DialerController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$DialerController$_callButtonPressed$(_LOGOS_SELF_TYPE_NORMAL DialerController* _LOGOS_SELF_CONST, SEL, id); 

#line 4 "Tweak.xm"

static void _logos_method$_ungrouped$DialerController$_callButtonPressed$(_LOGOS_SELF_TYPE_NORMAL DialerController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){

    UIView *dialerView = MSHookIvar<UIView *>(self, "_dialerView");
    UILabel *_lcd = MSHookIvar<UILabel *>(dialerView, "_lcd");
    NSString *numberToCall = [_lcd text];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ConfirmCall" message:[NSString stringWithFormat:@"Are you sure want to call %@", numberToCall] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yeah" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        _logos_orig$_ungrouped$DialerController$_callButtonPressed$(self, _cmd, arg1);
    }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"Nope" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
    }];

    [alert addAction:yesAction];
    [alert addAction:noAction];
     [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];

}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$DialerController = objc_getClass("DialerController"); MSHookMessageEx(_logos_class$_ungrouped$DialerController, @selector(_callButtonPressed:), (IMP)&_logos_method$_ungrouped$DialerController$_callButtonPressed$, (IMP*)&_logos_orig$_ungrouped$DialerController$_callButtonPressed$);} }
#line 26 "Tweak.xm"
