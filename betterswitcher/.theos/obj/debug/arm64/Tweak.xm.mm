#line 1 "Tweak.xm"
static BOOL miniSettingsViewExists = NO;
static BOOL buttonScrollViewExists = NO;
UIView *miniSettingsView;

@interface SBAppSwitcherScrollView : UIView
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

@class SBAppSwitcherScrollView; 
static void (*_logos_orig$_ungrouped$SBAppSwitcherScrollView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL SBAppSwitcherScrollView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBAppSwitcherScrollView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL SBAppSwitcherScrollView* _LOGOS_SELF_CONST, SEL); 

#line 9 "Tweak.xm"

static void _logos_method$_ungrouped$SBAppSwitcherScrollView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL SBAppSwitcherScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	if (!miniSettingsViewExists) {
		miniSettingsView = [[UIView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 120, 495, 240, 72)]; 
		[miniSettingsView setBackgroundColor:[UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1]];
		[[miniSettingsView layer] setCornerRadius:25.0f]; 
		miniSettingsView.tag = 420;
		[self addSubview:miniSettingsView];
		miniSettingsViewExists = YES;
	}
	if (miniSettingsViewExists && !buttonScrollViewExists) {

		UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, miniSettingsView.frame.size.width, miniSettingsView.frame.size.height)];
		[scrollView setPagingEnabled: YES];
		scrollView.tag = 421;

		  int x = 0;
		  CGRect frame;
		  for (int i = 0; i < 10; i++) {

		    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		    if (i == 0) {
		      frame = CGRectMake(10, 10, 50, 50);
		    } else {
		      frame = CGRectMake((i * 50) + (i*20) + 10, 10, 50, 50);
		    }
		    button.frame = frame;
		    button.layer.cornerRadius = 0.5 * button.bounds.size.width;
		    
		    [button setTag:i];
		    [button setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0]];
		    [button addTarget:self action:@selector(onClickofFilter:) forControlEvents:UIControlEventTouchUpInside];
		    [scrollView addSubview:button];

		    if (i == 9) {
		      x = CGRectGetMaxX(button.frame);
		    }

		  }

		  scrollView.contentSize = CGSizeMake(x, scrollView.frame.size.height);
		  [miniSettingsView addSubview:scrollView];
		  buttonScrollViewExists = YES;
	}
	_logos_orig$_ungrouped$SBAppSwitcherScrollView$layoutSubviews(self, _cmd);
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBAppSwitcherScrollView = objc_getClass("SBAppSwitcherScrollView"); MSHookMessageEx(_logos_class$_ungrouped$SBAppSwitcherScrollView, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$SBAppSwitcherScrollView$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$SBAppSwitcherScrollView$layoutSubviews);} }
#line 57 "Tweak.xm"
