#include "PickPocketShutdownListController.h"

@implementation PickPocketShutdownListController

+ (NSString *)hb_specifierPlist {
    return @"ShutdownOptions";
}

+ (UIColor *)hb_tintColor {
    return [UIColor colorWithRed:252.f / 255.f green:89.f / 255.f blue:121.f / 255.f alpha:1];
}

- (void)previewAndSet:(id)value forSpecifier:(id)specifier{
    // Sample sound and set
    AudioServicesDisposeSystemSoundID(selectedSound);
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/Library/Application Support/PickPocket/Sounds/%@",value]],&selectedSound);
    AudioServicesPlaySystemSound(selectedSound);

    [super setPreferenceValue:value specifier:specifier];
}

// List our directory content
- (NSArray *)getValues:(id)target{
    directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Library/Application Support/PickPocket/Sounds/" error:NULL];
	NSMutableArray *listing = [NSMutableArray arrayWithObjects:@"None",nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension != ''"];
    for (NSURL *fileURL in [directoryContent filteredArrayUsingPredicate:predicate]) {
	[listing addObject:fileURL];
    }
    return listing;
}

@end
