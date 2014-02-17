# NinetyNine

NinetyNine is actually the name of the demo app I made for this API wrapper, because names are hard.

[Uptime Robot](http://uptimerobot.com/) is a pretty neat service to check on the uptime for your websites. To have some fun and learn a little, I figured I'd write a little Objective-C wrapper around their API.

## What it can do:
* Average All-time Uptime (%) for a given monitor
* Last time the monitor reported the site was down
* How long the site was down last time 

Right now, it only supports retrieving information about one monitor (you'd supply a monitor-specific API key that UptimeRobot provides) Really soon, it'll be able to do multiple monitors in one instance. 

## Usage:

First, add MMUptimeRobot.h and .m files to your project. Information about a monitor is stored in an MMUptimeRobot object. Data is fetched in the background, so the object posts a notification whenever it's ready. When you receive this notification, you'll want to update your UI. First, subscribe to it:

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData:) name:@"UptimeMonitorDataReady" object:nil];
	
Next, we allocate and initialize an MMUptimeRobot object with the specific monitor API key:

	MMUptimeRobot *robot = [MMUptimeRobot connectionWithAPIKey:@"YOUR MONITOR-SPECIFIC API KEY HERE"];
	
After that, tell it to fetch information about the monitor in the background. It returns TRUE if it succeeds, and FALSE if there was any error (usually the network connection being down)

	BOOL success = [robot fetchInformationAboutMonitor];
	
	if(!success) {
		// Error handling here
	}  
	
That's all there is to it! The features described above are available as properties of an MMUptimeRobot once information has been fetched:

	robot.uptimeAverage; // Returns an NSString object with the uptime average, e.g 99.9
	robot.monitorName; // Returns the name of the monitor
	robot.lastDowntime // Returns the full date and time of when a downtime occurred as an NSString, e.g Jan 28, 2014 12:11:13 PM
	robot.lastDowntimeTime // Returns an NSString representing the time in minutes the downtime lasted, e.g 2 minutes
	
The demo is fully-functioning (just supply your API key) Enjoy!

## License Stuff
This is licensed under the [MIT license](http://choosealicense.com/licenses/mit/). Have fun with it!