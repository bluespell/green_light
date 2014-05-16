// Generated by IB v0.4.7 gem. Do not edit it manually
// Run `rake ib:open` to refresh

#import <CFNetwork/CFNetwork.h>
#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>
#import <Reveal/Reveal.h>
#import <Security/Security.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <UIKit/UIKit.h>

@interface Semaphore: NSObject
@end

@interface AppDelegate: UIResponder <UIApplicationDelegate>
-(IBAction) applicationDidEnterBackground:(id) application;
-(IBAction) projects;
-(IBAction) load_model_data;
-(IBAction) write_model_data;

@end

@interface FavoriteProjectsController: UITableViewController

@property IBOutlet UITabBarItem * favorite_projects_button;

-(IBAction) viewDidLoad;
-(IBAction) viewWillAppear:(id) animated;
-(IBAction) show_instructions;

@end

@interface ProjectDetailsController: UITableViewController
-(IBAction) viewDidLoad;
-(IBAction) back:(id) sender;

@end

@interface ProjectsController: UITableViewController

@property IBOutlet UITabBarItem * all_projects_button;

-(IBAction) viewDidLoad;

@end

@interface ProjectsTabBarController: UITabBarController
-(IBAction) viewDidLoad;
-(IBAction) back:(id) sender;
-(IBAction) view_title;
-(IBAction) set_badge_count;
-(IBAction) project_counter:(id) method;

@end

@interface TokenController: UIViewController

@property IBOutlet UITextField * token_field;

-(IBAction) viewDidLoad;
-(IBAction) textFieldDidBeginEditing:(id) textField;
-(IBAction) textFieldDidEndEditing:(id) textField;
-(IBAction) textFieldShouldReturn:(id) textField;
-(IBAction) login:(id) sender;

@end

@interface Branch: NSObject
-(IBAction) started_at;
-(IBAction) finished_at;

@end

@interface Project: NSObject
-(IBAction) master_branch;
-(IBAction) status_color;
-(IBAction) last_build;
-(IBAction) color_status;
-(IBAction) select_branch:(id) name;

@end

@interface Token: NSObject
@end

@interface ProjectCell: UITableViewCell
-(IBAction) configure:(id) project;

@end

@interface ProjectCellView: UIView
-(IBAction) configure:(id) project;
-(IBAction) detail_text;

@end

@interface ProjectsBuilder: NSObject
@end

