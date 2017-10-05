#!/usr/bin/perl

# Print daily Kubuntu-devel IRC logs
# EndDate defaults to today
# Change StartDate to set first day's log to print
# Search for my nicks

use strict;
use warnings;

#
# Perl Modules and Arch Packages (in case you need to install the packages containing these Modules)
#

use DateTime;              # https://www.archlinux.org/packages/community/x86_64/perl-datetime/
use LWP::Simple;           # https://www.archlinux.org/packages/extra/any/perl-lwp-protocol-https/
use Date::Simple qw(date); # https://www.archlinux.org/packages/extra/x86_64/perl-date-simple/

my $path;    # Constructed from Date String                 
my $url;     # Full URL, including the Domain, Path, and Channel
my $WebPage; # Full page of IRC Logs for a date
my $line;    # Current Line of IRC Log (needed to exclude KCI and nick changes)
my $Domain = "https://irclogs.ubuntu.com/";
my $Channel = "/%23kubuntu-devel.txt";
my $StartDate = "2012-08-17";
my $EndDate = substr (DateTime->now()->iso8601(), 0, 10);
my $d = date($StartDate);


while ($d le $EndDate) {
  $path = $d;
  $path =~ s$-$/$g;
  $url = $Domain.$path.$Channel;
  $WebPage = get ($url);
  foreach $line (split /\n/ ,$WebPage) {
    print $d,$line,"\n" if ($line =~ m/parillo/);
  }
  $d = $d + 1;
}
