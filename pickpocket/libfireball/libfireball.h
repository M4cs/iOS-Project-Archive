#import <UIKit/UIKit.h>

@class PSSpecifier;

#ifdef __cplusplus
extern "C" {
#endif
    

// Call after [super viewWillAppear:animated]
void FBSetPrefsTint(UIViewController *prefs, UIColor *tintColor);

// Call after [super viewWillDisappear:animated]
void FBResetPrefsTint(UIViewController *prefs);

PSSpecifier *FBVersionCopyrightSpecifier(NSString *packageIdentifier, NSString *copyrightName, NSString *yearMade);

void FBKillProcess(NSString *signal, NSString *processName);

// Call this in -loadView to add a share button.
void FBAddTwitterShareButton(UIViewController *prefs, UIImage *twitterIcon, NSString *shareText);

// This is usually called from your tweak's first load. It shows an alert that can follow your dev twitter acct.
void FBShowTwitterFollowAlert(NSString *title, NSString *welcomeMessage, NSString *twitterUsername);

void FBShowDonateAlert(NSString *title);

// Opens a twitter username in twitter apps / safari.
void FBOpenTwitterUsername(NSString *username);

// mailto: shortcut
void FBOpenMailAddress(NSString *email);

    
#ifdef __cplusplus
}
#endif
