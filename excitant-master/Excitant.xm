#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <FrontBoardServices/FBSSystemService.h>
#import <spawn.h>
#import <notify.h>
#import <sys/wait.h>
#import "AppList.h"
#import <Foundation/Foundation.h>
#include <Excitant.h>
#include <libexcitant.h>



#define PLIST_PATH @"/var/mobile/Library/Preferences/EXCITANTTAPS.plist"
#define EXCITANTTOUCHES_PATH @"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"
#define kVolPath @"/var/mobile/Library/Preferences/com.midnightchips.volume.plist"
#define kHijackSettingsChangedNotification (CFStringRef)@"EXCITANTTOUCHES.plist/saved"
//Testing Lonestar Prefs
#define kIdentifier @"com.midnightchips.volume"
#define kSettingsChangedNotification (CFStringRef)@"com.midnightchips.volume.plist/ReloadPrefs"
#define kSettingsPath @"/var/mobile/Library/Preferences/com.midnightchips.volume.plist"
// Status Bar Shit
inline bool GetPrefBool(NSString *key) {
  return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}

inline int GetPrefInt(NSString *key) {
  return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] intValue];
}

inline float GetPrefFloat(NSString *key) {
  return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] floatValue];
}
//Loading for UIView taps
inline bool GetTouchBool(NSString *key) {
  return [[[NSDictionary dictionaryWithContentsOfFile:EXCITANTTOUCHES_PATH] valueForKey:key] boolValue];
}
/*inline bool GetVolumeBool(NSString *key) {
  return [[[NSDictionary dictionaryWithContentsOfFile:Volume_PATH] valueForKey:key] boolValue];
}*/
inline float GetTouchFloats(NSString *key) {
  return [[[NSDictionary dictionaryWithContentsOfFile:EXCITANTTOUCHES_PATH] valueForKey:key] floatValue];
}
static NSString *tapapp;
// End the Status Bar Shit
//HomeHijack Stuff
static NSString *selectedApp; //Applist stuff
static NSString *tapLaunch; //TripleTap Launcher
static NSString *volUp; //Volume Up String
static NSString *volDown; //Volume Down String
static NSString *switchApp; //EzLauncher Applist




static void loadSwitchApp() { //Siri Version applist
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.chilaxan.ezswitchprefs"];
switchApp = [prefs objectForKey:@"switchApp"]; //Setting up variables
}



static void loadPrefsVolAppUp() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:kSettingsPath];
volUp = [prefs objectForKey:@"volUp"]; //Setting up variables
}

static void loadPrefsVolAppDown() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:kSettingsPath];
volDown = [prefs objectForKey:@"volDown"]; //Setting up variables
}
//Vol Prefs
static BOOL enableFlashUP;
static BOOL enableRespringUP;
static BOOL enablePowerUP;
static BOOL enableFlashDown;
static BOOL enableRespringDown;
static BOOL enablePowerDown;
static BOOL enableVolUpSkip;
static BOOL enableVolDownSkip;
static BOOL enableVolUpCC;
static BOOL enableVolDownCC;


static void reloadVolPrefs() { //Vol Prefs
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:kVolPath]];
    enableFlashUP = defaults[@"kVolUpFlash"] ? [defaults[@"kVolUpFlash"] boolValue] : NO;
    enableRespringUP = defaults[@"kVolUpRespring"] ? [defaults[@"kVolUpRespring"] boolValue] : NO;
    enablePowerUP = defaults[@"kVolUpBat"] ? [defaults[@"kVolUpBat"] boolValue] : NO;
    enableVolUpSkip = defaults[@"kVolUpSkip"] ? [defaults[@"kVolUpSkip"] boolValue] : NO;
    enableVolUpCC = defaults[@"kVolUpCC"] ? [defaults[@"kVolUpCC"] boolValue] : NO;

    enableFlashDown = defaults[@"kVolDownFlash"] ? [defaults[@"kVolDownFlash"] boolValue] : NO;
    enableVolDownCC = defaults[@"kVolDownCC"] ? [defaults[@"kVolDownCC"] boolValue] : NO;
    enableVolDownSkip = defaults[@"kVolDownSkip"] ? [defaults[@"kVolDownSkip"] boolValue] : NO;
    enableRespringDown = defaults[@"kVolDownRespring"] ? [defaults[@"kVolDownRespring"] boolValue] : NO;
    enablePowerDown = defaults[@"kVolDownBat"] ? [defaults[@"kVolDownBat"] boolValue] : NO;
    NSLog(@"Toggled On %d", enableFlashDown);
}


static BOOL siriCC;
static BOOL siriRespring;
static BOOL siriBat;
static BOOL siriFlash;
static BOOL tritapCC;
static BOOL tritapRespring;
static BOOL tritapBat;
static BOOL tritapFlash;

static void reloadHijackPrefs() { //Vol Prefs
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:EXCITANTTOUCHES_PATH]];
    siriCC = defaults[@"kCC"] ? [defaults[@"kCC"] boolValue] : NO;
    siriRespring = defaults[@"kSiriRespring"] ? [defaults[@"kSiriRespring"] boolValue] : NO;
    siriBat = defaults[@"kSiriBat"] ? [defaults[@"kSiriBat"] boolValue] : NO;
    siriFlash = defaults[@"siriFlash"] ? [defaults[@"siriFlash"] boolValue] : NO;
    tritapRespring = defaults[@"kRespring"] ? [defaults[@"kRespring"] boolValue] : NO;
    tritapCC = defaults[@"kCCTap"] ? [defaults[@"kCCTap"] boolValue] : NO;
    tritapBat = defaults[@"kTapBat"] ? [defaults[@"kTapBat"] boolValue] : NO;
    tritapFlash = defaults[@"kTapFlash"] ? [defaults[@"kTapFlash"] boolValue] : NO;
}

void updateSettings(CFNotificationCenterRef center,
                    void *observer,
                    CFStringRef name,
                    const void *object,
                    CFDictionaryRef userInfo) {
    reloadVolPrefs();
    reloadHijackPrefs();
}


//Mute Switch
NSString *switchpath = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/com.chilaxan.ezswitchprefs.plist"];
NSDictionary *switchsettings = [NSMutableDictionary dictionaryWithContentsOfFile:switchpath];

static BOOL isEzSwitchEnabled = (BOOL)[[switchsettings objectForKey:@"switchenabled"]?:@TRUE boolValue];
static NSInteger switchPreference = (NSInteger)[[switchsettings objectForKey:@"switchPreferences"]?:@9 integerValue];
//End Mute Switch Prefs

//Touches Prefs
inline bool GetPrefTouchesBool(NSString *key) {
return [[[NSDictionary dictionaryWithContentsOfFile:EXCITANTTOUCHES_PATH] valueForKey:key] boolValue]; //Looks for bool
}

//Touches Applist
static NSString *touchesRightBottom;
static NSString *touchesRightMiddle;
static NSString *touchesRightTop;
static NSString *touchesLeftBottom;
static NSString *touchesLeftMiddle;
static NSString *touchesLeftTop;



static void loadPrefsTouchesRightBottom() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"];
touchesRightBottom = [prefs objectForKey:@"touchesAppRightBottom"]; //Setting up variables
}

static void loadPrefsTouchesLeftBottom() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"];
touchesLeftBottom = [prefs objectForKey:@"touchesAppLeftBottom"]; //Setting up variables
}

static void loadPrefsTouchesLeftMiddle() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"];
touchesLeftMiddle = [prefs objectForKey:@"touchesAppLeftMiddle"]; //Setting up variables
}

static void loadPrefsTouchesRightMiddle() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"];
touchesRightMiddle = [prefs objectForKey:@"touchesAppRightMiddle"]; //Setting up variables
}

static void loadPrefsTouchesRightTop() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"];
touchesRightTop = [prefs objectForKey:@"touchesAppRightTop"]; //Setting up variables
}

static void loadPrefsTouchesLeftTop() { //Triple Tap version
NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTOUCHES.plist"];
touchesLeftTop = [prefs objectForKey:@"touchesAppLeftTop"]; //Setting up variables
}



@implementation ExcitantWindow
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIWindow *window in self.subviews) {
        if (!window.hidden && window.userInteractionEnabled && [window pointInside:[self convertPoint:point toView:window] withEvent:event])
            return YES;
    }
    return NO;
}
@end

@implementation ExcitantView
@end


//Start VolSkip11


%group volFunction
NSTimer *timer;
BOOL volUpButtonIsDown;
BOOL volDownButtonIsDown;

%hook SBVolumeHardwareButtonActions

-(void)volumeIncreasePressDown
{
	//HBLogInfo(@"************volumeIncreasePressDown");

	if([%c(SBMediaController) applicationCanBeConsideredNowPlaying:[[%c(SBMediaController) sharedInstance] nowPlayingApplication]] == NO)
	{
	%orig;
    volUpButtonIsDown = YES;
      timer = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(handleTimer:) userInfo: @1 repeats: NO];
	}
	else
	{
			volUpButtonIsDown = YES;
		    timer = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(handleTimer:) userInfo: @1 repeats: NO];
	}
}

-(void)volumeIncreasePressUp
{
	//	HBLogInfo(@"************volumeIncreasePressUp");
	if (volDownButtonIsDown == YES)
		{
			[timer invalidate];
			timer = nil;
			[[%c(SBMediaController) sharedInstance] togglePlayPause];
			//volUpButtonIsDown = NO;
			//volDownButtonIsDown = NO;
		}
	if([%c(SBMediaController) applicationCanBeConsideredNowPlaying:[[%c(SBMediaController) sharedInstance] nowPlayingApplication]] == NO)
	{
    %orig;
	}

	else
	{
		// [timer invalidate];
		timer = nil;

		if(volUpButtonIsDown == YES)
		{
			[[%c(SBMediaController) sharedInstance] _changeVolumeBy:0.062500];
			volUpButtonIsDown = NO;
		}
	}
}

-(void)volumeDecreasePressDown
{
	//HBLogInfo(@"************volumeDecreasePressDown");
	//if([%c(SBMediaController) applicationCanBeConsideredNowPlaying:[[%c(SBMediaController) sharedInstance] nowPlayingApplication]] == NO)
	if([%c(SBMediaController) applicationCanBeConsideredNowPlaying:[[%c(SBMediaController) sharedInstance] nowPlayingApplication]] == NO)
	{
	%orig;
    volDownButtonIsDown = YES;
	    timer = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(handleTimer:) userInfo: @-1 repeats: NO];
	}
	else
	{
		volDownButtonIsDown = YES;
	    timer = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(handleTimer:) userInfo: @-1 repeats: NO];
	}
}

-(void)volumeDecreasePressUp
{
		//HBLogInfo(@"************volumeDecreasePressUp");

	if([%c(SBMediaController) applicationCanBeConsideredNowPlaying:[[%c(SBMediaController) sharedInstance] nowPlayingApplication]] == NO)
	{
    %orig;
	}
	else
	{
		// [timer invalidate];
		timer = nil;

		if(volDownButtonIsDown == YES)
		{
			[[%c(SBMediaController) sharedInstance] _changeVolumeBy:-0.062500];
			volDownButtonIsDown = NO;
		}
	}
}

%new
-(void)handleTimer:(NSTimer *)timer{
	if( (volUpButtonIsDown == YES && [[timer userInfo] intValue] == 1) || ( volDownButtonIsDown == YES &&[[timer userInfo] intValue] == -1) ) {

    /*static BOOL enableFlashUP
    static BOOL enableRespringUP
    static BOOL enablePowerUP
    static BOOL enableFlashDown
    static BOOL enableRespringDown
    static BOOL enablePowerDown*/
    if ([[timer userInfo] intValue] == 1){
    //Battery Saver
    loadPrefsVolAppUp();
    reloadVolPrefs();
    if(enablePowerUP == YES){
        [Excitant AUXtoggleLPM];
        NSLog(@"Running Toggle");
        volUpButtonIsDown = NO;
    		volDownButtonIsDown = NO;

        }else if(enableRespringUP == YES){
        [Excitant AUXrespring];
        volUpButtonIsDown = NO;
    		volDownButtonIsDown = NO;

        }else if(enableVolUpCC == YES){
          [Excitant AUXcontrolCenter];
          volUpButtonIsDown = NO;
      		volDownButtonIsDown = NO;

        }else if(enableFlashUP == YES){
        //Flashlight
            [Excitant AUXtoggleFlash];
            volUpButtonIsDown = NO;
        		volDownButtonIsDown = NO;
      }
      else if (volUp != nil) {
        [Excitant AUXlaunchApp:volUp];
        volUpButtonIsDown = NO;
    		volDownButtonIsDown = NO;
      }
      else if (enableVolUpSkip == YES){
        HBLogInfo(@"************handleTimer");

  		[[%c(SBMediaController) sharedInstance] changeTrack:[[timer userInfo] intValue]];
  		volUpButtonIsDown = NO;
  		volDownButtonIsDown = NO;
      }else{
      }
      /*static BOOL enableFlashUP
      static BOOL enableRespringUP
      static BOOL enablePowerUP
      static BOOL enableFlashDown
      static BOOL enableRespringDown
      static BOOL enablePowerDown*/
	}else if ([[timer userInfo] intValue] == -1){
    loadPrefsVolAppDown();
    reloadVolPrefs();
    //Battery Saver
    if(enablePowerDown == YES){
        [Excitant AUXtoggleLPM];
        volUpButtonIsDown = NO;
    		volDownButtonIsDown = NO;
        }else if(enableRespringDown == YES){
        [Excitant AUXrespring];
        volUpButtonIsDown = NO;
    		volDownButtonIsDown = NO;
        }else if(enableVolDownCC == YES){
          [Excitant AUXcontrolCenter];
          volUpButtonIsDown = NO;
      		volDownButtonIsDown = NO;
        }else if(enableFlashDown == YES){
        //Flashlight
            [Excitant AUXtoggleFlash];
            volUpButtonIsDown = NO;
        		volDownButtonIsDown = NO;
      }
      else if (volDown != nil) {
        [Excitant AUXlaunchApp:volDown];
        volUpButtonIsDown = NO;
    		volDownButtonIsDown = NO;
      }else if (enableVolDownSkip == YES){
        [[%c(SBMediaController) sharedInstance] changeTrack:[[timer userInfo] intValue]];
    		volUpButtonIsDown = NO;
    		volDownButtonIsDown = NO;
      }else{

      }

  }
}
}
%end
%end

//End VolSkip11
// Example //
// %hook SBHomeHardwareButtonActions
// -(void)performTriplePressUpActions{
// 	[Excitant AUXtoggleFlash];
// }
// %end
// Example


// TapTapUtils Shit
// NSNumber* uicache;
// NSNumber* respring;
// NSNumber* rebootd;
// NSNumber* safemode;
// NSNumber* shutdownd;
// NSNumber* sleepdd;
//TapTapUtilsShit

//Just hard coding in some gesture recognizers
/* hi */
%group Main
ExcitantView *rightBottomView;
ExcitantView *leftBottomView;
ExcitantView *rightMiddleView;
ExcitantView *leftMiddleView;
ExcitantView *leftTopView;
ExcitantView *rightTopView;
// dont use global, there is almost never reason to use it


%hook SpringBoard
-(void)applicationDidFinishLaunching:(id)application {
	float width = GetTouchFloats(@"vWidth");
    float height = GetTouchFloats(@"vHeight");
//Side Subviews
    %orig;
		UIWindow * screen = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];

		rightBottomView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.size.width, screen.bounds.size.height, - width, - height)];
			if(GetPrefTouchesBool(@"setColor")){
				[rightBottomView setBackgroundColor:[UIColor redColor]];
			}else{
				[rightBottomView setBackgroundColor:[UIColor colorWithWhite:0.001 alpha:0.001]];
			}
	    [rightBottomView setAlpha: 1];
			[rightBottomView setHidden:NO];
	    rightBottomView.userInteractionEnabled = TRUE;

		  leftBottomView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.origin.x, screen.bounds.size.height, width, - height)];
			if(GetPrefTouchesBool(@"setColor")){
				[leftBottomView setBackgroundColor:[UIColor redColor]];
			}else{
			[leftBottomView setBackgroundColor:[UIColor colorWithWhite:0.001 alpha:0.001]];
		  }
	    [leftBottomView setAlpha: 1];
			[leftBottomView setHidden:NO];
	    leftBottomView.userInteractionEnabled = TRUE;

			rightMiddleView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.size.width, screen.bounds.size.height*.60, - width, - height)];
				if(GetPrefTouchesBool(@"setColor")){
					[rightMiddleView setBackgroundColor:[UIColor blueColor]];
				}else{
					[rightMiddleView setBackgroundColor:[UIColor colorWithWhite:0.001 alpha:0.001]];
				}
		    [rightMiddleView setAlpha: 1];
				[rightMiddleView setHidden:NO];
		    rightMiddleView.userInteractionEnabled = TRUE;

			leftMiddleView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.origin.x, screen.bounds.size.height*.60, width, - height)];
				if(GetPrefTouchesBool(@"setColor")){
					[leftMiddleView setBackgroundColor:[UIColor blueColor]];
				}else{
				[leftMiddleView setBackgroundColor:[UIColor colorWithWhite:0.001 alpha:0.001]];
			  }
		    [leftMiddleView setAlpha: 1];
				[leftMiddleView setHidden:NO];
		    leftMiddleView.userInteractionEnabled = TRUE;

				rightTopView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.size.width, screen.bounds.size.height*0.001, - width,  height)];
					if(GetPrefTouchesBool(@"setColor")){
						[rightTopView setBackgroundColor:[UIColor greenColor]];
					}else{
						[rightTopView setBackgroundColor:[UIColor colorWithWhite:0.001 alpha:0.001]];
					}
			    [rightTopView setAlpha: 1];
					[rightTopView setHidden:NO];
			    rightTopView.userInteractionEnabled = TRUE;

				leftTopView=[[ExcitantView alloc]initWithFrame:CGRectMake(screen.bounds.origin.x, screen.bounds.size.height*0.001, width,  height)];
					if(GetPrefTouchesBool(@"setColor")){
						[leftTopView setBackgroundColor:[UIColor greenColor]];
					}else{
					[leftTopView setBackgroundColor:[UIColor colorWithWhite:0.001 alpha:0.001]];
				  }
			    [leftTopView setAlpha: 1];
					[leftTopView setHidden:NO];
			    leftTopView.userInteractionEnabled = TRUE;

		ExcitantWindow *window = [[ExcitantWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
		window.windowLevel = 1005;
		[window setHidden:NO];
		[window setAlpha:1.0];
		[window setBackgroundColor:[UIColor clearColor]];
        if(GetTouchBool(@"enableRB")){
        [window addSubview:rightBottomView];
    }else {nil;}
      if(GetTouchBool(@"enableRM")){
		[window addSubview:rightMiddleView];
    }else {nil;}
       if(GetTouchBool(@"enableRT")){
		[window addSubview:rightTopView];
    }else {nil;}
       if(GetTouchBool(@"enableLB")){
		[window addSubview:leftBottomView];
    }else {nil;}
       if(GetTouchBool(@"enableLM")){
		[window addSubview:leftMiddleView];
    }else {nil;}
       if(GetTouchBool(@"enableLT")){
		[window addSubview:leftTopView];
    }else {nil;}

/*UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapTapUtils)];
tapRecognizer.numberOfTapsRequired = 2;
[self addGestureRecognizer:tapRecognizer];*/


		UITapGestureRecognizer *rightBottomRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerBottomRight:)];
		if(GetPrefTouchesBool(@"taps2")){
	    rightBottomRecognizer.numberOfTapsRequired = 2;
			[rightBottomView addGestureRecognizer:rightBottomRecognizer];
		}else if(GetPrefTouchesBool(@"taps3")){
			rightBottomRecognizer.numberOfTapsRequired = 3;
			[rightBottomView addGestureRecognizer:rightBottomRecognizer];
		}else if (GetPrefTouchesBool(@"taps4")){
			rightBottomRecognizer.numberOfTapsRequired = 4;
			[rightBottomView addGestureRecognizer:rightBottomRecognizer];
		}else{
			rightBottomRecognizer.numberOfTapsRequired = 1;
	    [rightBottomView addGestureRecognizer:rightBottomRecognizer];
		}

		UITapGestureRecognizer *leftBottomRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerBottomLeft:)];
		if(GetPrefTouchesBool(@"taps2")){
			leftBottomRecognizer.numberOfTapsRequired = 2;
			[leftBottomView addGestureRecognizer:leftBottomRecognizer];
		}else if(GetPrefTouchesBool(@"taps3")){
			leftBottomRecognizer.numberOfTapsRequired = 3;
			[leftBottomView addGestureRecognizer:leftBottomRecognizer];
		}else if (GetPrefTouchesBool(@"taps4")){
			leftBottomRecognizer.numberOfTapsRequired = 4;
			[leftBottomView addGestureRecognizer:leftBottomRecognizer];
		}else{
			leftBottomRecognizer.numberOfTapsRequired = 1;
			[leftBottomView addGestureRecognizer:leftBottomRecognizer];
		}

		UITapGestureRecognizer *leftMiddleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerLeftMiddle:)];
		if(GetPrefTouchesBool(@"taps2")){
			leftMiddleRecognizer.numberOfTapsRequired = 2;
			[leftMiddleView addGestureRecognizer:leftMiddleRecognizer];
		}else if(GetPrefTouchesBool(@"taps3")){
			leftMiddleRecognizer.numberOfTapsRequired = 3;
			[leftMiddleView addGestureRecognizer:leftMiddleRecognizer];
		}else if (GetPrefTouchesBool(@"taps4")){
			leftMiddleRecognizer.numberOfTapsRequired = 4;
			[leftMiddleView addGestureRecognizer:leftMiddleRecognizer];
		}else{
			leftMiddleRecognizer.numberOfTapsRequired = 1;
			[leftMiddleView addGestureRecognizer:leftMiddleRecognizer];
		}

		UITapGestureRecognizer *rightMiddleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerRightMiddle:)];
		if(GetPrefTouchesBool(@"taps2")){
			rightMiddleRecognizer.numberOfTapsRequired = 2;
			[rightMiddleView addGestureRecognizer:rightMiddleRecognizer];
		}else if(GetPrefTouchesBool(@"taps3")){
			rightMiddleRecognizer.numberOfTapsRequired = 3;
			[rightMiddleView addGestureRecognizer:rightMiddleRecognizer];
		}else if (GetPrefTouchesBool(@"taps4")){
			rightMiddleRecognizer.numberOfTapsRequired = 4;
			[rightMiddleView addGestureRecognizer:rightMiddleRecognizer];
		}else{
			rightMiddleRecognizer.numberOfTapsRequired = 1;
			[rightMiddleView addGestureRecognizer:rightMiddleRecognizer];
		}

		UITapGestureRecognizer *leftTopRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerLeftTop:)];
		if(GetPrefTouchesBool(@"taps2")){
			leftTopRecognizer.numberOfTapsRequired = 2;
			[leftTopView addGestureRecognizer:leftTopRecognizer];
		}else if(GetPrefTouchesBool(@"taps3")){
			leftTopRecognizer.numberOfTapsRequired = 3;
			[leftTopView addGestureRecognizer:leftTopRecognizer];
		}else if (GetPrefTouchesBool(@"taps4")){
			leftTopRecognizer.numberOfTapsRequired = 4;
			[leftTopView addGestureRecognizer:leftTopRecognizer];
		}else{
			leftTopRecognizer.numberOfTapsRequired = 1;
			[leftTopView addGestureRecognizer:leftTopRecognizer];
		}

		UITapGestureRecognizer *rightTopRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchRecognizerRightTop:)];
		if(GetPrefTouchesBool(@"taps2")){
			rightTopRecognizer.numberOfTapsRequired = 2;
			[rightTopView addGestureRecognizer:rightTopRecognizer];
		}else if(GetPrefTouchesBool(@"taps3")){
			rightTopRecognizer.numberOfTapsRequired = 3;
			[rightTopView addGestureRecognizer:rightTopRecognizer];
		}else if (GetPrefTouchesBool(@"taps4")){
			rightTopRecognizer.numberOfTapsRequired = 4;
			[rightTopView addGestureRecognizer:rightTopRecognizer];
		}else{
			rightTopRecognizer.numberOfTapsRequired = 1;
			[rightTopView addGestureRecognizer:rightTopRecognizer];
		}

		[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(keyboardDidShow:)
                                             name:UIKeyboardDidShowNotification
                                           object:nil];

		[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(keyboardDidHide:)
                                             name:UIKeyboardDidHideNotification
                                           object:nil];
}
//End Side Subviews
//Mute Switch Function
- (void)_updateRingerState:(int)arg1 withVisuals:(BOOL)arg2 updatePreferenceRegister:(BOOL)arg3 {
  loadSwitchApp();
	if(!isEzSwitchEnabled) {
	     %orig;
	}
	if(arg1) {
		if (isEzSwitchEnabled) {
			if (switchPreference == 0) {
				[Excitant AUXtoggleFlash];
				}
			if (switchPreference == 1){
				[Excitant AUXtoggleLPM];
			}
			if (switchPreference == 2) {
                             [Excitant AUXtoggleAirplaneMode];
			}
                        if (switchPreference == 3) {
                             [Excitant AUXtoggleMute]; //DOES NOT WORK YET
			}
			if (switchPreference == 4) {
                             [Excitant AUXtoggleRotationLock];
			}
      if (switchPreference == 5) {
                              [Excitant AUXlaunchApp:switchApp];
      }
		} else {
			%orig;
		}
	}
}
//End Mute Switch Function
//Side Subviews Selectors
%new
- (void) TouchRecognizerBottomRight:(UITapGestureRecognizer *)sender {
	loadPrefsTouchesRightBottom();
	[Excitant AUXlaunchApp:touchesRightBottom];
}


%new
- (void) TouchRecognizerBottomLeft:(UITapGestureRecognizer *)sender {
	loadPrefsTouchesLeftBottom();
	[Excitant AUXlaunchApp:touchesLeftBottom];
}
%new
- (void) TouchRecognizerLeftMiddle:(UITapGestureRecognizer *)sender {
	loadPrefsTouchesLeftMiddle();
	[Excitant AUXlaunchApp:touchesLeftMiddle];
}
%new
- (void) TouchRecognizerRightMiddle:(UITapGestureRecognizer *)sender {
	loadPrefsTouchesRightMiddle();
	[Excitant AUXlaunchApp:touchesRightMiddle];
}
%new
- (void) TouchRecognizerLeftTop:(UITapGestureRecognizer *)sender {
	loadPrefsTouchesLeftTop();
	[Excitant AUXlaunchApp:touchesLeftTop];
}
%new
- (void) TouchRecognizerRightTop:(UITapGestureRecognizer *)sender {
	loadPrefsTouchesRightTop();
	[Excitant AUXlaunchApp:touchesRightTop];
}
//End Selectors, Start Observers
%new
-(void)keyboardDidShow:(NSNotification *)hideViews {
  rightBottomView.hidden = YES;
  leftBottomView.hidden = YES;
  rightMiddleView.hidden = YES;
  leftMiddleView.hidden = YES;
  leftTopView.hidden = YES;
  rightTopView.hidden = YES;
}
%new
-(void)keyboardDidHide:(NSNotification *)showViews {
  rightBottomView.hidden = NO;
  leftBottomView.hidden = NO;
  rightMiddleView.hidden = NO;
  leftMiddleView.hidden = NO;
  leftTopView.hidden = NO;
  rightTopView.hidden = NO;
}
//End Side Subviews Observers


%end


//Start HomeHijack
%hook SBAssistantController
-(void)_viewWillAppearOnMainScreen:(BOOL)arg1{
    reloadHijackPrefs();
    if(siriCC == YES){
        [Excitant AUXcontrolCenter];
        %orig;
    }else if (siriRespring == YES){
      [Excitant AUXrespring];
      }else if(siriFlash == YES){
        //Flashlight
            [Excitant AUXtoggleFlash];
          }else if (siriBat == YES){
              [Excitant AUXtoggleLPM];
              }else if(selectedApp != nil){
                  [Excitant AUXlaunchApp:selectedApp];
                  %orig(NO);
              }else{
        %orig;
    }
}

%end

%hook SBAssistantWindow
-(id)initWithScreen:(id)arg1 layoutStrategy:(id)arg2 debugName:(id)arg3 scene:(id)arg4 {
    reloadHijackPrefs();

    if (selectedApp !=nil) {
        return NULL;
    }else if(siriCC == YES){
        return NULL;
    }else if (siriBat == YES){
        return NULL;
    }else if(siriFlash == YES){
        return NULL;
    }else{
        return %orig;
    }
}
%end

%hook SBHomeHardwareButtonActions
-(void)performTriplePressUpActions{
  reloadHijackPrefs();
  /*static BOOL siriCC;
  static BOOL siriRespring;
  static BOOL siriBat;
  static BOOL siriFlash;
  static BOOL tritapCC;
  static BOOL tritapRespring;
  static BOOL tritapBat;
  static BOOL tritapFlash;*/
  if (tritapRespring == YES){
    [Excitant AUXrespring];
  }else if (tritapCC == YES){
    [Excitant AUXcontrolCenter];
    }else if(tritapFlash == YES){
    //Flashlight
        [Excitant AUXtoggleFlash];
      }
      else if (tritapBat == YES){
        [Excitant AUXtoggleLPM];
        }else if (tapLaunch != nil){
          [Excitant AUXlaunchApp:tapLaunch];
        }else{
    %orig;
  }
}
%end
//End HomeHijack



/* Tony was here
If you're reading this listen to this xxxtentacion playlist:

*/


//TapTapUtils
%hook UIStatusBarWindow

%new

-(void)TapTapUtils{
	UIAlertController *confirmationAlertController = [UIAlertController
                                    alertControllerWithTitle:@"TapTapUtils"
                                    message:@"Please pick an option"
                                    preferredStyle:UIAlertControllerStyleAlert];



        UIAlertAction* confirmRespring = [UIAlertAction
                                    actionWithTitle:@"Respring"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        notify_post("com.clarke1234.taptaprespring");
                                    }];

        UIAlertAction* confirmUiCache = [UIAlertAction
                                    actionWithTitle:@"Uicache"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        notify_post("com.clarke1234.taptapuicache");
                                    }];

		UIAlertAction* confirmReboot = [UIAlertAction
									actionWithTitle:@"Reboot"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										notify_post("com.clarke1234.taptapreboot");
									}];

		UIAlertAction* confirmSafemode = [UIAlertAction
									actionWithTitle:@"Safemode"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										notify_post("com.clarke1234.taptapsafemode");
									}];

		UIAlertAction* confirmShutdown = [UIAlertAction
									actionWithTitle:@"Shutdown"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										notify_post("com.clarke1234.taptapshutdown");
									}];

		UIAlertAction* confirmCancel = [UIAlertAction
									actionWithTitle:@"Cancel"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										//Do nothing
									}];

		UIAlertAction* confirmSleep = [UIAlertAction
                                    actionWithTitle:@"Sleep"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        notify_post("com.kietha.taptapsleep");
                                    }];

		if (GetPrefBool(@"uicache")){
        	[confirmationAlertController addAction:confirmUiCache];
		}
		if (GetPrefBool(@"respring")){
	        [confirmationAlertController addAction:confirmRespring];
		}
		if (GetPrefBool(@"reboot")){
			[confirmationAlertController addAction:confirmReboot];
		}
		if (GetPrefBool(@"safemode")){
			[confirmationAlertController addAction:confirmSafemode];
		}
		if (GetPrefBool(@"shutdown")){
			[confirmationAlertController addAction:confirmShutdown];
		}
		if (GetPrefBool(@"sleep")){
			[confirmationAlertController addAction:confirmSleep];
		}
		[confirmationAlertController addAction:confirmCancel];

        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:confirmationAlertController animated:YES completion:NULL];
}

%new

-(void)flash{
	[Excitant AUXtoggleFlash];
}

%new

-(void)lpm{
	[Excitant AUXtoggleLPM];
}

%new

-(void)apm{
	[Excitant AUXtoggleAirplaneMode];
}

%new

-(void)rotationLock{
	[Excitant AUXtoggleRotationLock];
}

%new

-(void)controlCenter{
	[Excitant AUXcontrolCenter];
}

%new

-(void)respring{
	[Excitant AUXrespring];
}

%new

-(void)lockDevice{
	[Excitant AUXlockDevice];
}
%new

- (void)launchApp {
	NSDictionary *Tapprefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/EXCITANTTAPS.plist"];
	tapapp = [Tapprefs objectForKey:@"launchAppTap"]; //doesnt work
	[Excitant AUXlaunchApp:tapapp];
}



- (instancetype)initWithFrame:(CGRect)frame {
    self = %orig;
	int taps;
	if(GetPrefBool(@"taptaps2")){
		taps = 2;
	}
	else if(GetPrefBool(@"taptaps3")){
		taps = 3;
	}
	else if(GetPrefBool(@"taptaps4")){
		taps = 4;
	}
	else {
		taps = 2;
	}
    if(GetPrefBool(@"enableUtils")){
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapTapUtils)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];

        //return self;
    }
	if(GetPrefBool(@"enableFlash")){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flash)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(GetPrefBool(@"enableLPM")){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lpm)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(GetPrefBool(@"enableAPM")){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(apm)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(GetPrefBool(@"enableRL")){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rotationLock)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(GetPrefBool(@"enableCC")){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(controlCenter)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(GetPrefBool(@"enableRespring")){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respring)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(GetPrefBool(@"enableSleep")){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lockDevice)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
	if(GetPrefBool(@"enableAppTap")){
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(launchApp)];
        tapRecognizer.numberOfTapsRequired = taps;
        [self addGestureRecognizer:tapRecognizer];
	}
    return self;
}


%end
%end


//Prefs for TapTapUtils
%ctor{
  reloadVolPrefs();
CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadVolPrefs, kSettingsChangedNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
reloadHijackPrefs();
CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadHijackPrefs, kHijackSettingsChangedNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    	@autoreleasepool {
    		%init(volFunction);
    	}@autoreleasepool{
        %init(Main)
        } //autoreleasepool for volskip, just applying it to everything rn
	NSString *currentID = NSBundle.mainBundle.bundleIdentifier;
	//NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.clarke1234.taptivatorprefs.plist"];
	// uicache = [settings objectForKey:@"uicache"];
	// respring = [settings objectForKey:@"respring"];
	// rebootd = [settings objectForKey:@"reboot"];
	// safemode = [settings objectForKey:@"safemode"];
	// shutdownd = [settings objectForKey:@"shutdown"];
	// sleepdd = [settings objectForKey:@"sleep"];
	if ([currentID isEqualToString:@"com.apple.springboard"]) {
		int regToken;
		notify_register_dispatch("com.clarke1234.taptaprespring", &regToken, dispatch_get_main_queue(), ^(int token) {
			pid_t pid;
			int status;
			const char* args[] = {"killall", "-9", "backboardd", NULL};
			posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
			waitpid(pid, &status, WEXITED);

		});
		notify_register_dispatch("com.clarke1234.taptapuicache", &regToken, dispatch_get_main_queue(), ^(int token){
			pid_t pid;
			int status;
			const char* args[] = {"uicache", NULL, NULL, NULL};
			posix_spawn(&pid, "/usr/bin/uicache", NULL, NULL, (char* const*)args, NULL);
			waitpid(pid, &status, WEXITED);
				CFRunLoopRunInMode(kCFRunLoopDefaultMode, 20.0, false);
		});
		notify_register_dispatch("com.clarke1234.taptapreboot", &regToken, dispatch_get_main_queue(), ^(int token){
			[Excitant AUXreboot];
		});
		notify_register_dispatch("com.clarke1234.taptapsafemode", &regToken, dispatch_get_main_queue(), ^(int token){
			pid_t pid;
			int status;
			const char* args[] = {"killall", "-SEGV", "SpringBoard", NULL};
			posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
			waitpid(pid, &status, WEXITED);
		});
		notify_register_dispatch("com.clarke1234.taptapshutdown", &regToken, dispatch_get_main_queue(), ^(int token){
			[Excitant AUXshutdown];
		});
		notify_register_dispatch("com.kietha.taptapsleep", &regToken, dispatch_get_main_queue(), ^(int token){
             [Excitant AUXlockDevice];
        });

}
}
