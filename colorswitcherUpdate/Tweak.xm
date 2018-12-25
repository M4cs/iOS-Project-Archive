#import <libcolorpicker.h>

@implementation MacsClass
+(id)sharedInstance{
  static MacsClass *sharedInstance = nil;
  @synchronized(self){
  if (sharedInstance == nil){
      sharedInstance = [[self alloc] init];
      sharedInstance.hasShownWelcome = NO;
      //load settings here

    }
    return sharedInstance;
  }
}
@end

@interface SBAppSwitcherScrollView: UIScrollView
@end

// define our view
SBAppSwitcherScrollView *switcherView = nil;
// define our fade duration using a double
CGFloat fadeDuration = 0.2f;

BOOL hasShownWelcome = NO;

%group springboardHooks

%hook SBLockScreenManager
- (bool)_finishUIUnlockFromSource:(int)arg1 withOptions:(id)arg2{
  if (MacsClass.hasShownWelcome == NO){
    		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Thank you for Downloading!"
		message:@"ColorSwitcher is a free tweak but if you would like to pay for it you can do so. We don't charge for most of our tweaks and the reasoning behind it is we want to help the community and those of you who cant afford it. You can donate in 2 ways, through Paypal or through Patreon. Please check out the preferences in your Settings app to find links to these services. Thanks again! - Macs." preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil];
		[alertController addAction:actionOk];
		[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    MacsClass.hasShownWelcome = YES;
  }
  return %orig;
}
%end

%end

static NSMutableDictionary *coloursettings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.macs.colorswitcher.plist"];
//hooking our class from BSUIScrollView which is a subclass of UIScrollView
%hook SBAppSwitcherScrollView
-(void)layoutSubviews{
    %orig;
    if (switcherView == nil){
      switcherView = self;
      switcherView.backgroundColor = LCPParseColorString([coloursettings objectForKey:@"customColour"], @"#FF0000"); // here we define our color
    }
    switcherView.backgroundColor = LCPParseColorString([coloursettings objectForKey:@"customColour"], @"#FF0000");
    switcherView.alpha = 0.52f;
    [UIView animateWithDuration:fadeDuration
    animations:^{
        switcherView.alpha = 0.52f;
        }
    ];
}
%end

//hooking the app switcher view controller for methods of closing
%hook SBDeckSwitcherViewController
//created fade for tapping outside a card
-(void)_handleDismissTapGesture:(id)arg1{
  %orig;
  [UIView animateWithDuration:fadeDuration
  animations:^{
      switcherView.alpha = 0.0f;
      }
  ];
}

//creates fade when leaving app switcher
- (void)willMoveToParentViewController:(id)arg1{
  %orig;
  dispatch_async(dispatch_get_main_queue(), ^(void){
    [UIView animateWithDuration:fadeDuration
      animations:^{
        switcherView.alpha = 0.0f;
      }
    ];
  });
}

//creates fade for when you press home button
-(bool)handleHomeButtonSinglePressUp{
  dispatch_async(dispatch_get_main_queue(), ^(void){
    [UIView animateWithDuration:fadeDuration
      animations:^{
        switcherView.alpha = 0.0f;
      }
    ];
  });
  return %orig;
}
%end

%ctor{
  MacsClass *macsClass = [MacsClass sharedInstance];
  %init();
}
{
  apprestrict = [AppRestrict sharedInstance];
  if ([[[NSBundle mainBundle] bundleIdentifier] compare:@"com.apple.springboard"] == NSOrderedSame){
    %init(springboardHooks);
  }
}
