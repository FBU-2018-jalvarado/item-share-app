//
//  QRViewController.h
//  item-share-app
//
//  Created by Nicolas Machado on 8/3/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PickUpPopUpController.h"

@interface QRViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate, pickUpPopUpDelegate>

@property (strong, nonatomic) IBOutlet UIView *viewforCamera;
- (IBAction)startButtonClicked:(UIButton *)sender;
-(BOOL)startReading;
-(void)stopReading;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) IBOutlet UITextView *textView;
-(void)loadBeepSound;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end
