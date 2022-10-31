//
//  HTViewController.m
//  Heinz Tool
//
//  Created by Michael Toth on 7/27/13.
//  Copyright (c) 2013 Michael Toth. All rights reserved.
//

#import "HTViewController.h"

@interface HTViewController ()

@end

@implementation HTViewController
@synthesize player = _player;
@synthesize imageView = _imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saySomething:)];
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(chooseSaying:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapRecognizer];
    [self.view addGestureRecognizer:longPressRecognizer];
    NSString *openFile = [[NSBundle mainBundle] pathForResource:@"dirksopen" ofType:@"jpg"];
    NSString *closedFile = [[NSBundle mainBundle] pathForResource:@"dirks" ofType:@"jpg"];
    open = [UIImage imageWithContentsOfFile:openFile];
    closed = [UIImage imageWithContentsOfFile:closedFile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updatePic {
    [self.player updateMeters];
    float avg = [self.player averagePowerForChannel:0];
    if (avg < -20) {
        [self.imageView setImage:closed];
    } else {
        [self.imageView setImage:open];
    }
}

- (IBAction)saySomething:(id)sender {
    NSError *error = nil;
    NSArray *soundFiles = [[NSBundle mainBundle] pathsForResourcesOfType:@"mp3" inDirectory:@"heinzsounds"];
    NSString *randomSoundFile = [soundFiles objectAtIndex:arc4random_uniform(soundFiles.count)];
    NSData *randomSoundData = [NSData dataWithContentsOfFile:randomSoundFile];
    self.player = [[AVAudioPlayer alloc] initWithData:randomSoundData error:&error];
    self.player.meteringEnabled = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(updatePic) userInfo:nil repeats:YES];
    [self.player setDelegate:self];
    [self.player prepareToPlay];
    [self.player play];
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [timer invalidate];
    [[self imageView] setImage:closed];
    timer = nil;
}

- (IBAction) chooseSaying:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Choose Saying" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Ane Twe Dree...",@"Aye Aye Sir",@"Carry on",@"Carry on guys",@"Dricoba...",@"Eh",@"Hum Hum", @"Ohio...", @"Let's See Numbers", @"Suspicion...", @"Uh-Uh", @"Uh-Um", nil];
        [as showFromRect:self.imageView.frame inView:self.imageView animated:NO];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *choice;
    switch (buttonIndex) {
        case 0:
            choice = @"anetwedree.mp3";
            break;
        case 1:
            choice = @"ayaysir.mp3";
            break;
        case 2:
            choice = @"carryon.mp3";
            break;
        case 3:
            choice = @"carryonguys.mp3";
            break;
        case 4:
            choice = @"dricoba.mp3";
            break;
        case 5:
            choice = @"eh.mp3";
            break;
        case 6:
            choice = @"humhum.mp3";
            break;
        case 7:
            choice = @"ohio.mp3";
            break;
        case 8:
            choice = @"seenumbers.mp3";
            break;
        case 9:
            choice = @"suspicion.mp3";
            break;
        case 10:
            choice = @"uh-uh.mp3";
            break;
        case 11:
            choice = @"uh-um.mp3";
            break;
        default:
            return;
            break;
    }
    NSArray *soundFiles = [[NSBundle mainBundle] pathsForResourcesOfType:@"mp3" inDirectory:@"heinzsounds"];
    NSString *soundPath = [[soundFiles objectAtIndex:0] stringByDeletingLastPathComponent];
    NSData *soundData = [[NSData alloc] initWithContentsOfFile:[soundPath stringByAppendingPathComponent:choice]];
    self.player = [[AVAudioPlayer alloc] initWithData:soundData error:nil];
    self.player.meteringEnabled = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(updatePic) userInfo:nil repeats:YES];
    [self.player setDelegate:self];
    [self.player prepareToPlay];
    [self.player play];
}

@end
