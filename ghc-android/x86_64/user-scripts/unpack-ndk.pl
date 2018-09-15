#!/usr/bin/perl -w

use strict;
use warnings;
use Data::Dumper;

my ($NDK_RELEASE, $NDK_PACKAGE, $NDK_TARGET) = @ARGV;

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
   build
   sources/android/cpufeatures
   sources/cxx-stl/gnu-libstdc++/4.9/include
   prebuilt/linux-x86_64
   prebuilt/darwin-x86_64
   toolchains/llvm
);

my %NDK_FILES = (
   'aarch64-linux-android' => [@common, qw(
      platforms/android-21/arch-arm64
      prebuilt/android-arm64
      sources/cxx-stl/gnu-libstdc++/4.9/libs/arm64-v8a
      toolchains/aarch64-linux-android-4.9
   )],
   'arm-linux-androideabi' => [@common, qw(
      platforms/android-9
      sources/cxx-stl/gnu-libstdc++/4.9/libs/armeabi*
      toolchains/arm-linux-androideabi-4.9
   )],
   'i686-linux-android' => [@common, qw(
      platforms/android-9
      sources/cxx-stl/gnu-libstdc++/4.9/libs/x86
      toolchains/x86-4.9
   )],
   'x86_64-linux-android' => [@common, qw(
      platforms/android-21
      sources/cxx-stl/gnu-libstdc++/4.9/libs/x86_64
      toolchains/x86_64-4.9
   )],
);

print "Extracting $NDK_PACKAGE...\n";
my @lines = do {
   my @files = map { "android-ndk-$NDK_RELEASE/$_" } @{ $NDK_FILES{$NDK_TARGET} };
   must_popen "7z", "x", $NDK_PACKAGE, "-o$ENV{HOME}", map { "-ir!$_" } @files
};

my $extracted = grep { /^Extracting/ } @lines;
my $skipped   = grep { /^Skipping/   } @lines;
my (@rest)    = grep { !/^(Extract|Skipp)ing/ } @lines;
print "Extracted: $extracted\n";
print "Skipped: $skipped\n";
print "$_\n" for @rest;
