#import <Preferences/PSTableCell.h>

/// The `HBTintedTableCell` class in `CepheiPrefs` ensures that a tint set with HBAppearanceSettings
/// will also be applied to the title label of a of a cell intended to be used as a button.
///
/// ### Example Usage
/// ```xml
/// <dict>
/// 	<key>cell</key>
/// 	<string>PSButtonCell</string>
/// 	<key>cellClass</key>
/// 	<string>HBTintedTableCell</string>
/// 	<key>label</key>
/// 	<string>Do Something</string>
/// </dict>
/// ```

@interface HBTintedTableCell : PSTableCell

@end
