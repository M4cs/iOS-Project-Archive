#import <CepheiPrefs/HBRootListController.h>
#import <AudioToolbox/AudioServices.h>

@interface PickPocketSIMSoundListController : HBRootListController {
    NSArray *directoryContent;
    SystemSoundID selectedSound;
}

- (NSArray *)getValues:(id)target;
- (void)previewAndSet:(id)value forSpecifier:(id)specifier;
@end
