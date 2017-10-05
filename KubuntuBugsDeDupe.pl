#!/usr/bin/perl

use strict;
use warnings;

my @ListOfBugs = ();              # Array of bugs
my @SortedListOfBugs = ();        # Sorted Array of bugs
my @UniqueListOfBugs = ();        # Unique Array of bugs
my %unique = ();                  # Hash

# Usage: perl KubuntuBugsDeDupe.pl InputFileName
#        Where InputFileName is cut and pasted from launchpad.net bug report.
#
# Goal: To read from: Ubuntu Bugs HTML Output and create wiki syntax for bug list, e.g.
#        * (Bug:1403914) Crash after selecting timezone with non-US locale
#
# Note: Maximize your konsole window to avoid wrapping in output


#
# Create Array of Bugs in Wiki Format
#

while (<>) {
  chomp;
  s/^\s+|\s+$//g;                  # Remove leading and trailing spaces
  if (/^#/) {                      # Bugs start with a # character
    s/ /) /;                       # Substitute ) for first space to close the Bugs
    s/^#/ * (Bug:/;                # Substitute wiki bullet, followed by (Bug: for the opening #    
    push @ListOfBugs, "$_\n";      # Build Array of bugs followed by new line characters
  }
}
print "Input List \n";
print @ListOfBugs;                 # Print array of bugs


#
# Sort the Array of Bugs in Wiki Format
#


@SortedListOfBugs = sort @ListOfBugs;
print "Sorted List \n";
print @SortedListOfBugs;           # Print sorted array of bugs

#
# Eliminate duplicates by selecting keys from hash of Bugs
#


foreach my $item (@SortedListOfBugs)
{
    $unique{$item} ++;
}
@UniqueListOfBugs = keys %unique;
print "Unique List \n";
print @UniqueListOfBugs;
