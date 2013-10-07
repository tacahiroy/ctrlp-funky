package Foo;

use strict;
use warnings;

sub add {
  my $sum = 0;
  map { $sum += $_ } @_;
  $sum;
}

sub multi {
  my $sum = shift;
  map { $sum *= $_ } @_;
  $sum;
}

print add(1, 2, 3), "\n";
print multi(1, 2, 3, 4), "\n";

(sub { print 'anonymous', "\n" })->();
my $s = sub { print 'anon2', "\n" };
&$s;
