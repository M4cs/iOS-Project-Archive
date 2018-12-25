@interface CCSModuleSettingsProvider : NSObject
+ (NSArray *)_defaultFixedModuleIdentifiers;
+ (NSArray *)_defaultUserEnabledModuleIdentifiers;
@end

@interface CCSModuleRepository : NSObject
- (NSArray *)loadableModuleIdentifiers;
- (void)setIgnoreWhitelist:(BOOL)ignoresWhiteList;
@end

@interface CCSModuleMetadata : NSObject
@end

// static BOOL returnRealFixed = NO;
%group Settings
%hook CCSModuleSettingsProvider
+ (NSArray *)_defaultFixedModuleIdentifiers {
	return [NSArray new];
}

- (NSArray *)orderedFixedModuleIdentifiers {
	return [NSArray new];
}

- (void)_loadSettings {
	%orig;
	[self setValue:[NSArray new] forKey:@"_orderedFixedModuleIdentifiers"];
}

- (void)_handleConfigurationFileUpdate {
	%orig;
	[self setValue:[NSArray new] forKey:@"_orderedFixedModuleIdentifiers"];
}


// + (NSArray *)_defaultUserEnabledModuleIdentifiers {
// 	NSArray *orig = %orig;
// 	returnRealFixed = TRUE;
// 	NSArray *others = [NSClassFromString(@"CCSModuleSettingsProvider") _defaultFixedModuleIdentifiers];
// 	returnRealFixed = FALSE;
// 	orig = [others arrayByAddingObjectsFromArray:orig];
// 	return orig;
// }

+ (NSDictionary *)_defaultEnabledModuleOrder {
	NSDictionary *orig = %orig;
	NSMutableDictionary *newDict = [NSMutableDictionary new];
	NSMutableArray *fixedIdentifiers = [[orig objectForKey:@"fixed"] mutableCopy];
	NSMutableArray *userIdentifiers = [[orig objectForKey:@"user-enabled"] mutableCopy];
	NSArray *newUserIdentifiers = [[fixedIdentifiers arrayByAddingObjectsFromArray:userIdentifiers] copy];
	[newDict setObject:newUserIdentifiers forKey:@"user-enabled"];
	[newDict setObject:[NSArray new] forKey:@"fixed"];
	return [newDict copy];

}
%end

%hook CCSModuleRepository
- (BOOL)ignoreWhitelist {
	return YES;
}

- (void)setIgnoreWhitelist:(BOOL)ignoresWhiteList {
	[self setValue:@YES forKey:@"_ignoreWhitelist"];
}

+ (NSArray *)_defaultModuleDirectories {
	NSArray *orig = %orig;
	if (orig) {
		NSMutableArray *newArray = [orig mutableCopy];
		NSURL *customModulesPath = [NSURL fileURLWithPath:@"/Library/ControlCenter/Bundles"
                             isDirectory:YES];
		[newArray addObject:customModulesPath];

		NSURL *customModulesPathBeta = [NSURL fileURLWithPath:@"/bootstrap/Library/ControlCenter/Bundles"
                             isDirectory:YES];
		[newArray addObject:customModulesPathBeta];
		return [newArray copy];

	}
	return orig;
}

- (void)_updateAllModuleMetadata {
	[self setIgnoreWhitelist:YES];
	%orig;
}

// - (void)_loadAllModuleMetadata {
// 	[self setIgnoreWhitelist:YES];
// 	%orig;
// }

// + (NSArray *)_defaultModuleIdentifierWhitelist {
// 	NSArray
// }
%end

%hook CCSControlCenterDefaults
- (BOOL)shouldEnablePrototypeFeatures {
	return YES;
}
%end
%end

static void initSettingsGroup() {
	%init(Settings);
}

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	if ([((__bridge NSDictionary *)userInfo)[NSLoadedClasses] containsObject:@"CCSModuleSettingsProvider"]) { // The Network Bundle is Loaded
		initSettingsGroup();
	}
}

%ctor {
	NSString *mainIdentifier = [NSBundle mainBundle].bundleIdentifier;
	if ([mainIdentifier isEqualToString:@"com.apple.Preferences"]) {
		CFNotificationCenterAddObserver(
			CFNotificationCenterGetLocalCenter(), NULL,
			notificationCallback,
			(CFStringRef)NSBundleDidLoadNotification,
			NULL, CFNotificationSuspensionBehaviorCoalesce);
	} else if ([mainIdentifier isEqualToString:@"com.apple.springboard"]) {
		initSettingsGroup();
	}
	%init;
}
