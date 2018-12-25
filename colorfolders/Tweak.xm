@interface SBFolderView : SBFloatyDockView
@end

%hook SBFolderView

-(void)layoutSubviews{
	%orig;
	self.backgroundColor = [UIColor redColor];
}

%end