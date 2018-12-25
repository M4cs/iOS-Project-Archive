# PickPocket

PickPocket is a powerful, full featured and highly customizable Cydia tweak against thieves!

I'm open sourcing it as I'll don't have the time to update it. You can do whetever you want with the code: learn from it, update it,...

The code is ugly, I know. PickPocket was the biggest tweak I ever made and didn't thought that I would need to update it. Take it as a lesson: Don't write ugly code, it will be difficult to maintain it in the future.

## Installation

Make sure you have a working theos environment, clone this repository and just run:

`make package install`

If needed, install the dependencies you're missing.

PickPocket is compatible with iOS 9 and 10. iOS 11 is not supported yet but it will run on it (your device will crash obviously)

## Notes

Back in iOS 9, I was using InfoStats 2 (which depends on WebCycript) in order to get the device location. WebCycript wasn't updated for iOS 10 so I dropped the location feature. I believe the code is still there but is commented.

I'm using camshot to take pictures. In iOS 11, running camshot (and all command line utilities) return `Killed`. I heard that you need to add the `platform-application` entitlement to the camshot executable but I can't confirm it.

## License

MIT License

Copyright (c) 2018 Ziph0n

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

-------

Have fun!
