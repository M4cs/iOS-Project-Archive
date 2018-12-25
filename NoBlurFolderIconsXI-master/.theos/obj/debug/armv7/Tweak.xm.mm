#line 1 "Tweak.xm"
#include <substrate.h>

NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:
  [NSString stringWithFormat:@"%@/Library/Preferences/%@", NSHomeDirectory(), @"pro.evanwalters.prefs.plist"]];
NSNumber* blur = [settings objectForKey:@"blur"];



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

@class SBFWallpaperSettings; @class SBIconColorSettings; 


#line 8 "Tweak.xm"

if ([nest boolValue] == YES){
    -(bool) blurryFolderIcons {
    return TRUE;
    }
}



if ([nest boolValue] == YES){
    -(double) colorAlpha {
    return 0;
    }
}



if ([nest boolValue] == YES){
    -(double) whiteAlpha {
    return 0;
    }
}



if ([nest boolValue] == YES){
    -(bool) replaceBlurs {
    return TRUE;
    }
}

#line 39 "Tweak.xm"
