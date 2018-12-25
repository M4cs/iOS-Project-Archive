#import "HSKEzCCModule.h"

@implementation HSKEzCCModule

- (HSKControlCenterPage *)contentViewController {
	if (!_viewController) {
		_viewController = [[HSKEzCCModuleViewController alloc] init];
		//[_viewController setModule:self];
	}
	return _viewController;
}
@end
