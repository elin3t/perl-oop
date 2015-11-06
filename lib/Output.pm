#
#===============================================================================
#
#         FILE: Output.pm
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 02/11/15 16:33:30
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

package Output;

sub new {
    my $class = shift;
    my $output = $_[0];
    my $self = {
        output => $output
    };

    bless $self, $class;

    return $self;
}

sub get_output {
    return shift->{'output'};
}

1;
 

