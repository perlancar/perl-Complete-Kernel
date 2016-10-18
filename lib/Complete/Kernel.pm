package Complete::Kernel;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use Complete::Common qw(:all);

use Exporter qw(import);
our @EXPORT_OK = qw(
                       complete_kernel
               );

our %SPEC;

$SPEC{complete_kernel} = {
    v => 1.1,
    summary => 'Complete kernel name',
    args => {
        %arg_word,
    },
    result_naked => 1,
    result => {
        schema => 'array',
    },
};
sub complete_kernel {
    require Complete::Util;

    my %args  = @_;

    my %kernels;
    {
        opendir my($dh), "/lib/modules" or last;
        while (my $e = readdir($dh)) {
            next if $e eq '.' || $e eq '..';
            $kernels{$e}++;
        }
    }

    Complete::Util::complete_hash_key(
        word=>$args{word}, hash=>\%kernels,
    );
}

1;
# ABSTRACT:

=head1 DESCRIPTION


=head1 SEE ALSO

L<Complete>

Other C<Complete::*> modules.
