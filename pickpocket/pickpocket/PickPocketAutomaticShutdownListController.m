#include "PickPocketAutomaticShutdownListController.h"

@implementation PickPocketAutomaticShutdownListController

+ (NSString *)hb_specifierPlist {
    return @"AutomaticShutdown";
}

+ (UIColor *)hb_tintColor {
    return [UIColor colorWithRed:252.f / 255.f green:89.f / 255.f blue:121.f / 255.f alpha:1];
}

@end
