//
//  PlayBar.h
//  iNews
//
//  Created by Nguyen Duy Khanh on 4/12/16.
//  Copyright © 2016 Nguyen Duy Khanh. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVFoundation;

@interface PlayBar : UIView
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *labelTimeElapsed;

@property (weak, nonatomic) IBOutlet UILabel *labelTimeDuration;

- (IBAction)playButtonTapped:(id)sender;

- (IBAction)stopButtonTapped:(id)sender;

@property (weak,nonatomic) NSString * urlString;

- (void)setupAVAudioPlayerName: (NSString*)nameSong andFileExtension: (NSString*)fileExtension ;
- (void)setupAVAudioPlayerWriteToDataWithURL: (NSString*)stringURL;

@end
