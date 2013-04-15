//
//  MusicalInstrumentListViewController.m
//  Tuner
//
//  Created by shaxquan  on 12/11/12.
//  Copyright (c) 2012 shaxquan . All rights reserved.
//

#import "MusicalInstrumentListViewController.h"
#import "DataManager.h"
#import "TuneViewController.h"

@interface MusicalInstrumentListViewController ()

@end

@implementation MusicalInstrumentListViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"List", @"List");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [listArray release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    listArray = [[NSArray alloc] initWithArray:[[DataManager sharedDataManager] loadMusicInstrumnetList]];
    
    NSLog(@"%@", NSLocalizedString(@"guitar", @""));
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 79.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listArray.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    
    NSDictionary *dict = [listArray objectAtIndex:[indexPath row]];
    cell.imageView.image = [UIImage imageNamed:[dict objectForKey:@"pic"]];
    cell.textLabel.text = NSLocalizedString([dict objectForKey:@"name"], @"");
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InstrumentName instrumentName = (InstrumentName)([indexPath row]+1);
    [DataManager sharedDataManager].currentInstrument = instrumentName;
    TuneViewController *viewController = [[TuneViewController alloc] initWithNibName:nil bundle:nil];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
