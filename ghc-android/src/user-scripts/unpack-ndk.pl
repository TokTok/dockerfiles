#!/usr/bin/perl -w

use strict;
use warnings;
use Data::Dumper;

my ($NDK_RELEASE, $NDK_PACKAGE, $NDK_TOOLCHAIN) = @ARGV;

sub show {
   local $Data::Dumper::Indent = 0;
   local $Data::Dumper::Terse = 1;
   print Dumper @_;
   print "\n";
}

sub must_popen {
   if ($_[0] eq "-q") {
      shift;
   } else {
      show \@_;
   }
   open my $fh, '-|', @_
      or die "Could not exec '@_': $!";
   my @result = <$fh>;
   s/[\r\n]*//g for @result;
   @result
}

my @common = qw(
   toolchains/llvm
);

my %NDK_FILES = (
   'aarch64-linux-android' => [@common, qw(
      prebuilt/android-arm64
   )],
   'armv7a-linux-androideabi' => [@common, qw(
      prebuilt/android-arm
   )],
   'i686-linux-android' => [@common, qw(
      prebuilt/android-x86
   )],
   'x86_64-linux-android' => [@common, qw(
      prebuilt/android-x86_64
   )],
);

print "Extracting $NDK_PACKAGE...\n";
my @lines = do {
   my @files = map { "android-ndk-$NDK_RELEASE/$_" } @{ $NDK_FILES{$NDK_TOOLCHAIN} };
   must_popen "7z", "x", $NDK_PACKAGE, "-o$ENV{HOME}", map { "-ir!$_" } @files
};

my $extracted = grep { /^Extracting/ } @lines;
my $skipped   = grep { /^Skipping/   } @lines;
my (@rest)    = grep { !/^(Extract|Skipp)ing/ } @lines;
print "Extracted: $extracted\n";
print "Skipped: $skipped\n";
print "$_\n" for @rest;
