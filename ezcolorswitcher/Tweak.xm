@interface SBAppSwitcherScrollView : UIScrollView
@end

%hook SBAppSwitcherScrollView

-(void)layoutSubviews{
	self.backgroundColor = [UIColor redColor];
	self.alpha = 0.55;
}
%end

