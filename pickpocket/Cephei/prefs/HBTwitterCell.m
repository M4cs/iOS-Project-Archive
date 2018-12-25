#import "HBTwitterCell.h"
#import "../NSString+HBAdditions.h"
#import <Preferences/PSSpecifier.h>
#import <UIKit/UIImage+Private.h>

@interface HBLinkTableCell ()

- (BOOL)shouldShowAvatar;

@end

@interface HBTwitterCell () {
	NSString *_user;
}

@end

@implementation HBTwitterCell

+ (NSString *)_urlForUsername:(NSString *)user {
#ifdef THEOS
	// not really the right thing for this, but your usernames aren't meant to have weird ass
	// characters in them anyway :p
	user = user.hb_stringByEncodingQueryPercentEscapes;

	// lol, people still copy paste this shitty code
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"aphelion://"]]) {
		return [@"aphelion://profile/" stringByAppendingString:user];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot://"]]) {
		return [@"tweetbot:///user_profile/" stringByAppendingString:user];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific://"]]) {
		return [@"twitterrific:///profile?screen_name=" stringByAppendingString:user];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings://"]]) {
		return [@"tweetings:///user?screen_name=" stringByAppendingString:user];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) {
		return [@"twitter://user?screen_name=" stringByAppendingString:user];
	} else {
		return [@"https://mobile.twitter.com/" stringByAppendingString:user];
	}
#else
	return nil;
#endif
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {
		UIImageView *imageView = (UIImageView *)self.accessoryView;
		imageView.image = [UIImage imageNamed:@"twitter" inBundle:globalBundle];
		[imageView sizeToFit];

		_user = [specifier.properties[@"user"] copy];
		NSAssert(_user, @"User name not provided");

		specifier.properties[@"url"] = [self.class _urlForUsername:_user];

		self.detailTextLabel.text = [@"@" stringByAppendingString:_user];

		[self loadAvatarIfNeeded];
	}

	return self;
}

#pragma mark - Avatar

- (BOOL)shouldShowAvatar {
	// HBLinkTableCell doesn’t want avatars by default, but we do. override its
	// check method so that if showAvatar is unset, we return YES
	return self.specifier.properties[@"showAvatar"] ? [super shouldShowAvatar] : YES;
}

- (void)loadAvatarIfNeeded {
	if (!_user) {
		return;
	}

	if (self.avatarImage) {
		return;
	}

	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		NSError *error = nil;
		NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://twitter.com/%@/profile_image?size=bigger", _user.hb_stringByEncodingQueryPercentEscapes]]] returningResponse:nil error:&error];

		if (error) {
			HBLogError(@"error loading twitter avatar: %@", error);
			return;
		}

		UIImage *image = [UIImage imageWithData:data];

		dispatch_async(dispatch_get_main_queue(), ^{
			self.avatarImage = image;
		});
	});
}

@end
