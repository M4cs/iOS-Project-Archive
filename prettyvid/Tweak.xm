@interface AVFullScreenViewController : UIViewController
@end

%hook UIView

-(void)layoutSubviews{
    %orig;
	self.alpha = 0.0f;
}

%end