@interface UIHUDView : UIView
@end

@interface SBVolumeHUDView : UIHUDView
@end

%hook SBVolumeHUDView

-(void)layoutSubviews{
  self.frame = CGRectMake:(0, 0, [[UIScreen mainScreen] bounds].width, [[UIScreen mainScreen] bounds].height);
}

%end
