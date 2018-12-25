@interface MTMaterialView : SBDashBoardAdjunctListView
@end

%hook MTMaterialView

-(void)layoutSubviews{
	%orig;
	self.backgroundColor = [UIColor redColor];
}

%end