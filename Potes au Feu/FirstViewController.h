//
//  FirstViewController.h
//  Potes au Feu
//
//  Created by Thomas Robin on 06/04/2016.
//  Copyright © 2016 Thomas Robin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostModel.h"
@import Mapbox;

@interface FirstViewController : UIViewController

@property (strong, nonatomic) IBOutlet MGLMapView *mapBox;
@property (strong, nonatomic) NSArray<PostModel *> *posts;


@end

