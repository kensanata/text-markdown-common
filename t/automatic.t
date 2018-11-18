# -*- perl6 -*-
# Copyright (C) 2018  Alex Schroeder <alex@gnu.org>
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU Affero General Public License as published by the
# Free Software Foundation, either version 3 of the License, or (at your
# option) any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License
# for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.

use Test;
use JSON::Tiny;
use Text::Markdown::Common;

sub load_tests {
  my $spec = "t/common-markdown-spec-0.28.json";
  return from-json($spec.IO.slurp);
}

sub normalize (Str $html is copy --> Str) {
  $html ~~ s/ \n $ //;
  return $html;
}

my @tests = load_tests.List; # this .List is required for the moment

for @tests -> %test {
  my $name = %test<example> ~ ". (" ~ %test<section> ~ ")";
  my $input = %test<markdown>;
  my $output = parse-markdown($input).to-html;
  my $correct = normalize(%test<html>);
  is($output, $correct, $name);
}

done-testing();
