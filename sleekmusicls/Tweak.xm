@interface SBDashBoardAdjunctItemView : UIView
@end

%hook SBDashBoardAdjunctItemView

-(void)layoutSubviews {
    for (UIView *view in self.subviews) {
       if ([[[view class] description] isEqualToString:@"_UIBackdropView"]) {
            [view removeFromSuperview];
        }
    }
    %orig;
}
%end