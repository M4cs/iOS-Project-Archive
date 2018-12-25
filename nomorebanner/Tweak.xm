@interface SKUIBannerView : UIView
@end 

%hook SKUIBannerView

-(void)layoutSubviews {
	self.backgroundColor = [UIColor clearColor];
}

%end
