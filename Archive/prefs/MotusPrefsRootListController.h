#import <Preferences/PSListController.h>

@interface MotusPrefsRootListController : PSListController

@end

@interface FBSystemService
    +(id)sharedInstance;
    -(void)exitAndRelaunch:(BOOL)arg1;
@end