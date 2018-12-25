#import <UIKit/UIKit.h>
#import <Preferences/PSListController.h>
#import <MessageUI/MFMailComposeViewController.h>
#include <sys/sysctl.h>
#include <sys/utsname.h>

@interface NBRootListController : PSListController <MFMailComposeViewControllerDelegate> {
	UIWindow *settingsView;
}
@end