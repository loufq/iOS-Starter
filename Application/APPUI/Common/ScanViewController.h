//
//  igViewController.h
//  ScanBarCodes
//
//  Created by Torrey Betts on 10/10/13.
//  Copyright (c) 2013 Infragistics. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScanViewControllerDelegate <NSObject>
@optional
-(void)scanViewController:(UIViewController*)vc didScan:(NSString*)text;
-(void)scanViewControllerDidFailtrue:(UIViewController*)vc;
@end

@interface ScanViewController : UIViewController

@property(assign)id<ScanViewControllerDelegate> delegate;


@end