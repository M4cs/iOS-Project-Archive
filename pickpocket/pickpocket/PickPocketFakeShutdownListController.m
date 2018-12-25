#include "PickPocketFakeShutdownListController.h"

@implementation PickPocketFakeShutdownListController

+ (NSString *)hb_specifierPlist {
    return @"FakeShutdownOptions";
}

+ (UIColor *)hb_tintColor {
    return [UIColor colorWithRed:252.f / 255.f green:89.f / 255.f blue:121.f / 255.f alpha:1];
}

@end
