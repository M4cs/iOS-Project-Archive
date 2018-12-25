#import <Haystack/HSKContentModule-Protocol.h>
#import "HSKEzCCModuleViewController.h"

@interface HSKEzCCModule : NSObject <HSKContentModule> {
	HSKEzCCModuleViewController	*_viewController;
}
@property(readonly, nonatomic) HSKControlCenterPage *contentViewController;
@end
