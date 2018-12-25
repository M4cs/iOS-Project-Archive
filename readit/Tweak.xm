#import <AVFoundation/AVFoundation.h>

#define kBundlePath @"/Library/Application Support/ReadItSounds.bundle"

%hook IMChatRegistry

-(void)_chat_sendReadReceiptForAllMessages:(id)arg1 {
    NSString *soundFilePath = [NSString stringWithFormat:@"%@/Library/Application Support/ReadItSounds.bundle/oofsoundeffect.mp3",[[NSBundle mainBundle] resourcePath]];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];

    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    player.numberOfLoops = 0; //so it's once

    [player play];
    %orig;
}


%end
