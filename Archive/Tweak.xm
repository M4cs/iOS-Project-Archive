//
//  Motus
//   Easily oppen Control Center from the bottom corners of your iPhone X.
//   By Simalary (Chris) & MidnightChips
//

#import <objc/runtime.h>

//Prefs

NSString *path = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/com.simalary-midnightchips.auxiliumdevelopment.motusprefs"];
NSDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:path];

static BOOL isEnabled = (BOOL)[[settings objectForKey:@"kEnabled"]?:@TRUE boolValue];
static NSInteger newWidth = (NSInteger)[[settings objectForKey:@"preferences"]?:@9 integerValue];
static NSInteger newAlpha = (NSInteger)[[settings objectForKey:@"preferences2"]?:@9 integerValue];

//End Prefs

@interface CHMotusWindow : UIWindow
@end

@interface CHMotusView : UIView
@end

@interface SBControlCenterController
+(id)sharedInstance;
+(void)presentAnimated:(BOOL)arg1;
@end

@implementation CHMotusWindow
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIWindow *window in self.subviews) {
        if (!window.hidden && window.userInteractionEnabled && [window pointInside:[self convertPoint:point toView:window] withEvent:event])
            return YES;
    }
    return NO;
}
@end

@implementation CHMotusView
// -(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//     for (UIView *view in self.subviews) {
//         if (!view.hidden && view.userInteractionEnabled && [view pointInside:[self convertPoint:point toView:view] withEvent:event])
//             return YES;
//     }
//     return NO;
// }
@end

%hook SpringBoard

-(void)applicationDidFinishLaunching:(id)application {
    %orig;
if(isEnabled) {
	UIWindow * screen = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];

	CHMotusView * rightView=[[CHMotusView alloc]initWithFrame:CGRectMake(screen.bounds.size.width, screen.bounds.size.height, - newWidth, - 150)];
    [rightView setBackgroundColor:[UIColor redColor]];
    [rightView setAlpha: newAlpha];
    rightView.userInteractionEnabled = TRUE;

	CHMotusView * leftView=[[CHMotusView alloc]initWithFrame:CGRectMake(screen.bounds.origin.x, screen.bounds.size.height, newWidth, - 150)];
    [leftView setBackgroundColor:[UIColor redColor]];
    [leftView setAlpha: newAlpha];
    leftView.userInteractionEnabled = TRUE;

	CHMotusWindow *window = [[CHMotusWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	window.windowLevel = 1005;
	[window setHidden:NO];
	[window setAlpha:1.0];
	[window setBackgroundColor:[UIColor clearColor]];
	[window addSubview:rightView];
	[window addSubview:leftView];

	UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRecognizer:)];
    rightRecognizer.direction=UISwipeGestureRecognizerDirectionUp;
    [rightView addGestureRecognizer:rightRecognizer];

	UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRecognizer:)];
    leftRecognizer.direction=UISwipeGestureRecognizerDirectionUp;
	[leftView addGestureRecognizer:leftRecognizer];

	/*UILabel *betaLabel;
    betaLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen.bounds.size.width / 2, screen.bounds.size.height - 35, 0, 0)];
    betaLabel.textColor = [UIColor whiteColor];
	betaLabel.backgroundColor = [UIColor redColor];
    betaLabel.textAlignment = NSTextAlignmentCenter;
    betaLabel.text = @"MOTUS BETA";
    betaLabel.font = [UIFont fontWithName:@".SFUIText" size:15];
    [betaLabel sizeToFit];
    [betaLabel setCenter:(CGPointMake(CGRectGetMidX(screen.bounds), betaLabel.center.y))];
	[window addSubview:betaLabel];*/

    //[upRecognizer release];

	//[[[[[UIApplication sharedApplication] keyWindow] subviews] lastObject] addSubview:window];
}
else return %orig;
}
%new
- (void) SwipeRecognizer:(UISwipeGestureRecognizer *)sender {
	[[%c(SBControlCenterController) sharedInstance] presentAnimated:TRUE];
}

%end
