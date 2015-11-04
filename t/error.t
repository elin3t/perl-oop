#
#===============================================================================
#
#         FILE: error.t
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 02/11/15 16:55:38
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

use Test::More;# tests => 1;                      # last test to print

use lib '../lib';
use MyError;

my $error = MyError->new("Error 2");

is($error->get_output,"Error 2","get_output");

done_testing();
