package t::helper;
use common::sense;
use File::Basename qw/dirname/;
use Cwd;

my $lib_path = Cwd::abs_path(dirname(__FILE__) . '/../lib');
unshift @INC, $lib_path;

1;
