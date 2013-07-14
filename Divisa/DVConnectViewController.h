//
//  DVConnectViewController.h
//  Divisa
//
//  Created by Scott Andrus on 7/14/13.
//  Copyright (c) 2013 Tapatory, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

#import "DVPerson.h"

@interface DVConnectViewController : UIViewController <GKSessionDelegate, GKPeerPickerControllerDelegate>

@property (nonatomic, strong) DVPerson *person;
@property (nonatomic, strong) NSMutableArray *peers;
@property (nonatomic, strong) NSMutableArray *otherPeople;
@property (nonatomic, strong) GKSession *session;
@property (nonatomic, strong) GKPeerPickerController *peoplePicker;

- (void)connectToPeers;

@end
