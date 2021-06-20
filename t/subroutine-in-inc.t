  <<<<<<< bootstrap-config
use strict;
use warnings FATAL => 'all';

use Test::More tests => 1;

use File::Spec;
use Cwd;
use lib 't/lib'; use TempDir;
use local::lib ();
  =======
#!/usr/bin/perl -w

use Test::More;

plan qw/no_plan/;

use File::Spec;
use Cwd;
use File::Temp qw/ tempdir /;
my $base;
  >>>>>>> multiple-perls-doc

sub CODE_in_INC() {
    return scalar grep { ref eq 'CODE' } @INC;
}

  <<<<<<< bootstrap-config
my $dir = mk_temp_dir('sub-in-INC-XXXXX');

my $base = CODE_in_INC;
unshift @INC, sub { () };
splice @INC, 3, 1, sub { () };
push @INC, sub { () };

local::lib->import($dir);
  =======
my $dir;

BEGIN {
    $base = CODE_in_INC;
    unshift @INC, sub { };
    splice @INC, 3, 1, sub { };
    push @INC, sub { };

    $dir = tempdir( DIR => Cwd::abs_path('t'), CLEANUP => 1 );
}

use local::lib( $dir );
  >>>>>>> multiple-perls-doc

is( CODE_in_INC, $base + 3 );
