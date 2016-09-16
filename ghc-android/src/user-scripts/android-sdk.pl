#!/usr/bin/env perl

use strict;

system "expect", "-c", <<EOF;
set timeout 5
spawn android-sdk-linux/tools/android @ARGV
expect {
  "Do you accept the license" {
    exp_send "y\\r"
    exp_continue
  }
  eof
}
EOF

exit $? >> 8;
