#!/usr/bin/perl

### Modify here as your wish ###
my $NAME   = 'zombie';
my $BRANCH = 'brainless';
my $REMOTE = 'git@save.my.brian';
my $REMOTE_BRANCH = 'surgery';

################################

use File::Basename;
my $filename = $0;
my $where = dirname($filename);
chdir $where;

&create_branch if not &branch_exist;
&commit_changes;
&push_to_remote;

sub create_branch() {
    print "Create branch: git checkout -b $BRANCH\n";
    print `git checkout -b $BRANCH`;
    print "Create remote: git remote add $NAME $REMOTE\n";
    print `git remote add $NAME $REMOTE`;
}

sub branch_exist() {
    my @branches = `git branch`;
    foreach(@branches) {
	return 1 if $_ =~ /.*$BRANCH.*/;
    }

    print "Branch $BRANCH not exist\n";
    return 0;
}

sub commit_changes {
    chomp (my $date = `date -R`);

    print `git checkout $BRANCH`;
    print `git add uploads/*`;
    print `git add wiki.d/*`;
    print `git add *`;
    print `git commit -m "$date"`;
}

sub push_to_remote {
    print `git push $NAME $BRANCH:$REMOTE_BRANCH`;
}
