//
//  PlayBar.m
//  iNews
//
//  Created by Nguyen Duy Khanh on 4/12/16.
//  Copyright © 2016 Nguyen Duy Khanh. All rights reserved.
//

#import "PlayBar.h"
@import AVFoundation;

@interface PlayBar () <AVAudioPlayerDelegate>

@end

@implementation PlayBar
{
    BOOL isPaused;

}

//View's initialization
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"PlayBar" owner:self options:nil] firstObject] ;
        view.frame = self.bounds;
        [self addSubview:view];
    }
    isPaused = true;
    /* Play audio file with AVAudioPlayer */
//    [self setupAVAudioPlayerName:@"We Don't Talk Anymore" andFileExtension:@".mp3"];
//    [self PlayMusic];
    
    [self setupAVAudioPlayerWriteToDataWithURL:self.urlString];
    
    return self;
}

- (void)setupAVAudioPlayerName: (NSString*)nameSong andFileExtension: (NSString*)fileExtension {
    
    //Create a path to music file
    NSURL *audioFileURL = [[NSBundle mainBundle] URLForResource:nameSong withExtension:fileExtension];
    NSError *error;
    
    //Create audioPlayer object -> contain the path to the file
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileURL error:&error];
    self.audioPlayer.delegate = self;
    
    //Set up the time slider
    self.timeSlider.maximumValue = [self.audioPlayer duration];
    self.timeSlider.maximumTrackTintColor = [UIColor blackColor];
    self.labelTimeElapsed.text = @"0:00";
    self.labelTimeDuration.text = [NSString stringWithFormat:@"-%@", [self timeFormat:self.audioPlayer.duration]];
    
    [self.audioPlayer prepareToPlay];
}

/* Dowload Audio Stream URL, Write to File */
- (void)setupAVAudioPlayerWriteToDataWithURL: (NSString*)stringURL {
    
    NSURL *url = [NSURL URLWithString:stringURL];
    NSData *audioData = [NSData dataWithContentsOfURL:url];
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"streamAudio"];
    [audioData writeToFile:filePath atomically:YES];
    
    NSError *error;
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
    [self.audioPlayer prepareToPlay];
    self.timeSlider.maximumValue = [self.audioPlayer duration];
    self.timeSlider.maximumTrackTintColor = [UIColor blackColor];
    self.labelTimeElapsed.text = @"0:00";
    self.labelTimeDuration.text = [NSString stringWithFormat:@"-%@", [self timeFormat:self.audioPlayer.duration]];
}
    //Convert the time label to fit with re
- (NSString*)timeFormat: (float)time {
    int minutes = time/60;
    int seconds = (int)time % 60;
    return [NSString stringWithFormat:@"%@%d:%@%d", minutes/10 ? [NSString stringWithFormat:@"%d",minutes/10] : @"", minutes%10, [NSString stringWithFormat:@"%d", seconds/10], seconds%10];
}

-(void)PlayMusic
{
    [self.timer invalidate];
    if (isPaused) {
        NSLog(@"Play");
        [self.playButton setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        [self.audioPlayer play];
        isPaused = false;
    } else {
        NSLog(@"Pause");
        [self.playButton setImage:[UIImage imageNamed:@"Play"] forState:UIControlStateNormal];
        [self.audioPlayer pause]; //the pause method just pause playback, and lets you resume from where you left off later
        isPaused = true;
    }
}
- (IBAction)playButtonTapped:(id)sender {
    [self.timer invalidate];
    if (isPaused) {
        NSLog(@"Play");
        [self.playButton setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        [self.audioPlayer play];
        isPaused = false;
    } else {
        NSLog(@"Pause");
        [self.playButton setImage:[UIImage imageNamed:@"Play"] forState:UIControlStateNormal];
        [self.audioPlayer pause]; //the pause method just pause playback, and lets you resume from where you left off later
        isPaused = true;
    }
}

- (IBAction)stopButtonTapped:(id)sender {
    NSLog(@"Stop");
    [self.audioPlayer stop]; //the stop method stops playback completely, and unloads the sound from memory, but not reset currentTime
    [self.audioPlayer setCurrentTime:0];
    self.timeSlider.value = 0;
    self.labelTimeElapsed.text = @"0:00";
    self.labelTimeDuration.text = [NSString stringWithFormat:@"-%@", [self timeFormat:self.audioPlayer.duration]];
    [self.playButton setImage:[UIImage imageNamed:@"Play"] forState:UIControlStateNormal];
    isPaused = true;
    if ([_timer isValid]){
        [_timer invalidate];
        _timer = nil;
    }

}

- (void)updateTime {
    self.timeSlider.value = [self.audioPlayer currentTime];
    self.labelTimeElapsed.text = [NSString stringWithFormat:@"%@",[self timeFormat:[self.audioPlayer currentTime]]];
    self.labelTimeDuration.text = [NSString stringWithFormat:@"-%@", [self timeFormat:self.audioPlayer.duration - self.audioPlayer.currentTime]];
}

@end
