#!/usr/bin/perl

use strict;
use warnings;

my $InputURL = " ";
my $OutputURL = "https://";
my $CurrentChar = " ";
my $TranslateSite = ".translate.goog/";
my $TranslateParms = "?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en-US&_x_tr_pto=wapp";
my $SlashCount = 0; # Two slashes for the Protocol, Third after the domain name.

# Usage: perl Translate.pl URL
#        Where URL is the URL to be sent to Google Translate
#
# Note: Maximize your konsole window to avoid wrapping output

$InputURL = $ARGV[0];

foreach (0 .. length($InputURL)-1) {
  $CurrentChar = substr($InputURL,$_,1);
  if ($CurrentChar eq "\/") {
    $SlashCount = $SlashCount + 1;
    if ($SlashCount == 3) {
      $OutputURL = $OutputURL . $TranslateSite;
    }
    if ($SlashCount > 3) {
      $OutputURL = $OutputURL . $CurrentChar;
    }
  } else {
    if ($SlashCount == 2) {
       if ($CurrentChar eq ".") {
         $OutputURL = $OutputURL . "-";
       } else {
         $OutputURL = $OutputURL . $CurrentChar;
       }
    }
    if ($SlashCount > 2)  {
      $OutputURL = $OutputURL . $CurrentChar;
    }
  }
}

print $OutputURL, $TranslateParms, "\n";
