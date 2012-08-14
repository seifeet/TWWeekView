//
//  TWViewController.m
//  TWWeekView
//
//  Created by Andrey Tabachnik on 8/13/12.
//  Copyright (c) 2012 Andrey Tabachnik. All rights reserved.
//

#import "TWViewController.h"
#import "NSDate+Helper.h"

#define NUMBER_OF_MONTHS  3
#define SECONDS_IN_WEEK   604800
#define SECONDS_IN_6_DAYS 518400

@interface TWViewController ()
{
    NSMutableArray *_monthNames;
    NSMutableArray *_weekHashes;
    NSMutableArray *_weekNames;
}
@end

@implementation TWViewController

- (id)init
{
    if (self = [super init]) {
        [self clearData];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self clearData];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_monthNames count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* weeks = [_weekNames objectAtIndex:section];
    if (weeks) {
        return [weeks count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if( cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSArray *weeks = [_weekNames objectAtIndex:indexPath.section];
    cell.textLabel.text = [weeks objectAtIndex: indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
    CGSize stringsize  = [@"8:30" sizeWithFont:[UIFont systemFontOfSize:14.0]];
    return stringsize.height * 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_monthNames objectAtIndex:section];;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray  *weekHashes = [_weekHashes objectAtIndex:indexPath.section];
    NSString *weekHash   = [weekHashes objectAtIndex: indexPath.row];
    
    NSArray  *weekNames = [_weekNames objectAtIndex:indexPath.section];
    NSString *weekName  = [weekNames objectAtIndex: indexPath.row];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: weekHash
                          message: weekName
                          delegate: nil
                          cancelButtonTitle: @"OK"
                          otherButtonTitles: nil];
    [alert show];
}

# pragma mark - helpers
- (void)clearData
{
    _monthNames = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_MONTHS];
    _weekHashes = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_MONTHS];
    _weekNames  = [[NSMutableArray alloc] initWithCapacity:(NUMBER_OF_MONTHS*5)];
    
    NSDate *beginningOfWeek = [[NSDate date] beginningOfWeek];
    for(unsigned int i=0; i<NUMBER_OF_MONTHS; ++i) {
        NSMutableArray *weekNames   = [[NSMutableArray alloc] initWithCapacity:4];
        NSMutableArray *weekHash    = [[NSMutableArray alloc] initWithCapacity:4];
        NSString *monthName         = [beginningOfWeek stringWithFormat:@"MMMM"];
        NSString *monthNameWithYear = [beginningOfWeek stringWithFormat:@"MMMM, yyyy"];
        [_monthNames addObject:monthNameWithYear];
        
        NSString *nextWeekMonthName = [beginningOfWeek stringWithFormat:@"MMMM"];
        while([monthName isEqualToString:nextWeekMonthName]) {
            NSDate *endOfWeek  = [beginningOfWeek dateByAddingTimeInterval:SECONDS_IN_6_DAYS];
            NSString *weekName = [NSString stringWithFormat:@"%@ %02d - %02d, %04d", monthName, [beginningOfWeek day], [endOfWeek day], [beginningOfWeek year]];
            
            [weekNames addObject:weekName];
            [weekHash  addObject:[beginningOfWeek stringWithFormat:@"MM_dd_yyyy"]];
            beginningOfWeek   = [beginningOfWeek dateByAddingTimeInterval:SECONDS_IN_WEEK];
            nextWeekMonthName = [beginningOfWeek stringWithFormat:@"MMMM"];
        }
        [_weekNames  addObject:weekNames];
        [_weekHashes addObject:weekHash];
    }
}


@end
