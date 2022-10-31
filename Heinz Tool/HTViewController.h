//
//  HTViewController.h
//  Heinz Tool
//
//  Created by Michael Toth on 7/27/13.
//  Copyright (c) 2013 Michael Toth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface HTViewController : UIViewController <AVAudioPlayerDelegate, UIActionSheetDelegate> {
    NSTimer *timer;
    UIImage *open,*closed;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)saySomething:(id)sender;
- (IBAction)chooseSaying:(id)sender;
@property (nonatomic, retain) AVAudioPlayer *player;

@end
