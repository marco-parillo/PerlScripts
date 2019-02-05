#!/usr/bin/perl

# Usage: perl GreenhouseSplice.pl InputFileName > OutputFileName
#        Where InputFileName is cut and pasted from Greenhouse list of completed SDL Self-Assessments.
#
# Problem: When cutting and pasting from Greenhouse, the table cells show on separate lines.
# Goal: Restore them for importing to a spreadsheet.
#

use strict;
use warnings;

#
# Perl Modules and Arch Packages (in case you need to install the packages containing these Modules)
#

# use DateTime;              # https://www.archlinux.org/packages/community/x86_64/perl-datetime/
# use LWP::Simple;           # https://www.archlinux.org/packages/extra/any/perl-lwp-protocol-https/
# use Date::Simple qw(date); # https://www.archlinux.org/packages/extra/x86_64/perl-date-simple/

my $Item;
my $Practice;    # Output Line of Greenhouse extract
my @InputFile;   # Input line of Greenhouse extract
my @OutputFile;
my @SortedOutputFile;

#
# Create Array of Self-Assessments
#

while (<>) {
  chomp;
  s/^\s+|\s+$//g;                  # Remove leading and trailing spaces
  s/st, 20/, 20/;                  # Remove ordinals from dates (1st, 2nd, 3rd, 4th, etc.) 
  s/nd, 20/, 20/;
  s/rd, 20/, 20/;
  s/th, 20/, 20/;
  push @InputFile, "$_";
}

#
# Splice the Self-Assessment Practices back together and add MS-DOS new line.
#

$Item = 0;
foreach my $Practice (@InputFile)
{
  if ($Item < 3) {
    $Item ++;
    push @OutputFile, $Practice, "\t";
  } else {
    push @OutputFile, $Practice, "\r\n";
    $Item = 0;
  }  
}  

print @OutputFile;
