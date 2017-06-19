//
//  DataViewController.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef DataViewController_h
#define DataViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *displayImageView;

/** The displayImageName uses key-value observing so that updating or changing the value of the displayImageName automatically triggers the registered callbacks **/

@property NSString* displayImageName;


@end

#endif /* DataViewController_h */
