#include "CCNMRootListController.h"

@implementation CCNMRootListController

- (void)showHelpAlert:(PSSpecifier *)specifier {
    // Usually 2g/3g GSM are enough. Enable their CDMA counterparts only if your carrier is Sprint or Verizon or if you don't get any signal when forcing 2G/3G
    NSString* explanation = @"You can enable every network you want to switch between in the control center.\n"
        "\n"
        "About the different variations\n (GSM/CDMA/NR...):\n"
        "It all depends on your country/carrier. \n"
        "For 2G/3G usually you should be using GSM, but some carriers (Sprint, Verizon) are using CDMA.\n"
        "For 5G, I unfortunately couldn't do extensive testing, so it's up to you to try out which works. Personally I'm using the 5G NR Non StandAlone.\n"
        "\n"
        "Of course, you can use any number of module you want. Eg only LTE (which will switch between LTE & auto), or LTE+5G NSA (my personal setup), or any other combination you want.";

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"What do I need to enable?" message:explanation preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    }];
    
    [alertController addAction:dismissAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = applyButton;
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

- (id)readPreferenceValue:(PSSpecifier*)specifier {
	NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:path];
	return (settings[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:path];
	[settings setObject:value forKey:specifier.properties[@"key"]];
	[settings writeToFile:path atomically:YES];
	CFStringRef notificationName = (__bridge CFStringRef)specifier.properties[@"PostNotification"];
	if (notificationName) {
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), notificationName, NULL, NULL, YES);
	}
}

-(void)save {
	[self.view endEditing:YES];
}
@end

@implementation CCNMTelegramCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier specifier:specifier];

    if(self) {
        _bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/NetworkManagerPrefs.bundle"];
        [_bundle load];

        // Labels
        self.textLabel.text = @"Telegram";
        self.detailTextLabel.text = @"@Nixuge";
        self.detailTextLabel.textColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.0];

        // Right image
        UIImage *telegramLogo = [UIImage imageNamed:@"telegram" inBundle:_bundle compatibleWithTraitCollection:nil];
        self.accessoryView = [[UIImageView alloc] initWithImage:telegramLogo];

        [specifier setTarget:self];
        [specifier setButtonAction:@selector(openTelegram)];
    }

    return self;
}

-(void)openTelegram {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tg:"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tg://resolve?domain=Nixuge"] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://t.me/Nixuge"] options:@{} completionHandler:nil];
    }
}
@end

@implementation CCNMDiscordCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier specifier:specifier];

    if(self) {
        _bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/NetworkManagerPrefs.bundle"];
        [_bundle load];

        // Labels
        self.textLabel.text = @"Discord";
        self.detailTextLabel.text = @"@Nixuge";
        self.detailTextLabel.textColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.0];

        // Right image
        UIImage *discordLogo = [UIImage imageNamed:@"discord" inBundle:_bundle compatibleWithTraitCollection:nil];
        self.accessoryView = [[UIImageView alloc] initWithImage:discordLogo];

        [specifier setTarget:self];
        [specifier setButtonAction:@selector(openDiscord)];
    }

    return self;
}

-(void)openDiscord {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"discord:"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"discord://discord.com/users/784062518901473351"] options:@{} completionHandler:nil];
    }
    // not opening in the browser as discord browser on mobile is horrendous
}
@end

@implementation CCNMTwitterCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier specifier:specifier];

    if(self) {
        _bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/NetworkManagerPrefs.bundle"];
        [_bundle load];

        // Labels
        self.textLabel.text = @"Twitter";
        self.detailTextLabel.text = @"@JeanFilsYTB";
        self.detailTextLabel.textColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.0];

        // Right image
        UIImage *twitterLogo = [UIImage imageNamed:@"twitter" inBundle:_bundle compatibleWithTraitCollection:nil];
        self.accessoryView = [[UIImageView alloc] initWithImage:twitterLogo];

        [specifier setTarget:self];
        [specifier setButtonAction:@selector(openTwitter)];
    }

    return self;
}

-(void)openTwitter {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=JeanFilsYTB"] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.twitter.com/JeanFilsYTB"] options:@{} completionHandler:nil];
    }
}

@end

@implementation CCNMRedditCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier specifier:specifier];

    if(self) {
        _bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/NetworkManagerPrefs.bundle"];
        [_bundle load];

        // Labels
        self.textLabel.text = @"Reddit";
        self.detailTextLabel.text = @"/u/Nixugay";
        self.detailTextLabel.textColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.0];

        // Right image
        UIImage *redditLogo = [UIImage imageNamed:@"reddit" inBundle:_bundle compatibleWithTraitCollection:nil];
        self.accessoryView = [[UIImageView alloc] initWithImage:redditLogo];

        [specifier setTarget:self];
        [specifier setButtonAction:@selector(openReddit)];
    }

    return self;
}

-(void)openReddit {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"reddit:"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"reddit:///u/Nixugay"] options:@{} completionHandler:nil];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"apollo:"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"apollo://www.reddit.com/u/Nixugay"] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.reddit.com/u/Nixugay"] options:@{} completionHandler:nil];
    }
}
@end

@implementation NetworkManagerLogo

- (id)initWithSpecifier:(PSSpecifier *)specifier
{
	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Banner" specifier:specifier];
	if (self) {
		// CGFloat width = 320;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
		CGFloat height = 70;

		CGRect backgroundFrame = CGRectMake(-50, -35, width, height);
		background = [[UILabel alloc] initWithFrame:backgroundFrame];
		[background layoutIfNeeded];
		background.backgroundColor = [UIColor colorWithRed:0.11 green:0.11 blue:0.12 alpha:0.0];
		background.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

		CGRect tweakNameFrame = CGRectMake(-50, -40, width, height);
		tweakName = [[UILabel alloc] initWithFrame:tweakNameFrame];
		[tweakName layoutIfNeeded];
		tweakName.numberOfLines = 1;
		tweakName.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        [tweakName setFont:[UIFont systemFontOfSize:30]];
		tweakName.textColor = [UIColor colorWithRed:1.00 green:0.58 blue:0.00 alpha:1.0];
		tweakName.text = @"NetworkManagerReborn";
		tweakName.textAlignment = NSTextAlignmentCenter;

		CGRect versionFrame = CGRectMake(-50, -5, width, height);
		version = [[UILabel alloc] initWithFrame:versionFrame];
		version.numberOfLines = 1;
		version.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        [version setFont:[UIFont systemFontOfSize:15]];
		version.textColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.84 alpha:1.0];
		version.text = @"Version 1.3";
		version.backgroundColor = [UIColor clearColor];
		version.textAlignment = NSTextAlignmentCenter;

		[self addSubview:background];
		[self addSubview:tweakName];
		[self addSubview:version];
	}
    return self;
}

- (CGFloat)preferredHeightForWidth:(CGFloat)width {
	return 100.0f;
}
@end
