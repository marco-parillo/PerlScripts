#!/usr/bin/perl

use strict;
use warnings;

my $InputURL = " ";
my $OutputURL = "https://";
my $TranslateSite = ".translate.goog/";
my $TranslateParms = "?_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=en-US&_x_tr_pto=wapp";
my $SlashCount = 0; # Two slashes for the Protocol, Third after the domain name.

# Usage: perl Translate.pl URL
#        Where URL is the URL to be sent to Google Translate
#
# Note: Maximize your konsole window to avoid wrapping output

$InputURL = $ARGV[0];

foreach (0 .. length($InputURL)-1) {
  if ((substr($InputURL,$_,1)) eq "\/") {
    $SlashCount = $SlashCount + 1;
    if ($SlashCount == 3) {
      $OutputURL = $OutputURL . $TranslateSite;
    }
    if ($SlashCount > 3) {
      $OutputURL = $OutputURL . substr($InputURL,$_,1);
    }
  } else {
    if ($SlashCount == 2) {
       if (substr($InputURL,$_,1) eq ".") {
         $OutputURL = $OutputURL . "-";
       } else {
         $OutputURL = $OutputURL . substr($InputURL,$_,1);
       }
    }
    if ($SlashCount > 2)  {
      $OutputURL = $OutputURL . substr($InputURL,$_,1);
    }
  }
}

print $OutputURL, $TranslateParms, "\n";
