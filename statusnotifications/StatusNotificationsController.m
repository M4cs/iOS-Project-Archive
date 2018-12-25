#import "StatusNotificationController.h"

@implementation StatusNotificationController
__strong static id _sharedObject;
+ (id)sharedInstance

{
	return _sharedObject;
}
-(id)init {
  self = [super init];
  _sharedObject = self;

  return self;
}
@end
