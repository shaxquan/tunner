//
//  TuneViewController.m
//  Tuner
//
//  Created by shaxquan  on 12/11/12.
//  Copyright (c) 2012 shaxquan . All rights reserved.
//

#import "TuneViewController.h"
#import "CMOpenALSoundManager.h"
#import "DataManager.h"

#define kName @"name"
#define kFile @"file"
#define kButtonBaseTag 100
#define TuningStep 10

@interface TuneViewController ()
@property (nonatomic, retain) CMOpenALSoundManager *soundMgr;
@end

@implementation TuneViewController
@synthesize soundMgr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initComponets];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [instrumentDict release];
}

- (void)initComponets
{
    [self loadData];
        
    switch ([DataManager sharedDataManager].currentInstrument) {
        case kGuitar:
            currentMode = kStandard;
            [self initGuitarPlayButton];
            break;
        case kViolin:
            currentMode = kAcro;
            [self initViolinPlayButton];
            break;
        default:
            break;
    }
    [self addChangeTuningButton];
}

- (void)loadData
{
    instrumentDict= [[NSDictionary dictionaryWithDictionary:[[DataManager sharedDataManager] loadGuitarTune]] retain];
    tuneNumbers = [[[instrumentDict objectForKey:[[instrumentDict allKeys] objectAtIndex:0]] allKeys] count];
}

- (void)addChangeTuningButton
{
    UIButton *changeTuningButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [changeTuningButton setTitle:@"Change Tuning" forState:UIControlStateNormal];
    changeTuningButton.frame = CGRectMake(200, 30, 120, 20);
    [changeTuningButton addTarget:self action:@selector(changeTuning) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeTuningButton];
}

- (void)changeTuning
{
    switch ([DataManager sharedDataManager].currentInstrument) {
        case kGuitar:
            [self changeGuitarTuning];
            break;
        case kViolin:
            [self changeViolinTuning];
            break;
        default:
            break;
    }
}

- (void)changeGuitarTuning
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Choose A Tuning" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"1/2 Step Down", @"Drop D", @"Standard", nil];
    [alert show];
    alert.tag = kGuitar;
    [alert release];
}

- (void)changeViolinTuning
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Choose A Tuning" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Acro", @"Pizz", nil];
    [alert show];
    alert.tag = kViolin;
    [alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == kGuitar) {
        switch (buttonIndex) {
            case 1:
                currentMode = k12stepdown;
                break;
            case 2:
                currentMode = kDropD;
                break;
            case 3:
                currentMode = kStandard;
                break;
            default:
                break;
        }
    }
    else if (alertView.tag == kViolin) {
        switch (buttonIndex) {
            case 1:
                currentMode = kAcro;
                break;
            case 2:
                currentMode = kPizz;
                break;
            default:
                break;
        }
        if ([soundMgr isPlayingSoundWithID:previousSoundID]) {
            [soundMgr stopSoundWithID:previousSoundID];
        }
    }

    [self refreshSoundNames];
    [self refreshPlayButtons];
}

- (void)refreshPlayButtons
{
    switch ([DataManager sharedDataManager].currentInstrument) {
        case kGuitar:
            [self refreshGuitarPlayButton];
            break;
        case kViolin:
            //do nothing
            break;
        default:
            break;
    }
}

- (void)initGuitarPlayButton
{
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guitar_background.png"]];
    [self.view addSubview:background];
    
    for (int i=0; i<tuneNumbers; i++) {
        UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //    playButton.titleLabel.text = [NSString stringWithFormat:@"Play"];
//        [playButton setTitle:@"Play" forState: UIControlStateNormal];
        playButton.frame = CGRectMake(30 + i*46, 380, 40, 20);
        [playButton addTarget:self action:@selector(playSound:) forControlEvents:UIControlEventTouchUpInside];
        playButton.tag = kButtonBaseTag + i;
        [self.view addSubview:playButton];
    }
    [self refreshGuitarPlayButton];
}

- (void)refreshGuitarPlayButton
{
    NSDictionary *dict = nil;
    switch (currentMode) {
        case k12stepdown:
            dict = [instrumentDict objectForKey:@"1_2stepdown"];
            break;
        case kDropD:
            dict = [instrumentDict objectForKey:@"dropd"];
            break;
        case kStandard:
            dict = [instrumentDict objectForKey:@"standard"];
            break;
        default:
            break;
    }
    
    for (int i=0; i<tuneNumbers; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:(kButtonBaseTag+i)];
        [button setTitle:[[dict objectForKey:[[DataManager sharedDataManager].tuneOrder objectAtIndex:i]] objectForKey:kName] forState:UIControlStateNormal];
    }
}

- (void)initViolinPlayButton
{
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"violin_background.png"]];
    [self.view addSubview:background];
    
    UIButton *buttonA = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonA setTitle:@"A" forState: UIControlStateNormal];
    buttonA.frame = CGRectMake(166, 180, 30, 30);
    [buttonA addTarget:self action:@selector(playSound:) forControlEvents:UIControlEventTouchUpInside];
    buttonA.tag = 0+kButtonBaseTag;
    [self.view addSubview:buttonA];
    
    UIButton *buttonD = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonD setTitle:@"D" forState:UIControlStateNormal];
    buttonD.frame = CGRectMake(100, 100, 30, 30);
    [buttonD addTarget:self action:@selector(playSound:) forControlEvents:UIControlEventTouchUpInside];
    buttonD.tag = 1+kButtonBaseTag;
    [self.view addSubview:buttonD];
    
    UIButton *buttonE = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonE setTitle:@"E" forState:UIControlStateNormal];
    buttonE.frame = CGRectMake(160, 90, 30, 30);
    [buttonE addTarget:self action:@selector(playSound:) forControlEvents:UIControlEventTouchUpInside];
    buttonE.tag = 2+kButtonBaseTag;
    [self.view addSubview:buttonE];
    
    UIButton *buttonG = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonG setTitle:@"G" forState:UIControlStateNormal];
    buttonG.frame = CGRectMake(130, 240, 30, 30);
    [buttonG addTarget:self action:@selector(playSound:) forControlEvents:UIControlEventTouchUpInside];
    buttonG.tag = 3+kButtonBaseTag;
    [self.view addSubview:buttonG];
}

- (void)refreshSoundNames
{
    switch ([DataManager sharedDataManager].currentInstrument) {
        case kGuitar:
            [self refreshGuitarSoundNames];
            break;
        case kViolin:
            [self refreshVolinSoundNames];
            break;
        default:
            break;
    }
}

- (void)refreshGuitarSoundNames
{
    switch (currentMode) {
        case k12stepdown:
            soundMgr.soundFileNames = [NSArray arrayWithObjects:@"guitar_EbHigh.mp3", @"guitar_Bb.mp3", @"guitar_Gb.mp3", @"guitar_Db.mp3", @"guitar_Ab.mp3", @"guitar_Eblow.mp3", nil];
            break;
        case kDropD:
            soundMgr.soundFileNames = [NSArray arrayWithObjects:@"guitar_EHigh.mp3", @"guitar_B.mp3", @"guitar_G.mp3", @"guitar_D.mp3", @"guitar_A.mp3", @"guitar_DropD.mp3", nil];
            break;
        case kStandard:
            soundMgr.soundFileNames = [NSArray arrayWithObjects:@"guitar_EHigh.mp3", @"guitar_B.mp3", @"guitar_G.mp3", @"guitar_D.mp3", @"guitar_A.mp3", @"guitar_Elow.mp3", nil];
            break;
        default:
            break;
    }
}

- (void)refreshVolinSoundNames
{
    switch (currentMode) {
        case kAcro:
            soundMgr.soundFileNames = [NSArray arrayWithObjects:@"violin_a.wav", @"violin_d.wav", @"violin_e.wav", @"violin_g.wav", nil];
            break;
        case kPizz:
            soundMgr.soundFileNames = [NSArray arrayWithObjects:@"violin_a_pluck.wav", @"violin_d_pluck.wav", @"violin_e_pluck.wav", @"violin_g_pluck.wav", nil];
            break;
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.soundMgr = [[[CMOpenALSoundManager alloc] init] autorelease];
    [self refreshSoundNames];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([soundMgr isPlayingSoundWithID:previousSoundID]) {
        [soundMgr stopSoundWithID:previousSoundID];
    }
}

- (void)playSound:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if ([soundMgr isPlayingSoundWithID:previousSoundID]) {
        [soundMgr stopSoundWithID:previousSoundID];
    }
    [soundMgr playSoundWithID:(button.tag-kButtonBaseTag)];
    previousSoundID = button.tag - kButtonBaseTag;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
