use Test::Base;

plan 'no_plan';

use Yiki;
use File::Temp qw/tempdir/;

my $wiki = Yiki->new( data_dir => tempdir( CLEANUP => 1 )  );

is_deeply($wiki->pages, [], 'empty pages');
ok(!$wiki->page('title'), 'empty page');

my $page = $wiki->new_page('title');
isa_ok($page, 'Yiki::Page');
$page->content('this is content');
$wiki->save($page);

my $saved_page = $wiki->page('title');
is( $saved_page->title, $page->title, 'title ok', );
is( $saved_page->content, $page->content, 'content ok' );

my $html = $wiki->render($page);
like( $html, qr{<p>this is content</p>} );





