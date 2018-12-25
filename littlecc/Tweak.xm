@interface CCUIModularControlCenterCardView : UIView
@end

%hook CCUIModularControlCenterCardView

-(void)layoutSubviews{
	%orig;
	self.alpha = 0.0;
}

%end