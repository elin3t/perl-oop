#
#===============================================================================
#
#         FILE: handler.t
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 02/11/15 14:28:25
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

use Test::More;#tests => 1;                      # last test to print
use lib '../lib';
use Handler;

my $handler = Handler->new();

is($handler->command_factory("A,jjlopez,Lopez,Juan José","command_factory"));

done_testing();


