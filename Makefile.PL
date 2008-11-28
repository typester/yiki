use inc::Module::Install;
name 'Yiki';
all_from 'lib/Yiki.pm';

test_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
