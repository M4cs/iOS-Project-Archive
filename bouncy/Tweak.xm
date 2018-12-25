@interface SBAnimationSettings : UIView
@end

%hook SBAnimationSettings

-(double)speed{
	return 0.01f;
}

%end