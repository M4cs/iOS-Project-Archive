@interface SBFolderSettings
@end

@interface SBIconController
@end

%hook SBIconController
-(BOOL)allowsNestedFolders {
  return YES;
}
%end

%hook SBFolderSettings
-(BOOL)allowNestedFolders {
  return YES;
}
%end
