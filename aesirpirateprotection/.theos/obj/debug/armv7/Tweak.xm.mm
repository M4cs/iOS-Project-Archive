#line 1 "Tweak.xm"
@interface SBHomeScreenViewController : UIViewController
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

@class SBHomeScreenViewController; 
static void (*_logos_orig$_ungrouped$SBHomeScreenViewController$viewWillLayoutSubviews)(_LOGOS_SELF_TYPE_NORMAL SBHomeScreenViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBHomeScreenViewController$viewWillLayoutSubviews(_LOGOS_SELF_TYPE_NORMAL SBHomeScreenViewController* _LOGOS_SELF_CONST, SEL); 

#line 4 "Tweak.xm"


static void _logos_method$_ungrouped$SBHomeScreenViewController$viewWillLayoutSubviews(_LOGOS_SELF_TYPE_NORMAL SBHomeScreenViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
  

  
        _logos_orig$_ungrouped$SBHomeScreenViewController$viewWillLayoutSubviews(self, _cmd);
        UIAlertController *alert =   [UIAlertController
                                alertControllerWithTitle:@"Aesir Piracy Protection"
                                message:@"BRO. YOU DID NOT JUST PIRATE MY THEME. YOU ARE CRAZY LOCO HOMIE. SUPER CRAZY LOCO HOMIE. DON'T DO IT AGAIN. NOW GET THAT SHIT OFF YOUR DEVICE."
                                preferredStyle:UIAlertControllerStyleAlert];


        UIAlertAction *okAction = [UIAlertAction
                                actionWithTitle:@"Brick Device."
                                style:UIAlertActionStyleCancel
                                handler:^(UIAlertAction *action)
                                {
                                    _logos_orig$_ungrouped$SBHomeScreenViewController$viewWillLayoutSubviews(self, _cmd);
                                }];

        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
}



static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBHomeScreenViewController = objc_getClass("SBHomeScreenViewController"); MSHookMessageEx(_logos_class$_ungrouped$SBHomeScreenViewController, @selector(viewWillLayoutSubviews), (IMP)&_logos_method$_ungrouped$SBHomeScreenViewController$viewWillLayoutSubviews, (IMP*)&_logos_orig$_ungrouped$SBHomeScreenViewController$viewWillLayoutSubviews);} }
#line 31 "Tweak.xm"
