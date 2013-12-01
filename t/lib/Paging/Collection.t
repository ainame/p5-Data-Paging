use strict;
use warnings;

use t::helper;
use Test::More;
use Test::More::Hooks;
use Test::Fatal;

BEGIN {
    use_ok 'Paging::Collection';
}

subtest 'instantiate with total_count params' => sub {
    my ($collection, $total_count);
    before {
        $total_count = 10;
    };

    subtest 'when current_page is the first page' => sub {
        before {
            $collection = Paging::Collection->new(
                entries      => [qw/a b c d e f/],
                total_count   => $total_count,
                per_page     => 5,
                current_page => 1,
            );
        };

        subtest 'calc valid entries' => sub {
            is_deeply $collection->entries, [qw/a b c d e f/];
            is_deeply $collection->sliced_entries, [qw/a b c d e/];
        };

        subtest 'calc valid paging values' => sub {
            is $collection->current_visit_count, 5;
            is $collection->already_visited_count, 0;
            is $collection->visited_count, 5;
        };

        subtest 'calc valid position values' => sub {
            is $collection->begin_count, 1;
            is $collection->end_count, 5;
            is $collection->begin_position, 1;
            is $collection->end_position, 5;
        };

        subtest 'calc valid page number values' => sub {
            is $collection->first_page, 1;
            is $collection->last_page, 2;
            ok not $collection->has_prev;
            ok $collection->has_next;
            ok not $collection->prev_page;
            is $collection->next_page, 2;
        };
    };

    subtest 'when current_page is the last page' => sub {
        before {
            $collection = Paging::Collection->new(
                entries      => [qw/a b c d e/],
                total_count   => $total_count,
                per_page     => 5,
                current_page => 2,
            );
        };

        subtest 'calc valid entries' => sub {
            is_deeply $collection->entries, [qw/a b c d e/];
            is_deeply $collection->sliced_entries, [qw/a b c d e/];
        };

        subtest 'calc valid paging values' => sub {
            is $collection->current_visit_count, 5;
            is $collection->already_visited_count, 5;
            is $collection->visited_count, 10;
        };

        subtest 'calc valid position values' => sub {
            is $collection->begin_count, 6;
            is $collection->end_count, 10;
            is $collection->begin_position, 1;
            is $collection->end_position, 5;
        };

        subtest 'calc valid page number values' => sub {
            is $collection->first_page, 1;
            is $collection->last_page, 2;
            is $collection->prev_page, 1;
            is $collection->next_page, 3;
            ok $collection->has_prev;
            ok not $collection->has_next;
        };
    };

};

subtest 'instantiate without total_count params' => sub {
    my ($collection);

    subtest 'when current_page is the first page' => sub {
        before {
            $collection = Paging::Collection->new(
                entries      => [qw/a b c d e/],
                per_page     => 5,
                current_page => 1,
            );
        };

        subtest 'calc valid paging values' => sub {
            is $collection->current_visit_count, 5;
            is $collection->already_visited_count, 0;
            is $collection->visited_count, 5;
        };

        subtest 'calc valid position values' => sub {
            is $collection->begin_count, 1;
            is $collection->end_count, 5;
            is $collection->begin_position, 1;
            is $collection->end_position, 5;
        };

        subtest 'calc valid page number values' => sub {
            is $collection->first_page, 1;
            ok not $collection->has_prev;
            is $collection->prev_page, 0;
            ok not $collection->has_next;
            is $collection->next_page, 2;
        };

        subtest 'cant calc without total_count' => sub {
            ok exception { $collection->last_page };
        };
    };

    subtest 'when current_page is the last page' => sub {
        before {
            $collection = Paging::Collection->new(
                entries      => [qw/a b c d/],
                per_page     => 5,
                current_page => 2,
            );
        };

        subtest 'calc valid entries' => sub {
            is_deeply $collection->entries, [qw/a b c d/];
            is_deeply $collection->sliced_entries, [qw/a b c d/];
        };

        subtest 'calc valid paging values' => sub {
            is $collection->current_visit_count, 4;
            is $collection->already_visited_count, 5;
            is $collection->visited_count, 9;
        };

        subtest 'calc valid position values' => sub {
            is $collection->begin_count, 6;
            is $collection->end_count, 9;
            is $collection->begin_position, 1;
            is $collection->end_position, 4;
        };

        subtest 'calc valid page number values' => sub {
            is $collection->first_page, 1;
            is $collection->prev_page, 1;
            is $collection->next_page, 3;
            ok $collection->has_prev;
            ok not $collection->has_next;
        };

        subtest 'can\'t calc without total_count' => sub {
            ok exception { $collection->last_page };
        };
    };

    subtest 'when current_page is the first page and padding row' => sub {
        before {
            $collection = Paging::Collection->new(
                entries      => [qw/a b c d e f/],
                per_page     => 5,
                current_page => 1,
            );
        };

        subtest 'calc valid paging values' => sub {
            is $collection->current_visit_count, 5;
            is $collection->already_visited_count, 0;
            is $collection->visited_count, 5;
        };

        subtest 'calc valid position values' => sub {
            is $collection->begin_count, 1;
            is $collection->end_count, 5;
            is $collection->begin_position, 1;
            is $collection->end_position, 5;
        };

        subtest 'calc valid page number values' => sub {
            is $collection->first_page, 1;
            ok not $collection->has_prev;
            is $collection->prev_page, 0;
            ok $collection->has_next, 'should return true';
            is $collection->next_page, 2;
        };

        subtest 'cant calc without total_count' => sub {
            ok exception { $collection->last_page };
        };
    };
};

done_testing;
