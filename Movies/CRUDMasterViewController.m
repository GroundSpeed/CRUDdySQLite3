//
//  CRUDMasterViewController.m
//  Movies
//
//  Created by Don Miller on 4/2/13.
//  Copyright (c) 2013 GroundSpeed. All rights reserved.
//

#import "CRUDMasterViewController.h"

#import "CRUDDetailViewController.h"

@interface CRUDMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation CRUDMasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Movies", @"Movies");
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self loadMovieObject];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [self loadMovieObject];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayMovies.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    Movie *movies = [_arrayMovies objectAtIndex:[indexPath row]];
    cell.textLabel.text = movies.strTitle;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[CRUDDetailViewController alloc] initWithNibName:@"CRUDDetailViewController" bundle:nil];
    }

//    NSDate *object = _objects[indexPath.row];
//    self.detailViewController.detailItem = object;
//    [self.navigationController pushViewController:self.detailViewController animated:YES];
    
    Movie *theMovie = [_arrayMovies objectAtIndex:[indexPath row]];
    
    //  Set the title of the detail page
    [self.detailViewController setTitle:theMovie.strTitle];
    
    //  Push the detail controller on to the stack
    [self.navigationController pushViewController:self.detailViewController animated:YES];
    
    //  Populate the detail view by calling its setLabelsForMovie method
    [self.detailViewController setLabelsForMovie:theMovie];
    self.detailViewController=nil;
}

#pragma mark User Methods

-(void) loadMovieObject
{
    DatabaseController *dbController = [[DatabaseController alloc] init];
    
    //  Fire the dbController getAllCustomers method to fill our array
    _arrayMovies = [dbController getAllMovies];
    
    //  Release the dbAccess object to free its memory
    dbController=nil;
}

@end
