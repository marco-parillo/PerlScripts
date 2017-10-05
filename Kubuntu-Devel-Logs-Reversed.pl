#!/usr/bin/perl

# Print daily Kubuntu-devel IRC logs, working backwards day-by-day
# Starting Date defaults to today
# Change Ending Date to set last day's log to print
# Exclude KCI notifications and Nick Changes


use strict;
use warnings;

use DateTime;              # https://www.archlinux.org/packages/community/x86_64/perl-datetime/
use LWP::Simple;           # https://www.archlinux.org/packages/extra/any/perl-lwp-protocol-https/
use Date::Simple qw(date); # https://www.archlinux.org/packages/extra/x86_64/perl-date-simple/

my $path;    # Constructed from Date String                 
my $url;     # Full URL, including the Domain, Path, and #kubuntu-devel 
my $WebPage; # Full page of IRC Logs for a date
my $line;    # Current Line of IRC Log (needed to exclude KCI and nick changes)
my $EndDate = "2017-07-06";
my $StartDate = substr (DateTime->now()->iso8601(), 0, 10);
my $d = date($StartDate);


while ($d ge $EndDate) {
  $path = $d;
  $path =~ s$-$/$g;
  $url = "https://irclogs.ubuntu.com/".$path."/%23kubuntu-devel.txt";
  $WebPage = get ($url);
  foreach $line (split /\n/ ,$WebPage) {
    print $d,$line,"\n" if not ($line =~ m/ -kubuntu-ci:| is now known as/);
  }
  $d = $d - 1;
}
