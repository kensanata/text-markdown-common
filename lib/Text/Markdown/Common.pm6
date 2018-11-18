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

grammar Text::Markdown::Common::Grammar {
    rule TOP {
        ^
        <block>*
        $
    }

    rule block {
        <paragraph> ( <blank-line>+ <paragraph> )*
    }

    rule paragraph {
        <line> ( <line-ending> <line> )*
    }

    rule line {
        <-[ \n \r ]>+
    }

    rule line-ending {
        ( \n | \r <!before \n> | \n \r )
    }

    rule blank-line {
        ^^
        [ \t]*
        $$
    }
}

class Text::Markdown::Common::ToHtml {

    method paragraph($/) {
        # FIXME how to do this?
        $/.make('<p>' ~ $/ ~ '</p>');
    }

    method line-ending {
        $/.make("\n");
    }

    method blank-line {
        $/.make("\n");
    }
}

sub parse-markdown(Str $raw-md --> Text::Markdown::Common) is export {
    return Text::Markdown::Common.new(
        html => Text::Markdown::Common::Grammar.parse(
            $raw-md, :actions(Text::Markdown::Common::ToHtml.new)).Str);
}
