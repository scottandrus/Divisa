//
//  DVConnectViewController.m
//  Divisa
//
//  Created by Scott Andrus on 7/14/13.
//  Copyright (c) 2013 Tapatory, LLC. All rights reserved.
//

#import "DVConnectViewController.h"

@interface DVConnectViewController ()

@end

@implementation DVConnectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (GKPeerPickerController *)peoplePicker
{
    if (!_peoplePicker) {
        _peoplePicker = [[GKPeerPickerController alloc] init];
        _peoplePicker.delegate = self;
        _peoplePicker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    }
    
    return _peoplePicker;
}

#pragma mark - GameKit Connection

- (void)connectToPeers
{
    [self.peoplePicker show];
}

- (void)sendPersonInfo
{
    NSData *personData = [NSKeyedArchiver archivedDataWithRootObject:self.person];
    [self.session sendData:personData toPeers:self.peers withDataMode:GKSendDataReliable error:nil];
}

#pragma mark - GKPeerPickerControllerDelegate

- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type
{
    return [[GKSession alloc] initWithSessionID:@"com.tapatory.divisa.findfriends" displayName:nil sessionMode:GKSessionModePeer];
}

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session
{
    self.session = session;
    self.session.delegate = self;
    
    [picker dismiss];
}

- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context
{
    NSString *name = [data valueForKey:kNameKey];
    UIImage *photo = [data valueForKey:kPhotoKey];
    
    [self.otherPeople addObject:[[DVPerson alloc] initWithName:name andPhoto:photo]];
}

#pragma mark - GKSessionDelegate

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
    if (state == GKPeerStateConnected) {
        [self.peers addObject:peerID];
        
        NSString *str = [NSString stringWithFormat:@"Connected with %@",[session displayNameForPeer:peerID]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connected" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        // Used to acknowledge that we will be sending data
        [session setDataReceiveHandler:self withContext:nil];
    }
}

@end
