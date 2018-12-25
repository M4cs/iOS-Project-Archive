#import "EzRespringModule.h"
#import <spawn.h>
#import <UIKit.h>



@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@implementation EzRespringModule
- (UIImage *)iconGlyph {
	return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]]];
}

- (UIColor *)selectedColor {
	return [UIColor blueColor];
}

- (BOOL)isSelected {
	return self.EzRespring;
}

- (void)setSelected:(BOOL)selected {
	self.EzRespring = selected;
	[super refreshState];
    [self respring];
}

- (void)respring {
    if self.EzRespring = TRUE {
		UIAlertController *confirmationAlertController = [UIAlertController
									alertControllerWithTitle:@"Are You Stupid"
									message:@"Happy April Fools"
									preferredStyle:UIAlertControllerStyleAlert];



		UIAlertAction* confirmYes = [UIAlertAction
									actionWithTitle:@"Yes"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{

									}];

		UIAlertAction* confirmNo = [UIAlertAction
									actionWithTitle:@"No"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										//do nothing lmao
									}];

		[confirmationAlertController addAction:confirmNo];
		[confirmationAlertController addAction:confirmYes];

	}
}
@end
