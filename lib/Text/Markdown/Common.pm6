# Text::Markdown::Common is a Markdown-to-HTML converter
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

=begin pod

=head1 Text::Markdown::Common

This is a drop-in replacement for Text::Markdown.

    use Text::Markdown::Common;
    my $md = Text::Markdown::Common.new($raw-md);
    say $md.render;

or

    use Text::Markdown::Common;
    my $md = parse-markdown($raw-md);
    say $md.to_html;

=end pod

class Text::Markdown::Common {

    has Str $.html is rw;

    method to-html {
        return $.html;
    }

    method to_html(Nil --> Str) {
        return $.html;
    }
}

sub parse-markdown(Str $raw-md --> Text::Markdown::Common) is export {
    return Text::Markdown::Common.new(html => parse($raw-md));
}

sub parse(Str $raw-md --> Str) {
    # FIXME
    return $raw-md;
}