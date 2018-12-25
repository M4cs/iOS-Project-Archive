#import "SliceSetting.h"

@interface SliceSetting ()
@property (readwrite) NSString *prefix;
@end

@implementation SliceSetting
- (instancetype)initWithPrefix:(NSString *)prefix
{
	self = [super init];

	self.prefix = prefix;

	return self;
}

- (NSString *)getValueInDirectory:(NSString *)directory
{
	NSString *fullSettingFileName = [self fullSettingFileNameInDirectory:directory];
	if (fullSettingFileName.length < 1)
		return NULL;

	return [fullSettingFileName substringFromIndex:self.prefix.length];
}

- (BOOL)setValueInDirectory:(NSString *)directory value:(NSString *)value
{
	NSString *newFullSettingFileName;
	
	// append value if we're given one
	if (value.length > 0)
		newFullSettingFileName = [self.prefix stringByAppendingString:value];
	else
		newFullSettingFileName = self.prefix;

	NSString *newFullSettingFilePath = [directory stringByAppendingPathComponent:newFullSettingFileName];

	// if the directory doesn't exist, create it
	NSFileManager *manager = [NSFileManager defaultManager];
	if (![manager fileExistsAtPath:directory])
		[manager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:NULL];

	NSString *fullSettingFileName = [self fullSettingFileNameInDirectory:directory];
	if (fullSettingFileName.length > 0)
	{
		NSString *fullSettingFilePath = [directory stringByAppendingPathComponent:fullSettingFileName];

		// remove the setting if we don't have a value
		if (value.length > 0)
			return [manager moveItemAtPath:fullSettingFilePath toPath:newFullSettingFilePath error:NULL];
		else
			return [manager removeItemAtPath:fullSettingFilePath error:NULL];
	}
	
	return [manager createFileAtPath:newFullSettingFilePath contents:nil attributes:nil];
}

- (NSString *)fullSettingFileNameInDirectory:(NSString *)directory
{
	NSFileManager *manager = [NSFileManager defaultManager];
	NSArray *possibleFiles = [manager contentsOfDirectoryAtPath:directory error:NULL];

	for (NSString *possibleFile in possibleFiles)
		if ([possibleFile hasPrefix:self.prefix])
			return possibleFile;

	return NULL;
}
@end