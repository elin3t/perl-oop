#
#===============================================================================
#
#         FILE: output.t
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 02/11/15 16:41:12
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

use Test::More;# tests => 1;                      # last test to print
use lib '../lib';
use Output;

my $output = Output->new("Error 1");
is($output->get_output(), "Error 1", "get_output");

done_testing();
