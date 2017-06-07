package Makefile;

use strict;
use warnings FATAL => 'all';
use utf8;

use Exporter;
our @ISA = qw/Exporter/;
our @EXPORT = qw/makefile/;

my $ORGNAME    = 'toktoknet';
my $MAINTAINER = 'Iphigenia Df "iphydf@gmail.com"';

sub slurp {
   my ($file) = @_;
   local $/ unless wantarray;
   open my $fh, '<', $file
      or die "$file: $!";
   <$fh>
}

sub unslurp {
   my ($file, $data) = @_;
   open my $fh, '>', $file
      or die "$file: $!";
   print $fh $data;
}

sub makefile {
   my ($config) = @_;

   $config->{orgname}    //= $ORGNAME;
   $config->{maintainer} //= $MAINTAINER;
   $config->{version}    //= 'latest';

   $config->{tag}        = "$config->{orgname}/$config->{tag}";

   my @targets = keys %{ $config->{targets} };
   print "Building for [@targets]\n";

   for my $target (@targets) {
      my $vars = $config->{targets}{$target};
      $vars->{TARGET}     //= $target;
      $vars->{ORGNAME}    //= $config->{orgname};
      $vars->{MAINTAINER} //= $config->{maintainer};
      $vars->{VERSION}    //= $config->{version};
      $vars->{FULLVER}    //= "$config->{version}.$target";
      $vars->{FULLTAG}    //= "$config->{tag}:$vars->{FULLVER}";
   }

   print "Generating docker sources\n";

   for my $target (@targets) {
      my $vars = $config->{targets}{$target};
      for my $srcfile (<src/*.in>) {
         my $lines = slurp $srcfile;
         for my $var (keys %$vars) {
            $lines =~ s/\@$var\@/$vars->{$var}/g;
         }
         if (my @unresolved = $lines =~ /\@(\w+)\@/g) {
            die "Unresolved vars: @unresolved";
         }
         my $dstfile = $target . ($srcfile =~ m|^src(/.+)\.in$|)[0];
         unslurp $dstfile, $lines;
      }

      for my $dir (grep { -d } <src/*>) {
         system "cp", "-a", $dir, $target;
         die "copy failed for $dir -> $target/$dir" if $?;
      }
   }

   print "Generating Makefile\n";

   open my $fh, '>', 'Makefile'
      or die "Makefile: $!";
   print $fh "build: ", (join " ", (map { "build-$_" } @targets)), "\n";
   for my $target (@targets) {
      print $fh "\nbuild-$target: Makefile\n";
      print $fh "\tdocker build \$(DOCKERFLAGS) -t $config->{targets}{$target}{FULLTAG} -f $target/Dockerfile $target | tee $target/build.log\n";
   }

   print $fh "\n\n";
   print $fh "push: ", (join " ", (map { "push-$_" } @targets)), "\n";
   for my $target (@targets) {
      print $fh "\npush-$target: build-$target\n";
      print $fh "\tdocker push $config->{targets}{$target}{FULLTAG}\n";
   }

   # Self-update rule.
   print $fh "\n\n";
   print $fh "Makefile: configure ../Makefile.pm \$(shell find src -type f)\n";
   print $fh "\t./\$<\n";

   print "Setting permissions\n";
   for my $target (@targets) {
      system (
         "find", $target,
         "(",
         "-name", "*.sh",
         "-or",
         "-name", "*.pl",
         "-or",
         "-perm", "+100",
         ")",
         "-exec", "chmod", "755", "{}", ";",
      );
      die "chmod failed" if $?;
      system (
         "find", $target,
         "-not", "-perm", "+100",
         "-exec", "chmod", "644", "{}", ";",
      );
      die "chmod failed" if $?;
   }
}

1
