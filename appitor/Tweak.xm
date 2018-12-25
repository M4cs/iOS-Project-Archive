@interface SBIconImageView : UIView
@end

%hook SBIconImageView

-(BOOL)isJittering{
	return true;
}







%end