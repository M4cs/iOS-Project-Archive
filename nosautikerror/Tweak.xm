#include <substrate.h>

%hook Database
-(bool) popErrorWithTitle:(id)arg1 {
return TRUE;
}
%end

%hook Database
-(bool) popErrorWithTitle:(id)arg1 forReadList:(pkgSourceList*) {
arg1 = ;
return %orig;
}
%end
