//
//  PraisedetailViewController.m
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import "PraisedetailViewController.h"
#import "FMDatabase.h"
@interface PraisedetailViewController ()

@end

@implementation PraisedetailViewController
@synthesize item=_item;
@synthesize maintable=_maintable;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //自定义leftbarbuttonitem
    UIButton *leftbutton=[[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 32)] autorelease];
    UIImage *image=[[UIImage imageNamed:@"navi_back_btn"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 15, 5, 10)];
    [leftbutton setBackgroundImage:image forState:UIControlStateNormal];
    UIImage *imageh=[[UIImage imageNamed:@"navi_back_btn_h"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 15, 5, 10)];
    [leftbutton setBackgroundImage:imageh forState:UIControlStateHighlighted];
    leftbutton.titleLabel.font=[UIFont systemFontOfSize:11];
    [leftbutton setTitle:@"  返   回" forState:UIControlStateNormal];
    [leftbutton setTitle:@"  返   回" forState:UIControlStateHighlighted];
    [leftbutton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftitem=[[[UIBarButtonItem alloc] initWithCustomView:leftbutton] autorelease];
    self.navigationItem.leftBarButtonItem=leftitem;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.maintable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.maintable setSeparatorColor:[UIColor clearColor]];
    [self.maintable setBackgroundColor:[UIColor clearColor]];
    self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-PortraitBlank"]];
    
    [self loaddata];
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loaddata{
    _item=[[NSMutableArray alloc] initWithCapacity:10];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *sqlitePath = [documentDirectory stringByAppendingPathComponent:@"DataCache.sqlite"];
    FMDatabase *db=[FMDatabase databaseWithPath:sqlitePath];
    if ([db open]) {
        FMResultSet *result=[db executeQuery:[NSString stringWithFormat:@"select * from PraiseData where ProductID='%@'",[[NSUserDefaults standardUserDefaults] objectForKey:@"passproductid"]]];
        while ([result next]) {
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            [dic setObject:[result stringForColumn:@"Date"] forKey:@"Date"];
            [dic setObject:[result stringForColumn:@"PraiseText"] forKey:@"PraiseText"];
            [dic setObject:[result stringForColumn:@"CustomerID"] forKey:@"CustomerID"];
            [self.item addObject:dic];
        }[result close];
    }[db close];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [_item count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PraisedetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell==nil){
        cell=[[[NSBundle mainBundle] loadNibNamed:@"PraisedetailCell" owner:nil options:nil] lastObject];
    }
    [(UITextView *)[cell viewWithTag:1] setText:[[_item objectAtIndex:indexPath.row] objectForKey:@"PraiseText"]];
    [(UILabel *)[cell viewWithTag:2] setText:[NSString stringWithFormat:@"日期:%@",[[_item objectAtIndex:indexPath.row] objectForKey:@"Date"]]];
    
    [(UIImageView *)[cell viewWithTag:4] setImage:[UIImage imageWithData:[self getimage:[[_item objectAtIndex:indexPath.row] objectForKey:@"CustomerID"]]]];
    UIImage *image=[UIImage imageNamed:@"VOIPReceiverVoiceNodeBkg"];
    image=[image resizableImageWithCapInsets:UIEdgeInsetsMake(42, 25, 25, 20)];
    [(UIImageView *)[cell viewWithTag:5] setImage:image];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gomall_bg_main"]];
    UIView *vie=[[[UIView alloc] initWithFrame:cell.frame] autorelease];
    UIImageView *cellselected=[[[UIImageView alloc] initWithFrame:cell.frame] autorelease];
    cellselected.image=[UIImage imageNamed:@"cellBackTouch"];
    [vie addSubview:cellselected];
    cell.selectedBackgroundView=vie;

    // Configure the cell...
    
    return cell;
}
-(NSData *)getimage:(NSString *)uuid{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",uuid]];
    NSData *data=[NSData dataWithContentsOfFile:uniquePath];
    return data;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void)dealloc {
    [_maintable release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMaintable:nil];
    [super viewDidUnload];
}
@end
