//
//  QRViewController.m
//  item-share-app
//
//  Created by Nicolas Machado on 8/3/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "QRViewController.h"
#import <CoreImage/CoreImage.h>

@interface QRViewController ()

@property BOOL isReading;


@end

@implementation QRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _captureSession = nil;
    _isReading = NO;
    _lblStatus.text = @"Your Text Will Shown Below.";
   // [self loadBeepSound];
    
    if (!_isReading)
    {
        if ([self startReading])
        {
            [_lblStatus setText:@"Scanning for QR Code..."];
        }
    }
    else
    {
        [self stopReading];
    }
    
    _isReading = !_isReading;
    
}

- (IBAction)startButtonClicked:(UIButton *)sender{
    
}

-(BOOL)startReading{
    NSError *error;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (captureDevice.position == AVCaptureDevicePositionBack) {
        NSLog(@"back camera");
        
    }else if (captureDevice.position == AVCaptureDevicePositionFront){
        NSLog(@"Front Camera");
        
        
    }else{
        NSLog(@"Unspecified");
    }
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input)
    {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewforCamera.layer.bounds];
    [_viewforCamera.layer addSublayer:_videoPreviewLayer];
    [_captureSession startRunning];
    return YES;
}

-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
    [_videoPreviewLayer removeFromSuperlayer];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            [_textView performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            if ([_textView.text containsString:@"http"]) {
                NSString* text = _textView.text;
                NSURL *url  = [[NSURL alloc] initWithString:text];
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"This code have a http link.Do you want to open it.?" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                {
                    [[UIApplication sharedApplication] openURL:url];
                }];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                {
                    _lblStatus.text = @"Your Text Will Shown Below.";
                }];
                [alert addAction:cancel];
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            else
            {
                //you can show your custom alert like - there is no HTTP link present in the QR Code. //
            }
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            // [_bbitemStart performSelectorOnMainThread:@selector(setTitle:) withObject:@"Start!" waitUntilDone:NO];
            _isReading = NO;
            
            if (_audioPlayer)
            {
                [_audioPlayer play];
            }
            
        }
    }
}
- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//add a sound if needed
/*
-(void)loadBeepSound{
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    NSError *error;
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error)
    {
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else
    {
        [_audioPlayer prepareToPlay];
    }
}
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
