#!/usr/bin/perl

use strict;
use feature qw( say );
use Getopt::Long;
use English qw( -no_match_vars );
use IO::File;

my $TRKSEG_PATTERN = qr{</trkseg>\s*</trk>\s*<trk>\s*<trkseg>};
my $METANAME_PATTERN = qr{<metadata>\s*<name>([\w\s]+)</name>};
my $TRKNAME_PATTERN = qr{</metadata>(\s*)<trk>};

my $infile_name = $ARGV[0];

if(not defined $infile_name) {
  usage();
} else {
  my $infile = IO::File->new("< $infile_name") 
    or die("Could not open infile: $!");

  my $outfile_name = $infile_name;
  $outfile_name =~ s/\.gpx$/-out.gpx/;

  my $outfile = IO::File->new("> $outfile_name")
    or die("Could not open outfile: $!");

  {
    $/ = undef;

    my $whole_infile = <$infile>;

    $whole_infile =~ /$METANAME_PATTERN/;
    my $track_name = $1;

    if(defined $track_name) {
      say "Track will be named $track_name";
      $whole_infile =~ s%$TRKNAME_PATTERN%</metadata>$1<trk>$1\t<name>$track_name</name>%;
    } else {
      say "Could not find track name - track will show as 'Track' on device";
      say "Check GPX file manually to fix this (see metadata section etc)";
    }

    $whole_infile =~ s/$TRKSEG_PATTERN//g;
    say "Track output as $outfile_name";
    print $outfile $whole_infile;
  }

  $infile->close;
  $outfile->close;
}

sub usage {
  say "Usage: $PROGRAM_NAME <file.gpx>\n";
  say "Output file will be named <file-out.gpx>";
}


