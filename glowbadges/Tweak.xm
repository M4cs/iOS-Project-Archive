#import <QuartzCore/QuartzCore.h>
#import "UIImage-DominantColor/UIImage+DominantColor.h"

#define kName @"GlowBadge"
#import <Custom/defines.h>

#include <stdlib.h>

#define kHideBadges 0
#define kOnlyFolders 1
#define kListApps 2
#define kShowBadges 3

@interface SBIcon : NSObject
- (id)badgeNumberOrString;
- (id)displayName;
- (id)getIconImage:(int)arg1;
- (BOOL)isFolderIcon;
@end

@interface SBIconView : UIView
@property (retain, nonatomic) SBIcon *icon;
- (CGFloat)calculateRadius;
- (BOOL)hasBadge;
@end

@interface SBFolderIconView : SBIconView
- (BOOL)folderHasBadge;
- (CGFloat)calculateFolderRadius;
@end

#define kSettingsPath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.sassoty.glowbadge.plist"]
NSDictionary* prefs = [[NSDictionary alloc] initWithContentsOfFile:kSettingsPath];
BOOL isEnabled = YES;
BOOL isFolderEnabled = YES;
int showBadge = kShowBadges;
NSArray* badgeWhitelist = [[NSArray alloc] init];
BOOL customStrengthEnabled = NO;
CGFloat customStrength = 5.0;

UIColor* daColor;
BOOL sameAsApp = NO;

NSArray* colors = [[NSArray alloc] initWithObjects:
	[UIColor yellowColor],
	[UIColor darkGrayColor],
	[UIColor lightGrayColor],
	[UIColor grayColor],
	[UIColor redColor],
	[UIColor greenColor],
	[UIColor blueColor],
	[UIColor cyanColor],
	[UIColor magentaColor],
	[UIColor orangeColor],
	[UIColor purpleColor],
	[UIColor brownColor],
	[UIColor blackColor],
	[UIColor whiteColor],
	nil
	];

void checkColor() {
	int color = [prefs[@"Color"] intValue];
	if(!prefs[@"Color"]) { color = 0; }

	if(color != 673 && color != 674) {
		sameAsApp = NO;
		daColor = colors[color];
	}else if(color == 673) {
		sameAsApp = NO;
		//Pick random color
		int r = arc4random_uniform([colors count]);
		while(r == 2) {
			r = arc4random_uniform([colors count]);
		}
		daColor = colors[r];
	}else if(color == 674){
		sameAsApp = YES;
	}else {
		sameAsApp = NO;
		daColor = [UIColor yellowColor];
	}
}

void reloadPrefs() {
	prefs = [[NSDictionary alloc] initWithContentsOfFile:kSettingsPath];
	
	isEnabled = [prefs[@"Enabled"] boolValue];
	if(!prefs[@"Enabled"]) { isEnabled = YES; }

	isFolderEnabled = [prefs[@"FoldersEnabled"] boolValue];
	if(!prefs[@"FoldersEnabled"]) { isFolderEnabled = YES; }

	showBadge = [prefs[@"ShowBadges"] intValue];
	if(!prefs[@"ShowBadges"]) { showBadge = kShowBadges; }

	badgeWhitelist = prefs[@"BadgeWhitelist"];
	if(!badgeWhitelist) { badgeWhitelist = [[NSArray alloc] init]; }

	customStrengthEnabled = [prefs[@"CustomStrengthEnabled"] boolValue];
	if(!prefs[@"CustomStrengthEnabled"]) { customStrengthEnabled = YES; }

	customStrength = [prefs[@"CustomStrength"] floatValue];
	if(!prefs[@"CustomStrength"]) { customStrength = 5.0; }

	checkColor();
}

@interface SBIconBadgeView : UIView
@end

%hook SBIconBadgeView

- (void)layoutSubviews {
	%orig;
	if(!isEnabled) {
		self.hidden = NO;
	}
	SBIconView* iconView = (SBIconView *)[self superview];
	switch(showBadge) {
		case kHideBadges:
			self.hidden = YES;
			break;
		case kOnlyFolders: {
			if([iconView.icon isFolderIcon]) {
				self.hidden = NO;
			}else {
				self.hidden = YES;
			}
			break;
		}
		case kListApps: {
			if([badgeWhitelist containsObject:[iconView.icon displayName]]) {
				self.hidden = NO;
			}else {
				self.hidden = YES;
			}
			break;
		}
		case kShowBadges:
			self.hidden = NO;
			break;
		default:
			self.hidden = NO;
			break;
	}
}

%end

%hook SBIconView

- (void)layoutSubviews {
	%orig;
	if(isEnabled && [self hasBadge]) {
		if(!daColor && !sameAsApp) {
			reloadPrefs();
		}

		CGFloat daFloat;
		if(customStrengthEnabled)
			daFloat = customStrength;
		else
			daFloat = [self calculateRadius];

		if(daFloat <= 4.0f) {
			return;
		}
		if(daFloat > 17.5f) {
			daFloat = 17.5f;
		}

		if(!sameAsApp) {
			checkColor();
		}else {
			daColor = [(UIImage *)[self.icon getIconImage:2] dominantColor];
		}

		self.layer.shadowColor = [daColor CGColor];
		self.layer.shadowRadius = daFloat;
		self.layer.shadowOpacity = 1;
		self.layer.shadowOffset = CGSizeZero;
		self.layer.masksToBounds = NO;
	}else {
		self.layer.shadowColor = [[UIColor clearColor] CGColor];
		self.layer.shadowRadius = 0;
		self.layer.shadowOpacity = 0;
	}
}

%new
- (BOOL)hasBadge {
	if(![self isKindOfClass:[%c(SBIconView) class]])
		return NO;

	id badge = [self.icon badgeNumberOrString];

	NSCharacterSet* notNumbers = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];

	if([badge isKindOfClass:[NSString class]]) {
		if(!XIS_EMPTY(badge) && [badge rangeOfCharacterFromSet:notNumbers].location == NSNotFound) {
			return YES;
		}
	}
	if([badge isKindOfClass:[NSNumber class]])
		return YES;
	else
		return NO;
}

%new
- (CGFloat)calculateRadius {

	id badge = [self.icon badgeNumberOrString];

	//Double check
	if([badge isKindOfClass:[NSNumber class]] || [badge isKindOfClass:[NSString class]]) {
		CGFloat returnFloat = (CGFloat) [badge floatValue] * 2.0f;
		returnFloat += 6.0f;

		return returnFloat;
	}

	return 0.0f;

}

%end

%hook SBFolderIconView

- (void)layoutSubviews {
	%orig;
	if(isFolderEnabled && [self folderHasBadge]) {
		if(!daColor && !sameAsApp)
			reloadPrefs();

		CGFloat daFloat = [self calculateFolderRadius];
		if(daFloat <= 4.0f)
			return;
		if(daFloat > 17.5f)
			daFloat = 17.5f;

		if(!sameAsApp)
			checkColor();
		else
			daColor = [(UIImage *)[self.icon getIconImage:2] dominantColor];

		self.layer.shadowColor = [daColor CGColor];
		self.layer.shadowRadius = daFloat;
		self.layer.shadowOpacity = 1.0;
		self.layer.shadowOffset = CGSizeZero;
		self.layer.masksToBounds = NO;
	}else {
		self.layer.shadowColor = [[UIColor clearColor] CGColor];
		self.layer.shadowRadius = 0.0f;
		self.layer.shadowOpacity = 0.0;
	}
}

%new
- (BOOL)folderHasBadge {
	id badge = [self.icon badgeNumberOrString];

	if(badge)
		return YES;
	else
		return NO;
}

%new
- (CGFloat)calculateFolderRadius {

	id badge = [self.icon badgeNumberOrString];

	if(badge) {
		CGFloat returnFloat = (CGFloat) [badge floatValue] * 2.0f;
		returnFloat += 6.0f;

		return returnFloat;
	}

	return 0.0f;

}

%end

%ctor {
	reloadPrefs();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
        NULL,
        (CFNotificationCallback)reloadPrefs,
        CFSTR("com.sassoty.glowbadge/preferencechanged"),
        NULL,
        CFNotificationSuspensionBehaviorDeliverImmediately);
}
