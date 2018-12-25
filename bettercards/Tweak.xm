@interface SBSwitcherSnapshotImageView : UIView
@end

%hook SBSwitcherSnapshotImageView

-(void)_updatecornerRadiuscornerRadius{
	return 360.0;
	%orig;
}


%end

