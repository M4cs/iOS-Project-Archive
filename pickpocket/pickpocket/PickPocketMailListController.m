#include "PickPocketMailListController.h"

@implementation PickPocketMailListController

+ (NSString *)hb_specifierPlist {
    return @"MailOptions";
}

+ (UIColor *)hb_tintColor {
    return [UIColor colorWithRed:252.f / 255.f green:89.f / 255.f blue:121.f / 255.f alpha:1];
}

@end
