#line 1 "Tweak.xm"
#include <substrate.h>


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class Database; 
static bool (*_logos_orig$_ungrouped$Database$popErrorWithTitle$)(_LOGOS_SELF_TYPE_NORMAL Database* _LOGOS_SELF_CONST, SEL, id); static bool _logos_method$_ungrouped$Database$popErrorWithTitle$(_LOGOS_SELF_TYPE_NORMAL Database* _LOGOS_SELF_CONST, SEL, id); static bool (*_logos_orig$_ungrouped$Database$popErrorWithTitle$forReadList$)(_LOGOS_SELF_TYPE_NORMAL Database* _LOGOS_SELF_CONST, SEL, id); static bool _logos_method$_ungrouped$Database$popErrorWithTitle$forReadList$(_LOGOS_SELF_TYPE_NORMAL Database* _LOGOS_SELF_CONST, SEL, id); 

#line 3 "Tweak.xm"

static bool _logos_method$_ungrouped$Database$popErrorWithTitle$(_LOGOS_SELF_TYPE_NORMAL Database* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
return TRUE;
}



static bool _logos_method$_ungrouped$Database$popErrorWithTitle$forReadList$(_LOGOS_SELF_TYPE_NORMAL Database* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1):(pkgSourceList*) {
arg1 = ;
return _logos_orig$_ungrouped$Database$popErrorWithTitle$forReadList$(self, _cmd, arg1);
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$Database = objc_getClass("Database"); MSHookMessageEx(_logos_class$_ungrouped$Database, @selector(popErrorWithTitle:), (IMP)&_logos_method$_ungrouped$Database$popErrorWithTitle$, (IMP*)&_logos_orig$_ungrouped$Database$popErrorWithTitle$);MSHookMessageEx(_logos_class$_ungrouped$Database, @selector(popErrorWithTitle:forReadList:), (IMP)&_logos_method$_ungrouped$Database$popErrorWithTitle$forReadList$, (IMP*)&_logos_orig$_ungrouped$Database$popErrorWithTitle$forReadList$);} }
#line 15 "Tweak.xm"
