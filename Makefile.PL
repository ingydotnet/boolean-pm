use inc::Module::Install;

all_from        'lib/boolean.pm';

readme_from;
manifest_skip;
version_check;
ack_xxx;

recommends      'Readonly';

WriteAll;
