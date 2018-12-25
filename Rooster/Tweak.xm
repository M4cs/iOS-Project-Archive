@interface SBSApplicationShortcutIcon : NSObject
@end

@interface SBSApplicationShortcutSystemIcon : SBSApplicationShortcutIcon
- (id)initWithType:(NSInteger)type;
@end

@interface SBSApplicationShortcutItem : NSObject                  
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *localizedTitle;
@property (nonatomic,copy) SBSApplicationShortcutIcon *icon;
@property (assign,nonatomic) NSUInteger activationMode;
@end

@interface SBIcon : NSObject
- (BOOL)isApplicationIcon;
- (NSString *)applicationBundleID;
- (NSString *)leafIdentifier;
@end

@interface SBIconView : UIView
@property (nonatomic,retain) SBIcon *icon;
@end

@interface BBSectionInfoSettings : NSObject
@property (assign,nonatomic) BOOL allowsNotifications;
@end

@interface BBSectionInfo : NSObject
@property (assign,nonatomic) BOOL allowsNotifications;
@property (nonatomic,readonly) BBSectionInfoSettings *writableSettings;
@property (nonatomic,copy) BBSectionInfoSettings *managedSectionInfoSettings;
@property (nonatomic,readonly) BBSectionInfoSettings *readableSettings;
@end

@interface BBServer : NSObject
+ (NSDictionary *)savedSectionInfo;
+ (void)writeSectionInfo:(NSDictionary *)sectionInfo;
@end


%hook SBIconController
- (BOOL)appIconForceTouchController:(id)arg1 shouldActivateApplicationShortcutItem:(SBSApplicationShortcutItem *)item atIndex:(NSUInteger)index forGestureRecognizer:(UIGestureRecognizer *)gesture {
	if (item && ([item.type isEqualToString:@"com.apple.springboard.application-shortcut-item.notifications.disable"] || [item.type isEqualToString:@"com.apple.springboard.application-shortcut-item.notifications.enable"])) {
		if ([[gesture view] isKindOfClass:NSClassFromString(@"SBIconView")]) {
			SBIconView *iconView = (SBIconView *)gesture.view;
			if (iconView.icon && [iconView.icon isApplicationIcon]) {
				NSString *applicationID = [iconView.icon applicationBundleID];
				if (applicationID) {
					NSDictionary *sectionsData = [NSClassFromString(@"BBServer") savedSectionInfo];
					if (sectionsData && [sectionsData objectForKey:applicationID]) {
						BBSectionInfo *sectionInfo = (BBSectionInfo *)[sectionsData objectForKey:applicationID];
						BOOL allowNotifs = [item.type isEqualToString:@"com.apple.springboard.application-shortcut-item.notifications.enable"];
						if (sectionInfo.readableSettings) sectionInfo.readableSettings.allowsNotifications = allowNotifs;
						if (sectionInfo.writableSettings) sectionInfo.writableSettings.allowsNotifications = allowNotifs;
						if (sectionInfo.managedSectionInfoSettings) sectionInfo.managedSectionInfoSettings.allowsNotifications = allowNotifs;
						sectionInfo.allowsNotifications = allowNotifs;

						sectionInfo.allowsNotifications = [item.type isEqualToString:@"com.apple.springboard.application-shortcut-item.notifications.enable"];
						[NSClassFromString(@"BBServer") writeSectionInfo:sectionsData];
						return FALSE;
					}
				}
			}
		}
	}

	return %orig;
}


- (NSArray<SBSApplicationShortcutItem *> *)appIconForceTouchController:(id)arg1 applicationShortcutItemsForGestureRecognizer:(UIGestureRecognizer *)gesture {
	NSArray<SBSApplicationShortcutItem *> *items = %orig;

	if ([[gesture view] isKindOfClass:NSClassFromString(@"SBIconView")]) {
		SBIconView *iconView = (SBIconView *)gesture.view;
		if (iconView.icon && [iconView.icon isApplicationIcon]) {
			NSString *applicationID = [iconView.icon applicationBundleID];
			if (applicationID) {
				NSDictionary *sectionsData = [NSClassFromString(@"BBServer") savedSectionInfo];
				if (sectionsData && [sectionsData objectForKey:applicationID]) {
					BOOL currentlyAllowsNotifs = ((BBSectionInfo *)[sectionsData objectForKey:applicationID]).allowsNotifications;

					SBSApplicationShortcutItem *item = [NSClassFromString(@"SBSApplicationShortcutItem") new];
					item.localizedTitle = currentlyAllowsNotifs ? @"Disable Notifications" : @"Enable Notifications";
					item.type = currentlyAllowsNotifs ? @"com.apple.springboard.application-shortcut-item.notifications.disable" : @"com.apple.springboard.application-shortcut-item.notifications.enable";
					item.activationMode = 0;
					item.icon = [[NSClassFromString(@"SBSApplicationShortcutSystemIcon") alloc] initWithType:UIApplicationShortcutIconTypeAlarm];
					NSMutableArray *newItems = [NSMutableArray new];
					[newItems addObject:item];

					for (SBSApplicationShortcutItem *itm in items) {
						[newItems addObject:itm];
					}

					items = [newItems copy];
				}
			}
		}
	}
	return items;

}
%end