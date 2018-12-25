#import <ControlCenterUIKit/CCUIToggleModule.h>
#import <objc/runtime.h>

@interface EzAutoBrightness : CCUIToggleModule
@property (nonatomic, assign, readwrite) BOOL autoBrightness;
@end

@interface PSBrightnessSettingsDetail : NSObject
+(void)setAutoBrightnessEnabled:(BOOL)arg1;
+(BOOL)autoBrightnessEnabled;
@end
