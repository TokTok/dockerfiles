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
   sources/android/cpufeatures
   toolchains/llvm/prebuilt/linux-x86_64/bin/clang
   toolchains/llvm/prebuilt/linux-x86_64/bin/clang++
   toolchains/llvm/prebuilt/linux-x86_64/lib/lib64
   toolchains/llvm/prebuilt/linux-x86_64/lib64
   toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include
);

my %NDK_FILES = (
   'aarch64-linux-android' => [@common, qw(
      toolchains/llvm/prebuilt/linux-x86_64/aarch64-linux-android
      toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android-*
      toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android29-*
      toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/aarch64-linux-android/29
   )],
   'arm-linux-androideabi' => [@common, qw(
      platforms/android-29/arch-arm
      sources/cxx-stl/llvm-libc++/libs/armeabi-v7a
      toolchains/arm-linux-androideabi-4.9
   )],
   'i686-linux-android' => [@common, qw(
      platforms/android-29/arch-x86
      sources/cxx-stl/llvm-libc++/libs/x86
      toolchains/x86-4.9
   )],
   'x86_64-linux-android' => [@common, qw(
      platforms/android-29/arch-x86_64
      sources/cxx-stl/llvm-libc++/libs/x86_64
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
