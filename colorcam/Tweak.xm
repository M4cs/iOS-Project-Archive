#import <libcolorpicker.h>

@interface CAMBottomBar : UIView
@end

@interface CAMTopBar : UIView
@end

@interface CUShutterButton : UIView
@end

@interface CAMViewfinderViewController : UIView
@end

@interface CAMFlipButton : UIView
@end

@interface CAMModeDialItem : UIView
@end

@interface CAMFlashButton : UIView
@end

@interface CAMHDRButton : UIView
@end

@interface CAMTimerButton : UIView
@end

@interface CAMFilterButton : UIView
@end

static NSMutableDictionary *colorsettings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.macs.ColorCamPrefs.plist"];

%hook CAMBottomBar
-(void)layoutSubviews {
    %orig;
    for (UIView *subview in self.subviews) {
      if (![subview isMemberOfClass:[objc_getClass("CUShutterButton") class]] && ![subview isMemberOfClass:[objc_getClass("CAMFlipButton") class]] && ![subview isMemberOfClass:[objc_getClass("CAMModeDial") class]] && ![subview isMemberOfClass:[objc_getClass("CAMImageWell") class]]){
        //subview is the UIView
        [subview setBackgroundColor:LCPParseColorString([colorsettings objectForKey:@"barColor"], @"#ffffff")];
        break;
      }
    }
}

-(double)_opacityForBackgroundStyle:(double)arg1 {
  return 0.7;
}
%end

%hook CAMTopBar
-(void)layoutSubviews {
    %orig;

    for (UIView *subview in self.subviews) {
      if (![subview isMemberOfClass:[objc_getClass("CUShutterButton") class]] && ![subview isMemberOfClass:[objc_getClass("CAMFlipButton") class]] && ![subview isMemberOfClass:[objc_getClass("CAMModeDial") class]] && ![subview isMemberOfClass:[objc_getClass("CAMImageWell") class]]){
        //subview is the UIView
        [subview setBackgroundColor:LCPParseColorString([colorsettings objectForKey:@"barColor"], @"#ffffff")];
        break;
      }
    }
}

-(double)_opacityForBackgroundStyle:(double)arg1 {
  return 0.7;
}
%end

%hook CAMFlipButton
-(void)layoutSubviews {
  %orig;
  for(UIImageView *image in self.subviews){

    image.tintColor = LCPParseColorString([colorsettings objectForKey:@"glyphColor"], @"#000000");
  }
}
%end

%hook CUShutterButton
-(UIColor *)_contentColor {
  return LCPParseColorString([colorsettings objectForKey:@"shutterColor"], @"#000000");
}
%end

%hook CAMModeDialItem

-(CGColorRef)_textColor {
  return [LCPParseColorString([colorsettings objectForKey:@"barColor"], @"#ffffff") CGColor];
}
%end

%hook CAMFlashButton

-(void)layoutSubviews {
  %orig;
  for(UIImageView *image in self.subviews){

    image.tintColor = LCPParseColorString([colorsettings objectForKey:@"barColor"], @"#ffffff");
  }
}
%end

%hook CAMHDRButton

-(void)layoutSubviews {
  %orig;
  for(UIImageView *image in self.subviews){

    image.tintColor = LCPParseColorString([colorsettings objectForKey:@"barColor"], @"#ffffff");
  }
}
%end

%hook CAMTimerButton

-(void)layoutSubviews {
  %orig;
  for(UIImageView *image in self.subviews){

    image.tintColor = LCPParseColorString([colorsettings objectForKey:@"barColor"], @"#ffffff");
  }
}
%end

%hook CAMFilterButton

-(void)layoutSubviews {
  %orig;
  for(UIImageView *image in self.subviews){

    image.tintColor = LCPParseColorString([colorsettings objectForKey:@"barColor"], @"#ffffff");
  }
}
%end
