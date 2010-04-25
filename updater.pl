#!/usr/bin/perl

### Modify here as your wish ###
my $NAME   = 'zombie';
my $BRANCH = 'brainless';
my $REMOTE = 'git@save.my.brian';
my $REMOTE_BRANCH = 'surgery';

################################

&create_branch if not &branch_exist;
&commit_changes;
&push_to_remote;

sub create_branch() {
    print "Create branch: git checkout -b $BRANCH\n";
    `git checkout -b $BRANCH`;
    print "Create remote: git remote add $NAME $REMOTE\n";
    `git remote add $NAME $REMOTE`;
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
    print "git checkout $BRANCH";
    print "git add uploads/*\n";
    print "git add wiki.d/*\n";
    print "git commit -m \"$date\"\n";

    `git checkout $BRANCH`;
    `git add uploads/*`;
    `git add wiki.d/*`;
    `git commit -m "$date"`;
}

sub push_to_remote {
    print "git push $NAME $BRANCH:$REMOTE_BRANCH\n";
    `git push $NAME $BRANCH:$REMOTE_BRANCH`;
}
