@interface SBFluidSwitcherViewController : UIViewController
@end 

@interface SBDeckSwitcherViewController : SBFluidSwitcherViewController
@end 

@interface SBWallpaperEffectView : UIView
@end 

static CGFloat backgroundAlpha = 0;
static BOOL fakeViewExists = NO;

%hook SBDeckSwitcherViewController

/* iOS 9 - 11.1.2 */
-(void)viewWillLayoutSubviews {
    SBWallpaperEffectView *_wallpaperEffectView = MSHookIvar<SBWallpaperEffectView *>(self, "_wallpaperEffectView");
    if (_wallpaperEffectView != NULL) {
        //create uiview
        if (!fakeViewExists) {
            UIView *fakeView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            fakeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:backgroundAlpha];
            fakeView.backgroundColor = [UIColor blackColor];
            fakeView.tag = 420;
            // [_wallpaperEffectView insertSubview:fakeView atIndex:5];
            [_wallpaperEffectView addSubview:fakeView];
            [_wallpaperEffectView sendSubviewToBack:fakeView];
            fakeViewExists = YES;
        }
    }
}


%end

/* iOS 7 - 11.1.2 */
%hook SBWallpaperEffectView

-(void)dealloc {
    UIView *viewToRemove = [self viewWithTag:420];
    if (viewToRemove != nil) {
        [viewToRemove removeFromSuperview];
        fakeViewExists = NO;
    }
    %orig;
}

%end

/* Preferences */
static void loadPrefs()
{
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.tonyk7.darkSwitcherPrefs.plist"];
    if(prefs) {
        backgroundAlpha = [prefs objectForKey:@"backgroundAlpha"] ? [[prefs objectForKey:@"backgroundAlpha"] floatValue] : backgroundAlpha;
    }
}

%ctor
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.tonyk7.darkSwitcherPrefs/settingsupdated"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPrefs();
}