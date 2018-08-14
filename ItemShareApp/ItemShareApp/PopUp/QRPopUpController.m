//
//  QRPopUpController.m
//  item-share-app
//
//  Created by Nicolas Machado on 8/3/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "QRPopUpController.h"
#import <CoreImage/CoreImage.h>
#import "ColorScheme.h"

@interface QRPopUpController ()

@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;
@property (weak, nonatomic) IBOutlet UIView *QRPopUpView;
@property (strong, nonatomic) ColorScheme *colorModel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation QRPopUpController


- (void)awakeFromNib {
        self.colorModel = [ColorScheme new];
}

- (void)viewDidLoad {
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
   
    self.backButton.layer.cornerRadius = 5;
    self.backButton.clipsToBounds = YES;
    self.QRPopUpView.backgroundColor = [UIColor whiteColor];
    self.QRPopUpView.layer.cornerRadius = 5;
    self.QRPopUpView.layer.shadowOpacity = 0.8;
    self.QRPopUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    self.QRPopUpView.layer.borderWidth = 7;
    self.QRPopUpView.layer.borderColor = self.colorModel.mainColor.CGColor;
    [super viewDidLoad];
    
    // NSString *info = @"http://codeafterhours.wordpress.com";
    NSString *info = self.item.title;
    // Generation of QR code image
    NSData *qrCodeData = [info dataUsingEncoding:NSISOLatin1StringEncoding]; // recommended encoding
    CIFilter *qrCodeFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrCodeFilter setValue:qrCodeData forKey:@"inputMessage"];
    [qrCodeFilter setValue:@"M" forKey:@"inputCorrectionLevel"]; //default of L,M,Q & H modes
    
    CIImage *qrCodeImage = qrCodeFilter.outputImage;
    
    CGRect imageSize = CGRectIntegral(qrCodeImage.extent); // generated image size
    CGSize outputSize = CGSizeMake(240.0, 240.0); // required image size
    CIImage *imageByTransform = [qrCodeImage imageByApplyingTransform:CGAffineTransformMakeScale(outputSize.width/CGRectGetWidth(imageSize), outputSize.height/CGRectGetHeight(imageSize))];
    
    UIImage *qrCodeImageByTransform = [UIImage imageWithCIImage:imageByTransform];
    self.qrImageView.image = qrCodeImageByTransform;
    
    //    // Generation of bar code image
    //    CIFilter *barCodeFilter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    //    NSData *barCodeData = [info dataUsingEncoding:NSASCIIStringEncoding]; // recommended encoding
    //    [barCodeFilter setValue:barCodeData forKey:@"inputMessage"];
    //    [barCodeFilter setValue:[NSNumber numberWithFloat:7.0] forKey:@"inputQuietSpace"]; //default whitespace on sides of barcode
    //
    //    CIImage *barCodeImage = barCodeFilter.outputImage;
    //    self.qrImageView.image = [UIImage imageWithCIImage:barCodeImage];
    
}

- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}

- (IBAction)close:(id)sender {
    NSLog(@"tapped");
    [self removeAnimate];
   //[self.popUpDelegate dismiss];
}

- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    [aView addSubview:self.view];
    if (animated) {
        [self showAnimate];
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self removeAnimate];
   // [self dismissViewControllerAnimated:YES completion:nil];
}

@end
