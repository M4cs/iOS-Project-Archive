#include <substrate.h>

NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:
  [NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"pro.evanwalters.prefs.plist"]];
NSNumber* blur = [settings objectForKey:@"blur"];


%hook SBIconColorSettings
if ([nest boolValue] == YES){
    -(bool) blurryFolderIcons {
    return TRUE;
    }
}
%end

%hook SBIconColorSettings
if ([nest boolValue] == YES){
    -(double) colorAlpha {
    return 0;
    }
}
%end

%hook SBIconColorSettings
if ([nest boolValue] == YES){
    -(double) whiteAlpha {
    return 0;
    }
}
%end

%hook SBFWallpaperSettings
if ([nest boolValue] == YES){
    -(bool) replaceBlurs {
    return TRUE;
    }
}
%end