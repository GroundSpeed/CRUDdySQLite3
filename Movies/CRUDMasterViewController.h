//
//  CRUDMasterViewController.h
//  Movies
//
//  Created by Don Miller on 4/2/13.
//  Copyright (c) 2013 GroundSpeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CRUDDetailViewController;

@interface CRUDMasterViewController : UITableViewController

@property (strong, nonatomic) CRUDDetailViewController *detailViewController;

@end
