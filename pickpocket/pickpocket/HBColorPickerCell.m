#import "HBColorPickerCell.h"
#import <Preferences/PSSpecifier.h>
#import <libcolorpicker.h>
#import <Cephei/HBPreferences.h>
#include <notify.h>

@implementation HBColorPickerCell
{
    NSString *_colorString;
    UIColor *_colorPreview;
    HBPreferences *_preferences;
    UIView *_colorPreviewView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier specifier:specifier];
    _preferences = [[HBPreferences alloc] initWithIdentifier:[specifier propertyForKey:@"defaults"]];
    _colorPreviewView = [[UIView alloc] initWithFrame:CGRectMake(0,0,29,29)];
    _colorPreviewView.clipsToBounds = YES;
    _colorPreviewView.layer.cornerRadius = _colorPreviewView.frame.size.width / 2;
    _colorPreviewView.layer.borderWidth = 2;
    _colorPreviewView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.accessoryView = _colorPreviewView;
    //[self addSubview:_colorPreviewView];
    return self;
}

- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {
  [super refreshCellContentsWithSpecifier:specifier];
  if(![[self specifier] propertyForKey:@"default"])
    [_preferences registerObject:&_colorString default:@"#FFFFFF" forKey:[specifier propertyForKey:@"key"]];
  else
    [_preferences registerObject:&_colorString default:[specifier propertyForKey:@"default"] forKey:[specifier propertyForKey:@"key"]];
  if(!_colorString)
    HBLogError(@"Error getting color value from prefs, using fallback");

  _colorPreview= LCPParseColorString(_colorString, @"#FFFFFF");
  _colorPreviewView.backgroundColor = _colorPreview;
  if (_colorString) {
    self.detailTextLabel.text = _colorString;
    self.detailTextLabel.textColor = [UIColor grayColor];
  }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (!selected) {
        [super setSelected:selected animated:animated];
        return;
    }
    _preferences = [[HBPreferences alloc] initWithIdentifier:[[self specifier] propertyForKey:@"defaults"]];
    if(![[self specifier] propertyForKey:@"default"])
        [_preferences registerObject:&_colorString default:@"#FFFFFF" forKey:[[self specifier] propertyForKey:@"key"]];
    else
        [_preferences registerObject:&_colorString default:[[self specifier] propertyForKey:@"default"] forKey:[[self specifier] propertyForKey:@"key"]];
    if(!_colorString){
        HBLogError(@"Error getting color value from prefs, using fallback");
        _colorString = @"#FFFFFF";
    }

    _colorPreview = LCPParseColorString(_colorString, @"#FFFFFF");
    HBLogDebug(@"libColorPickerAlert called : %@ , %@", _colorPreview, _colorString);
    PFColorAlert *alert = [PFColorAlert colorAlertWithStartColor:_colorPreview showAlpha:YES];
    [alert displayWithCompletion: ^void (UIColor *pickedColor){
        NSString *hexString = [UIColor hexFromColor:pickedColor];
        hexString = [hexString stringByAppendingFormat:@":%g", pickedColor.alpha];
        _preferences[[[self specifier] propertyForKey:@"key"]] = hexString;
        notify_post([[[self specifier] propertyForKey:@"PostNotification"] UTF8String]);
        [self refreshCellContentsWithSpecifier:[self specifier]];
    }];
}

#pragma mark - Memory management

- (void)dealloc {
    [_preferences release];

    [super dealloc];
}

@end