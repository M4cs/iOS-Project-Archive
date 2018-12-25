#import <Preferences/Preferences.h>
#import <objc/runtime.h>

@interface NBCustomizeListController : PSListController
{
	UIWindow *settingsView;
	NSString* _appName;
	NSString* _identifier;
	UITableView* _tableView;
}
-(id)initWithAppName:(NSString*)appName identifier:(NSString*)identifier;
@end