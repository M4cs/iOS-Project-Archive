@interface NCNotificationShortLookView : NCNotificationStaticContentAccepting
@end

@interface MTMaterialView : NCNotificationShortLookView
@end

%hook MTMaterialView

-(void)layoutSubviews {
	self.backgroundColor = [UIColor blackColor];
}

%end