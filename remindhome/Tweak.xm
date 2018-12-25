#import <libcolorpicker.h>

@interface SBHomeScreenViewController : UIViewController
@property (retain, nonatomic) UIView *barView;
@property (retain, nonatomic) UILabel *firstLabel;
@property (retain, nonatomic) UIButton *closeButton;
@end

@interface SBIconListPageControl : UIPageControl
@end

@interface SBFWallpaperView : UIView
@end

CGFloat fadeDuration = 0.6f;

CGFloat waitDuration = 0.2f;

SBHomeScreenViewController *barView = nil;

NSString *textValue;

static float barHeight;
static float barAlpha;

%hook SBHomeScreenViewController
%property (retain, nonatomic) UIView *barView;
%property (retain, nonatomic) UILabel *firstLabel;
%property (retain, nonatomic) UIButton *closeButton;

-(void)viewDidLoad {
	self.barView = [[UIView alloc] initWithFrame:CGRectMake(1, 460, [[UIScreen mainScreen] bounds].size.width - 2, barHeight)];
	self.barView.backgroundColor = [UIColor blackColor];
	self.barView.layer.cornerRadius = 5;
	self.barView.layer.masksToBounds = true;
	self.barView.alpha = barAlpha;

	UIVisualEffect *blurEffect;
	blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];

	UIVisualEffectView *visualEffectView;
	visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

	visualEffectView.frame = self.barView.bounds;
	visualEffectView.alpha = 0.0f;

	  self.firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 460, [[UIScreen mainScreen] bounds].size.width - 2, barHeight)];
	  self.firstLabel.text = textValue;
	  self.firstLabel.textColor = [UIColor whiteColor];
	  self.firstLabel.backgroundColor = [UIColor clearColor];
	  self.firstLabel.font = [UIFont fontWithName: @"HelveticaNeue" size: 18.0f];
	  self.firstLabel.alpha = 1.0;
	  self.firstLabel.textAlignment = NSTextAlignmentCenter;

	  self.closeButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
	  self.closeButton.frame= CGRectMake(2, self.barView.frame.origin.y, [[UIScreen mainScreen] bounds].size.width / 8, barHeight);
	  self.closeButton.tintColor = [UIColor whiteColor];
	  [self.closeButton setTitle:@"X" forState:UIControlStateNormal];
	  [self.closeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

	[self.barView addSubview:visualEffectView];
	//add barview here
	[self.view addSubview:self.barView];
	//add firstLabel as its own view
	[self.view addSubview:self.firstLabel];
  [self.view addSubview:self.closeButton];
}


%new

-(void)buttonAction:(UIButton *)closeButton {
  dispatch_async(dispatch_get_main_queue(), ^(void){
    [UIView animateWithDuration:fadeDuration
      animations:^{
        self.barView.alpha = 0.0f;
        self.barView.frame = CGRectMake(-100, 460, [[UIScreen mainScreen] bounds].size.width - 2, 26);
        self.closeButton.alpha = 0.0f;
        self.closeButton.frame = CGRectMake(-100, 460, [[UIScreen mainScreen] bounds].size.width / 8, 26);
        self.firstLabel.alpha = 0.0f;
        self.firstLabel.frame = CGRectMake(-100, 460, [[UIScreen mainScreen] bounds].size.width - 2, 26);
      }
    ];
  });
}

%end




%hook SBIconListPageControl

-(void)layoutSubviews {
%orig;
self.hidden = YES;
}

%end

%hook SBFWallpaperView

-(void)layoutSubviews {
%orig;
self.hidden = YES;
}

%end

/*Preferences*/
static void loadPrefs() {
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.macs.remindhome.plist"];
    if (prefs) {
        textValue = [prefs objectForKey:@"kTextValue"];
        barHeight = [[prefs objectForKey:@"kBarHeight"] floatValue];
        barAlpha = [[prefs objectForKey:@"kBarAlpha"] floatValue];
    }
}

%ctor  {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.macs.remindhome/prefsChanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}
