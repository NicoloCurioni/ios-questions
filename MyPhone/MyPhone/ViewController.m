#import "ViewController.h"

static NSString* const kAppleMaps = @"https://maps.apple.com/?q=%@";
static NSString* const kGoogleMaps = @"comgooglemaps-x-callback://?q=%@&x-success=myphone://?resume=true&x-source=MyPhone";
static NSString* const kAvatar = @"https://lh6.googleusercontent.com/-6Uce9r3S9D8/AAAAAAAAAAI/AAAAAAAAC5I/ZZo0yzCajig/photo.jpg";

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setTitle:@"Google+"];
    
    _firstName.text = @"Alex";
    
    [_cityBtn setTitle:@"Bochum" forState:UIControlStateNormal];
    
    [_avatar setImageWithURL:[NSURL URLWithString:kAvatar]
 usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}

- (IBAction)avatarTapped:(id)sender {
    //NSLog(@"%s: sender=%@", __PRETTY_FUNCTION__, sender);
    [self performSegueWithIdentifier: @"pushZoom" sender: self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"pushZoom"]){
        ZoomViewController *dest = segue.destinationViewController;
        [dest setTitle:@"Alex"];
        [dest setUrl:[NSURL URLWithString:kAvatar]];
    }
}

- (IBAction)cityPressed:(id)sender
{
    NSURL* testURL = [NSURL URLWithString:@"comgooglemaps-x-callback://"];
    NSString* fmt = ([[UIApplication sharedApplication] canOpenURL:testURL] ? kGoogleMaps : kAppleMaps);
    NSString* city = [self urlencode:_cityBtn.currentTitle];
    NSString* str = [NSString stringWithFormat:fmt, city];
    NSLog(@"%s: str=%@", __PRETTY_FUNCTION__, str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (NSString*)urlencode:(NSString*)str
{
    return (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
        NULL,
        (__bridge CFStringRef) str,
        NULL,
        CFSTR(":/?@!$&'()*+,;="),
        kCFStringEncodingUTF8));
}

@end
