#import "Tweak.h"

%group ModernXI

%hook MTPlatterHeaderContentView

-(void)_updateStylingForTitleLabel:(id)arg1 {
    if (self.superview && self.superview.superview && [NSStringFromClass([self.superview.superview class]) isEqualToString:@"NCNotificationShortLookView"]) {
        [self.titleLabel setTextColor:[UIColor whiteColor]];
    } else {
        %orig;
    }
}

-(void)_layoutTitleLabelWithScale:(double)arg1 {
    if (self.superview && self.superview.superview && [NSStringFromClass([self.superview.superview class]) isEqualToString:@"NCNotificationShortLookView"]) {
        %orig;
        self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x + 5, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width - 5, self.titleLabel.frame.size.height);
    } else {
        %orig;
    }
}

-(void)_configureIconButton {
    %orig;

    if (self.superview && self.superview.superview && [NSStringFromClass([self.superview.superview class]) isEqualToString:@"NCNotificationShortLookView"]) {
        UIButton *iconButton = (UIButton *)[self iconButton];
        iconButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
        iconButton.contentVerticalAlignment   = UIControlContentVerticalAlignmentFill;
        iconButton.contentEdgeInsets = UIEdgeInsetsMake(5,5,5,5);

        iconButton.layer.shadowRadius = 3.0f;
        iconButton.layer.shadowColor = [UIColor blackColor].CGColor;
        iconButton.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        iconButton.layer.shadowOpacity = 0.5f;
        iconButton.layer.masksToBounds = NO;
    }
}
%end

%hook BSUIRelativeDateLabel

-(UIColor *)textColor {
  return [UIColor whiteColor];
}

%end

%hook NCNotificationShortLookView

-(void)layoutSubviews{
    %orig;

    for (UIView *subview in self.subviews) {
        if ([NSStringFromClass([subview class]) isEqualToString:@"MTMaterialView"]) {
            [self moveUpBy:-27 view:subview];
        }
    }

    MTPlatterHeaderContentView *headerContentView = [self _headerContentView];
    [self moveUpBy:5 view:headerContentView];
    if (headerContentView.bounds.origin.x - headerContentView.frame.origin.x == 0) {
        headerContentView.bounds = CGRectInset(headerContentView.bounds, -5.0f, 0);
    }

    MTMaterialView *overlayView = [self valueForKey:@"_mainOverlayView"];
    overlayView.alpha = 0;
    overlayView.hidden = YES;
}

%new
-(void)moveUpBy:(int)y view:(UIView *)view {
    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y - y, view.frame.size.width, view.frame.size.height + y);
}

%end

%end

%ctor{
    HBPreferences *file = [[HBPreferences alloc] initWithIdentifier:@"io.ominousness.modernxi"];
    bool enabled = [([file objectForKey:@"Enabled"] ?: @(YES)) boolValue];

    if (enabled) {
        %init(ModernXI);
    }
}
