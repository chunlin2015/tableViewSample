//
//  RootTableViewController.m
//  tableView
//
//  Created by 蘇健豪1 on 2014/11/4.
//  Copyright (c) 2014年 蘇健豪. All rights reserved.
//

#import "RootTableViewController.h"

@interface RootTableViewController ()

@property (strong, nonatomic) NSArray *section1;
@property (strong, nonatomic) NSArray *section2;
@property (strong, nonatomic) NSArray *section3;
@property (strong, nonatomic) NSArray *array;

@property (assign, nonatomic) NSUInteger selected;

@end

@implementation RootTableViewController

@synthesize section1, section2, section3, array;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    section1 = @[@"多工處理手勢"];
    section2 = @[@"鎖定螢幕旋轉", @"靜音"];
    section3 = @[@"自動鎖定", @"iCYCU"];
    array = @[section1, section2, section3];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [array[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = array[indexPath.section][indexPath.row];
    cell.detailTextLabel.text = @"XDD";
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectMake(1.0, 1.0, 20.0, 30.0)];
            cell.accessoryView = switchControl;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
            switchControl.on = [userPreferences boolForKey:@"switchControl"];
            [switchControl addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == self.selected) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    return cell;
}

- (void)switchChanged:(id)sender {
    UISwitch *switchControl = sender;
    NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
    [userPreferences setBool:switchControl.on forKey:@"switchControl"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        if (indexPath.row != self.selected) {
            NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:self.selected inSection:1];
            UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
            oldCell.accessoryType = UITableViewCellAccessoryNone;
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.selected = indexPath.row;
        }
    }
    
    if (indexPath.section == 2) {
        UIViewController *page2 = [self.storyboard instantiateViewControllerWithIdentifier:@"page2"];
        page2.title = array[2][indexPath.row];
        [self.navigationController pushViewController:page2 animated:YES];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
