[![Build Status](https://travis-ci.org/ioscreatix/SiloToggleModule.svg?branch=master)](https://travis-ci.org/ioscreatix/SiloToggleModule)
## Silo Toggle Module Example

This theos project is an example of a simple silo toggle module, here are a few things you need to know:

1. In the Info.plist under 'Resources' you need to replace the proper values for certain keys with the ones that match your module, currently the 'ModuleSize' is not supported but will be in the future.
2. If you plan on distrubting a module to Electra Beta Users (not RC) in the Makefile you need to append '/bootstrap/' to front of the 'INSTALL_PATH' variable so it is '/bootstrap/Library/ControlCenter/Bundles/'.
3. Don't forget to replace the stub icons provided as well.
4. You can find alot of useful info in the 'Headers' folder about what different method overrides are for.
