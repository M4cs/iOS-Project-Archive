#line 1 "Tweak.xm"
@interface SBDeckSwitcherViewController
{
    NSMutableArray *_displayItems;
}
@property(retain, nonatomic) NSArray *displayItems; 
- (void)_layoutDisplayItem:(id)arg1;
-(void)setDisplayItems:(NSArray*)items;
-(void)killDisplayItemOfContainer:(id)arg1 withVelocity:(CGFloat)arg2;
-(id)_itemContainerForDisplayItem:(id)arg1;
@end


static BOOL miniSettingsViewExists = NO;
UIView *miniSettingsView;



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

@class SBDeckSwitcherViewController; 
static void (*_logos_orig$_ungrouped$SBDeckSwitcherViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBDeckSwitcherViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST, SEL); 

#line 17 "Tweak.xm"

static void _logos_method$_ungrouped$SBDeckSwitcherViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL SBDeckSwitcherViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (!miniSettingsViewExists) {
        miniSettingsView = [[UIView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.height/2 - 240, 480, 240, 72)]; 
        [miniSettingsView setBackgroundColor:[UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1]];
        [[miniSettingsView layer] setCornerRadius:25.0f]; 
        miniSettingsView.tag = 420;
        [self.view addSubview:miniSettingsView];
        miniSettingsViewExists = YES;
    }
    _logos_orig$_ungrouped$SBDeckSwitcherViewController$viewDidLoad(self, _cmd);
}



















static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBDeckSwitcherViewController = objc_getClass("SBDeckSwitcherViewController"); MSHookMessageEx(_logos_class$_ungrouped$SBDeckSwitcherViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$SBDeckSwitcherViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$SBDeckSwitcherViewController$viewDidLoad);} }
#line 48 "Tweak.xm"
