#ifdef DEBUG
  #define debug(fmt, ...) NSLog((@"[ConfirmLike]:: " fmt), ##__VA_ARGS__)
#else
  #define debug(s, ...)
#endif

#import "headers.h"


static BOOL isEnabled = YES;

@implementation ConfirmLikeExtra

+ (NSDate *)postDate:(IGFeedItem*)post {
	IGFeedItem *feedItem = post;
	BOOL validSelector = [feedItem respondsToSelector:@selector(takenAt)];
	if (validSelector) {
		return [feedItem takenAt].date;
  	} else if ([feedItem respondsToSelector:@selector(takenAtDate)]) {
    	// instagram 7.19
		return [feedItem takenAtDate].date;
  	} else {
  		debug("other error fail");
  		return [NSDate date];
  		// return [feedItem albumAwareTakenAtDate].date;
    }
}
@end

/* Photos like confirmation */
%hook IGFeedItemPhotoCell

-(void)feedPhotoDidDoubleTapToLike:(id)arg1
{
	IGFeedItem *post = [self post];

	BOOL oldPost = [[NSDate date] timeIntervalSinceDate:[ConfirmLikeExtra postDate:post]] > 259200.0f;
	if (!post.hasLiked && oldPost && isEnabled)
	{
		// IGPost *post = [self _post];
		UIAlertController *confirmationAlertController = [UIAlertController
									alertControllerWithTitle:@"Confirm Like"
									message:@"Are you sure you want to like this image?"
									preferredStyle:UIAlertControllerStyleAlert];



		UIAlertAction* confirmYes = [UIAlertAction
									actionWithTitle:@"Yes"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										//Go ahead and like the image
										%orig;
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

		[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:confirmationAlertController animated:YES completion:NULL];

	}
	else %orig;
}
%end
	
/* Video like confirmation */
%hook IGFeedItemVideoCell

- (void)didDoubleTapFeedItemVideoView:(id)arg1
{
	IGFeedItem *post = [self post];
	BOOL oldPost = [[NSDate date] timeIntervalSinceDate:[ConfirmLikeExtra postDate:post]] > 86400.0f;
	if (!post.hasLiked && oldPost && isEnabled)
	{
		UIAlertController *confirmationAlertController = [UIAlertController
									alertControllerWithTitle:@"Confirm Like"
									message:@"Are you sure you want to like this video?"
									preferredStyle:UIAlertControllerStyleAlert];



		UIAlertAction* confirmYes = [UIAlertAction
									actionWithTitle:@"Yes"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										//Go ahead and like the image
										%orig;
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

		[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:confirmationAlertController animated:YES completion:NULL];

	}
	else %orig;
}
%end
	
/* Comment like confirmation */
%hook IGCommentGroupContentWithLikeView

-(void)likeButtonTapped:(id)arg1
{
	UIAlertController *confirmationAlertController = [UIAlertController
									alertControllerWithTitle:@"Confirm Like"
									message:@"Are you sure you want to like this comment?"
									preferredStyle:UIAlertControllerStyleAlert];



		UIAlertAction* confirmYes = [UIAlertAction
									actionWithTitle:@"Yes"
									style:UIAlertActionStyleDefault
									handler:^(UIAlertAction * action)
									{
										//Go ahead and like the image
										%orig;
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

	[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:confirmationAlertController animated:YES completion:NULL];

}

%end


/* TODO

√ - no alert if already liked  //still shows alert for comments :p
- add prefs to ask for how old post have to be to like it
√ - only add alert if post older than 3 days old

*/
