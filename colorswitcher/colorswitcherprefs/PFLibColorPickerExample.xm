//
//  PFLibColorPickerExample.xm
//  PFLibColorPickerExample
//
//  Created by rob311 on 06.07.2015.
//  Copyright (c) 2015 rob311. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "libcolorpicker.h" // local since it's in or proj folder
#import "PFLibColorPickerExample.h"

void refreshPrefs()
{
		if(kCFCoreFoundationVersionNumber > 900.00){ // if iOS 8.0 or higher, load prefs the new way

			[settings release];
			CFStringRef appID = CFSTR("com.rob311.pflibcolorpickerexample");
			CFArrayRef keyList = CFPreferencesCopyKeyList(appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
			if(keyList)
			{
				settings = (NSMutableDictionary *)CFPreferencesCopyMultiple(keyList, appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
				CFRelease(keyList);
			}
			else
			{
				settings = nil;
			}
		}
		else
		{
			[settings release];
			settings = [[NSMutableDictionary alloc] initWithContentsOfFile:[kPFLibColorPickerExampleSettings stringByExpandingTildeInPath]]; //Load settings the old way.
	}
}

static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
refreshPrefs();
}

%group main

%hook UILabel

-(void)setTextColor:(UIColor *)labelTextColor
{
	if(settings != nil && ([settings count] != 0) && [[settings objectForKey:@"enabled"] boolValue]) //Check if tweak is enabled and settings were loaded properly
	{
			%orig (LCPParseColorString([settings objectForKey:@"aColor"], @"#F98D20")); //Tweak is enabled but the user hasn't picked a color yet. So we set it to the same color as our color_fallback key in the Preference pflibcolorpickerexampleprefs/Resources/PFLibColorPickerExamplePrefs.plist. (In this case we chose #F98D20)
	}
	else
	{
		%orig;	//Call original color. The tweak was either not enabled or the settings never loaded (happens on first run)
	}
}

-(void)setShadowColor:(UIColor *)labelTextShadowColor
{
	if(settings != nil && ([settings count] != 0) && [[settings objectForKey:@"enabled"] boolValue])
	{
			%orig (LCPParseColorString([settings objectForKey:@"aColor2"], @"#FFFFFF"));
	}
	else
	{
		%orig;
	}
}
%end

%end

    %ctor {
	@autoreleasepool {
		settings = [[NSMutableDictionary alloc] initWithContentsOfFile:[kPFLibColorPickerExampleSettings stringByExpandingTildeInPath]];
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) PreferencesChangedCallback, CFSTR("com.rob311.pflibcolorpickerexample.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
		refreshPrefs();
		%init(main);
	}
}
