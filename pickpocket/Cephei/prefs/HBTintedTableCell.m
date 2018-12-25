#import "HBTintedTableCell.h"

@implementation HBTintedTableCell

- (void)tintColorDidChange {
	[super tintColorDidChange];
	self.textLabel.textColor = self.tintColor;
}

- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {
	[super refreshCellContentsWithSpecifier:specifier];

	if ([self respondsToSelector:@selector(tintColor)]) {
		self.textLabel.textColor = self.tintColor;
	}
}

@end
