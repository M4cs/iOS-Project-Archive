#line 1 "Tweak.xm"
@interface NCNotificationCombinesListViewController
@end

@implementatiion UIScrollView


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

@class NCNotificationCombinesListViewController; 
static void (*_logos_orig$_ungrouped$NCNotificationCombinesListViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL NCNotificationCombinesListViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationCombinesListViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL NCNotificationCombinesListViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$NCNotificationCombinesListViewController$addButtonsToScrolLView(_LOGOS_SELF_TYPE_NORMAL NCNotificationCombinesListViewController* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$NCNotificationCombinesListViewController$buttonPressed$)(_LOGOS_SELF_TYPE_NORMAL NCNotificationCombinesListViewController* _LOGOS_SELF_CONST, SEL, UIButton *); static void _logos_method$_ungrouped$NCNotificationCombinesListViewController$buttonPressed$(_LOGOS_SELF_TYPE_NORMAL NCNotificationCombinesListViewController* _LOGOS_SELF_CONST, SEL, UIButton *); 

#line 6 "Tweak.xm"


static void _logos_method$_ungrouped$NCNotificationCombinesListViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL NCNotificationCombinesListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    [super viewDidLoad];
	[self viewDidLoad];

    UIScrollView* scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 250, 150)];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.alpha = 0.65f;
    [self.view addSubview:scrollView];

    scrollView setContentSize:CGSizeMake(250 * 2, 150)

    [scrollView addSubview:visualEffectView];

}



static void _logos_method$_ungrouped$NCNotificationCombinesListViewController$addButtonsToScrolLView(_LOGOS_SELF_TYPE_NORMAL NCNotificationCombinesListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    NSInteger buttonCount = 15;

    CGRect buttonFrame = CGRectMake(5.0f, 5.0f, self.scollView.frame.size.width-10.0f, 40.0f);

    for (int index = 0; index <buttonCount; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setFrame:buttonFrame];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:index+1];}

        NSString *title = [NSString stringWithFormat:@"Button %d",index+1];
        [button setTitle:title forState:UIControlStateNormal];

        [self.scrollView setContentSize:contentSize];
}

static void _logos_method$_ungrouped$NCNotificationCombinesListViewController$buttonPressed$(_LOGOS_SELF_TYPE_NORMAL NCNotificationCombinesListViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIButton * button) {
    switch (button.tag){
      case 1:

        break;

      case 2:

        break;

      case 3:

        break;

      case 4:

        break;

      case 5:

        break;

      case 6:

        break;

      case 7:

        break;

      case 8:

        break;

      case 9:

        break;

      case 10:

        break;

      default:

        break;
    }
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$NCNotificationCombinesListViewController = objc_getClass("NCNotificationCombinesListViewController"); MSHookMessageEx(_logos_class$_ungrouped$NCNotificationCombinesListViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$NCNotificationCombinesListViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$NCNotificationCombinesListViewController$viewDidLoad);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$NCNotificationCombinesListViewController, @selector(addButtonsToScrolLView), (IMP)&_logos_method$_ungrouped$NCNotificationCombinesListViewController$addButtonsToScrolLView, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$NCNotificationCombinesListViewController, @selector(buttonPressed:), (IMP)&_logos_method$_ungrouped$NCNotificationCombinesListViewController$buttonPressed$, (IMP*)&_logos_orig$_ungrouped$NCNotificationCombinesListViewController$buttonPressed$);} }
#line 91 "Tweak.xm"
