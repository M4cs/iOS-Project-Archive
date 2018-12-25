@interface SBIconView : UIView
@end

%hook SBIconView

-(void)layoutSubviews {
  %orig;
  self.layer.shadowColor = [[UIColor redColor] CGColor];
  self.layer.shadowRadius = 0.2f;
  self.layer.shadowOpacity = 0.8;
}

%end
