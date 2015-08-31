GPX for Garmin Formatter
========================

So you just got your new Garmin eTrex 10/20/30 and want to download some GPX routes
for it to follow a trail.

You visit http://hiking.waymarkedtrails.org/en/#routes and download some routes in GPX format. In excitement you transfer them to your device only to find that when viewing them from your Garmin they all show up as "Track" and there are _hundreds_ of them!

Enter this script - it will solve this by processing the GPX files to work well
with Garmin eTrex devices (maybe other Garmin models too).

So, instead of hundreds of tracks marked only as "Track" you get one track which
is named "South Downs Way" or whatever it was originally.

## USAGE

    ./format-gpx-garmix.pl <file.gpx>

Output file will be named `<file-out.gpx>`

There are some GPX routes included for you to process with the script and try out.

Once you have a collection of "out" files you can just put them all in a directory and then copy that to the `Garmin/GPX` directory of your device. When you turn on your device it will find and index the new routes.
