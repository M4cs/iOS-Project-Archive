#import "NoBlur.h"
static NSString *const OldNBPrefsPath = @"/var/mobile/Library/Preferences/com.xtm3x.noblur~prefs.plist";
static NSString *const NBPrefsPath = @"/var/mobile/Library/Preferences/com.xtm3x.noblur.plist";

static BOOL enabled;
static BOOL blur;
static BOOL appSwitch;
static BOOL lockBlur;
static BOOL foldIBlur;
static BOOL foldBBlur;
static BOOL dockBlur;
static BOOL nc;
static BOOL cc;
static BOOL bb;
static BOOL squal;
static BOOL sblur;
static BOOL navbar;
static BOOL keyblur;
static BOOL qrblur;
static BOOL blurOkay;
static BOOL callblur;
static BOOL siri;
static BOOL volumeHUD;
static BOOL videoPlayer;
static BOOL replaceBlur;
static BOOL forceTouch;
static CGFloat ltint;
static CGFloat nctint;
static CGFloat cctint;
static CGFloat btint;
static CGFloat utint;
static CGFloat ulevel;
static CGFloat siriTintAlpha;
static CGFloat HUDTintAlpha;
static CGFloat FTTintAlpha;
static BOOL otint;
static BOOL olevel;

static NSNumber *valueForAppSpecificPref(NSString *pref, NSDictionary *dict) {
	NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
	NSString *key = [bundleIdentifier stringByAppendingFormat:@"-%@", pref];
	return dict[key] ?: dict[pref];
}

static BOOL opValueForAppSpecificPref(NSString *pref, NSDictionary *dict) {
    if (dict[pref]) {
        NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
        NSString *key = [pref stringByAppendingFormat:@"-%@", bundleIdentifier];
        return [dict[key] boolValue] ?: !([dict[pref] boolValue]);
    } else {
        return YES;
	}
}

static void reloadPrefs() {
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:NBPrefsPath];

	enabled     = [[dict objectForKey:@"enabled"] boolValue];
	blur        = [[dict objectForKey:@"blur"] boolValue];
	appSwitch   = [[dict objectForKey:@"appSwitch"] boolValue];
	lockBlur    = [[dict objectForKey:@"lockBlur"] boolValue];
	foldIBlur   = [[dict objectForKey:@"foldIBlur"] boolValue];
	foldBBlur   = [[dict objectForKey:@"foldBBlur"] boolValue];
	dockBlur    = [[dict objectForKey:@"dockBlur"] boolValue];
	nc          = [[dict objectForKey:@"nc"] boolValue];
	cc          = [[dict objectForKey:@"cc"] boolValue];
	bb          = [[dict objectForKey:@"bb"] boolValue];
	squal       = [[dict objectForKey:@"squal"] boolValue];
	sblur       = [[dict objectForKey:@"sblur"] boolValue];
	navbar      = !opValueForAppSpecificPref(@"navbar", dict);
	keyblur     = !opValueForAppSpecificPref(@"keyblur", dict);
	qrblur      = [[dict objectForKey:@"qrblur"] boolValue];
	callblur    = [[dict objectForKey:@"callblur"] boolValue];
	siri        = [[dict objectForKey:@"siri"] boolValue];
	volumeHUD   = [[dict objectForKey:@"volumeHUD"] boolValue];
	videoPlayer = [[dict objectForKey:@"videoPlayer"] boolValue];
	replaceBlur = [[dict objectForKey:@"replace"] boolValue];
	forceTouch  = [[dict objectForKey:@"forceTouch"] boolValue];
	
	siriTintAlpha    = [dict objectForKey:@"siriTintAlpha"] ? [[dict objectForKey:@"siriTintAlpha"] floatValue] : 0.4;
	HUDTintAlpha     = [dict objectForKey:@"HUDTintAlpha"] ? [[dict objectForKey:@"HUDTintAlpha"] floatValue] : 0.4;
	FTTintAlpha      = [dict objectForKey:@"FTTintAlpha"] ? [[dict objectForKey:@"FTTintAlpha"] floatValue] : 0.4;
	ltint            = [dict objectForKey:@"ltintf"] ? [[dict objectForKey:@"ltintf"] floatValue] : 0.0;
	nctint           = [dict objectForKey:@"nctint"] ? [[dict objectForKey:@"nctint"] floatValue] : 0.6;
	cctint           = [dict objectForKey:@"cctint"] ? [[dict objectForKey:@"cctint"] floatValue] : 0.4;
	btint            = [dict objectForKey:@"btint"] ? [[dict objectForKey:@"btint"] floatValue] : 0.6;

	utint  = valueForAppSpecificPref(@"utintf", dict).floatValue ?: 0.4;
	ulevel = valueForAppSpecificPref(@"ulevelf", dict).floatValue;
	otint  = valueForAppSpecificPref(@"oTint", dict).boolValue;
	olevel = valueForAppSpecificPref(@"oLevel", dict).boolValue;

	[dict release];
}

//Universal Settings
//Disable blur in ABVs
%hook _UIBackdropView
-(void)applySettings:(_UIBackdropViewSettings*)settings {
	if (enabled && blur && blurOkay && !(self.class == objc_getClass("NBBackdropView")) && !(self.class == objc_getClass("UIKBBackdropView"))) { //Excludes UIKBBackdropView from Universal Blur due to black keyboards having sloppy backdrops on their keys
		_UIBackdropViewSettings *noBlurSettings = [_UIBackdropViewSettings settingsForStyle:[self style]];
		noBlurSettings.grayscaleTintAlpha = (otint) ? utint : settings.grayscaleTintAlpha;
		noBlurSettings.scale = 1.0;
		noBlurSettings.blurRadius = 0.0;
		noBlurSettings.grayscaleTintLevel = (olevel) ? ulevel : settings.grayscaleTintLevel;
		noBlurSettings.colorTintAlpha = (otint) ? utint : settings.colorTintAlpha;
		%orig(noBlurSettings);
	}
	else {
		%orig(settings);
	}
}
%end
//Disable Blur in FBVs
%hook _UIBackdropViewSettings
-(CGFloat)blurRadius {
	return (enabled && blur && blurOkay) ? 0.0 : %orig;
}
-(CGFloat)grayscaleTintAlpha {
	return (enabled && blur && blurOkay && otint) ? utint : %orig;
}
-(CGFloat)colorTintAlpha {
	return (enabled && blur && blurOkay && otint) ? utint : %orig;
}
-(CGFloat)grayscaleTintLevel {
	return (enabled && blur && blurOkay && olevel) ? ulevel : %orig;
}
-(CGFloat)scale {
	return (enabled && blur && blurOkay) ? 1.0 : %orig;
}
%end

//Individual Options
//App Switcher homepage
//iOS 9
%hook SBSwitcherWallpaperPageContentView
-(id)wallpaperEffectView {
	return (enabled && appSwitch) ? NULL : %orig;
}
%end
%hook SBAppSwitcherSettings
-(CGFloat)deckSwitcherBackgroundBlurRadius {
	return (enabled && appSwitch) ? 0 : %orig;
}
-(CGFloat)deckSwitcherBackgroundDarkeningFactor {
	return (enabled && appSwitch) ? 0 : %orig;
}
%end
//iOS 8
%hook SBAppSwitcherHomePageCellView
-(void) layoutSubviews {
	if (!(enabled && appSwitch))
		%orig;
}
%end
//iOS 7
%hook SBAppSliderHomePageCellView
-(void) layoutSubviews {
	if (!(enabled && appSwitch))
		%orig;
}
%end

//Lockscreen
//iOS 10
%hook SBUIPasscodeLockViewBase
-(void)layoutSubviews {
	%orig;
	if (enabled && lockBlur) {
		self.backgroundAlpha = 0.0;
	}
}
%end
%hook SBDashBoardBackgroundView
-(void)layoutSubviews {
	%orig;	
	if (enabled && lockBlur) {
		_UIBackdropViewSettings *lsblur = self.backdropView.inputSettings;
		lsblur.blurRadius = 0;
		lsblur.grayscaleTintAlpha = ltint;
		[self.backdropView transitionToSettings:lsblur];
		[self.backdropView _setBlursBackground:NO];
	}
}
%end
//iOS 7-9
%hook SBLockOverlayStyleProperties
-(CGFloat) tintAlpha {
	return (enabled && lockBlur) ? ltint : %orig;
}
-(CGFloat) blurRadius {
	return (enabled && lockBlur) ? 0 : %orig;
}
%end

//Folder Background
%hook SBFolderBackgroundView
-(id) initWithFrame:(CGRect)arg1 {
	if (enabled && foldBBlur) {
		[self release];
		return NULL;
	}
	return %orig;
}
%end

//Folder Icon
%hook SBIconColorSettings
-(CGFloat) colorAlpha {
	return (enabled && foldIBlur) ? 0 : %orig;
}
-(CGFloat) whiteAlpha {
	return (enabled && foldIBlur) ? 0 : %orig;
}
-(BOOL) blurryFolderIcons {
	return (enabled && foldIBlur) ? NO : %orig;
}
%end

//Replace Blurs
%hook SBFWallpaperSettings
-(BOOL) replaceBlurs {
	return (enabled && (foldIBlur || replaceBlur)) ? YES : %orig;
}
%end

//Spotlight
%hook _SBSearchBackdropView
-(void)transitionIncrementallyToPrivateStyle:(long long)arg1 weighting:(CGFloat)arg2 {
	if (!(enabled && sblur))
		%orig;
}
%end

//Dock
%hook SBDockView
-(void)layoutSubviews {
	%orig;
	if (enabled && dockBlur)
		[self setBackgroundAlpha:0];
}
-(void)setBackgroundAlpha:(CGFloat)alpha  {
	if (enabled && dockBlur)
		alpha = 0;	
	%orig(alpha);
}
%end
//Control Center
//iOS ?-9
%hook SBControlCenterContentContainerView
-(void)layoutSubviews {
	%orig;	
	if (enabled && cc) {
		_UIBackdropViewSettings *ccblur = self.backdropView.inputSettings;
		ccblur.blurRadius = 0;
		ccblur.grayscaleTintAlpha = cctint;
		[self.backdropView transitionToSettings:ccblur];
		[self.backdropView _setBlursBackground:NO];
	}
}
%end
//iOS 10
%hook CCUIControlCenterPagePlatterView
-(void)layoutSubviews {
	%orig;	
	if (enabled && cc) {
		NCMaterialView* materialView = MSHookIvar<NCMaterialView*>(self, "_baseMaterialView");
		_UIBackdropView* backdropView = MSHookIvar<_UIBackdropView*>(materialView, "_backdropView");
		_UIBackdropViewSettings *controlCenterBlurSettings = backdropView.inputSettings;

		controlCenterBlurSettings.blurRadius = 0;
		controlCenterBlurSettings.grayscaleTintAlpha = cctint;

		[backdropView transitionToSettings:controlCenterBlurSettings];
		[backdropView _setBlursBackground:NO];
	}
}
%end

//Notification Center
%hook SBNotificationCenterViewController
-(void)viewWillLayoutSubviews {
	%orig;
	if (enabled && nc) {
		_UIBackdropViewSettings *ncblur = self.backdropView.inputSettings;
		ncblur.blurRadius = 0;
		ncblur.grayscaleTintAlpha = nctint;
		[self.backdropView transitionToSettings:ncblur];
		[self.backdropView _setBlursBackground:NO];
	}
}
%end

//Banners
%hook SBBannerContextView
-(void)layoutSubviews {
	%orig;
	if (enabled && bb) {
		_UIBackdropViewSettings *bblur = self.backdrop.inputSettings;
		bblur.blurRadius = 0;
		bblur.grayscaleTintAlpha = btint;
		[self.backdrop transitionToSettings:bblur];
		[self.backdrop _setBlursBackground:NO];
	}
}
%end

//Navigation Bar
%hook UINavigationBar
-(void)layoutSubviews {
	%orig;
	if (enabled && navbar) {
		[self setBackgroundImage:[[[UIImage alloc] init] autorelease] forBarMetrics:UIBarMetricsDefault];			
		self.shadowImage = [[[UIImage alloc] init] autorelease];			
		self.translucent = YES;			
		self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
	}
}
%end

//Keyboard
//Need to find another way of doing this, this current way doesn't allow for tint changing...
%hook UIKBBackdropView
-(void)applySettings:(id)settings {
	if (enabled && keyblur) {
		settings = [_UIBackdropViewSettings settingsForStyle:390];
	}	
	%orig(settings);
}
%end

//Quick Reply
%hook SBBannerContainerView
-(CGRect)_backgroundFrame {
	return (enabled && qrblur) ? CGRectZero : %orig;
}
%end

//Contact Picture
%hook PHAudioCallViewController
-(_Bool)setCallForBackgroundImage:(id)image animated:(_Bool)anim blurred:(_Bool)blur
{
	return (enabled && callblur) ? %orig(image, anim, NO) : %orig;
}
%end

//Siri
%hook AFUISiriView
-(id)dimBackdropSettings {
    if(enabled && siri) {
    	_UIBackdropViewSettings *siriBlurSettings = [_UIBackdropViewSettings settingsForStyle:2030 graphicsQuality:10];
    	[siriBlurSettings setGrayscaleTintAlpha:siriTintAlpha];
    	return siriBlurSettings;
    }
    else {
    	return %orig;
    }
}
%end

//Volume HUD
%hook SBHUDView
-(void)layoutSubviews {
	%orig;
	if (enabled && volumeHUD) {
		_UIBackdropView* volumeBackdrop = MSHookIvar<_UIBackdropView*>(self, "_backdropView");
		_UIBackdropViewSettings *hudblur = volumeBackdrop.inputSettings;
		// [hudblur retain];
		hudblur.blurRadius = 0;
		hudblur.grayscaleTintAlpha = HUDTintAlpha;
		[volumeBackdrop transitionToSettings:hudblur];
		// [hudblur release];
		[volumeBackdrop _setBlursBackground:NO];
	}
}
%end

//Video Player
%hook MPVideoPlaybackOverlayView
-(void)layoutSubviews {
	%orig;
	if (enabled && videoPlayer) {
		_UIBackdropView *topBar = MSHookIvar<_UIBackdropView*>(self, "_topBarBackdropView");
		_UIBackdropView *bottomBar = MSHookIvar<_UIBackdropView*>(self, "_bottomBarBackdropView");
		_UIBackdropViewSettings *topBlur = topBar.inputSettings;
		_UIBackdropViewSettings *bottomBlur = bottomBar.inputSettings;
		topBlur.blurRadius = 0;
		topBlur.grayscaleTintAlpha = 0.2;
		[topBar transitionToSettings:topBlur];
		[topBar _setBlursBackground:NO];
		bottomBlur.blurRadius = 0;
		bottomBlur.grayscaleTintAlpha = 0.2;
		[bottomBar transitionToSettings:topBlur];
		[bottomBar _setBlursBackground:NO];
	}
}
%end

//Force Touch
%hook SBApplicationShortcutMenu
-(void)layoutSubviews {
	if (enabled && forceTouch) {
		_UIBackdropViewSettings *forceTouchBlur = MSHookIvar<_UIBackdropViewSettings*>(self, "_blurSettings");
		// [hudblur retain];
		forceTouchBlur.blurRadius = 0;
		forceTouchBlur.grayscaleTintAlpha = FTTintAlpha;
		forceTouchBlur.colorTintAlpha = FTTintAlpha;
	}
}
%end

%ctor {
	reloadPrefs();
	dlopen("/System/Library/PrivateFrameworks/AssistantUI.framework/AssistantUI", RTLD_NOW);
	if ([[NSFileManager defaultManager] fileExistsAtPath:OldNBPrefsPath]) {
		HBLogError(@"Old Preferences File Detected, moving to new one...");
		NSError *error = nil;
		if (![[NSFileManager defaultManager] moveItemAtPath:OldNBPrefsPath toPath:NBPrefsPath error:&error]) {
			HBLogError(@"Failed to move '%@' to '%@': %@", OldNBPrefsPath, NBPrefsPath, [error localizedDescription]);
		}
		else {
			HBLogInfo(@"Preference plist Moved!  Have a Nice Day!");
		}
		NSError *error2 = nil;
		if ([[NSFileManager defaultManager] isDeletableFileAtPath:OldNBPrefsPath]) {
		    if (![[NSFileManager defaultManager] removeItemAtPath:OldNBPrefsPath error:&error2]) {
		        HBLogError(@"Error removing file at path: %@", error.localizedDescription);
		    }
		}
	}
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:NBPrefsPath];
	NSString *budID = [[NSBundle mainBundle] bundleIdentifier];
	if ([dict objectForKey:@"com.apple.UIKit"] ? [[dict objectForKey:@"com.apple.UIKit"] boolValue] : YES) {
		blurOkay = !([dict objectForKey:budID] ? [[dict objectForKey:budID] boolValue] : NO);
	}
	else {
		blurOkay = ([dict objectForKey:[NSString stringWithFormat:@"%@-enabled", budID]] ? [[dict objectForKey:[NSString stringWithFormat:@"%@-enabled", budID]] boolValue] : NO);
	}
	[dict release];
}