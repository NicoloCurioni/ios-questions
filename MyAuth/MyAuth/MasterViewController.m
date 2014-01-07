#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Keys.h"

@interface MasterViewController () {
    NSDictionary *_menu;
    NSArray *_keys;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _keys = @[kFB, kGG, kMR, kOK, kVK];
        
    _menu = @{
              kFB:  @{
                      kKey:      kFB,
                      kLabel:    @"Facebook",
                      kAppId:    @"432298283565593",
                      kSecret:   @"c59d4f8cc0a15a0ad4090c3405729d8e",
                      kRedirect: @"https://www.facebook.com/connect/login_success.html",
                      kAuthUrl:  @"https://graph.facebook.com/oauth/authorize?",
                      },
              kGG:  @{
                      kKey:      kGG,
                      kLabel:    @"Google+",
                      //kAppId:
                      //kSecret:
                      kRedirect: @"urn:ietf:wg:oauth:2.0:oob",
                      kAuthUrl:  @"https://accounts.google.com/o/oauth2/auth?",
                      kScope:    @"https://www.googleapis.com/auth/userinfo.profile",
                      },
              kMR:   @{
                      kKey:      kMR,
                      kLabel:    @"Mail.ru",
                      kAppId:    @"715360",
                      kSecret:   @"4260eeea98d7665edbe4baa080af894b",
                      kRedirect: @"http://connect.mail.ru/oauth/success.html",
                      kAuthUrl:  @"https://connect.mail.ru/oauth/authorize?",
                      },
              kOK:   @{
                      kKey:      kOK,
                      kLabel:    @"Odnoklassniki",
                      //kAppId:
                      //kSecret:
                      kRedirect: @"http://connect.mail.ru/oauth/success.html",
                      kAuthUrl:  @"http://www.odnoklassniki.ru/oauth/authorize?",
                      },
              kVK:   @{
                      kKey:      kVK,
                      kLabel:    @"VKontakte",
                      //kAppId:
                      //kSecret:
                      kRedirect: @"http://oauth.vk.com/blank.html",
                      kAuthUrl:  @"http://oauth.vk.com/authorize?",
                      },
            };
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _keys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSString *key = _keys[indexPath.row];
    NSString *label = _menu[key][kLabel];
    cell.textLabel.text = label;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *key = _keys[indexPath.row];
        NSDictionary *dict = _menu[key];
        [[segue destinationViewController] setDict:dict];
    }
}

@end
