## Installation

First, clone the sake-tasks repo:

	git clone git://github.com/drnic/sake-tasks.git

Or replace 'drnic' with your github username if you have forked the sake-tasks repo.

Then install the sake tasks (this step is repeatable, even if one or more tasks are already exist; that is, any pre-existing tasks with the same name will be overridden)

	rake install

To see your list of resulting tasks:

	sake -T

## What are Sake tasks/recipes?

It's the marvelous Sake, system-wide Rake.  
http://errtheblog.com/posts/60-sake-bomb

## Current tasks

The following sake tasks are installed:

	sake check:erb                           # Find all .erb or .rhtml files in the current directory tree and report any syntax errors
	sake check:ruby                          # Find all .rb files in the current directory tree and report any syntax errors
	sake check:yaml                          # Find all .yml files in the current directory tree and report any syntax errors
	sake git:analyze:commits:flog_frequent   # Flog the most commonly revised files in the git history
	sake git:close                           # Delete the current branch and switch back to master
	sake git:manpages:install                # Install man pages for current git version
	sake git:open                            # Create a new branch off master
	sake git:publish                         # Push all changes to the SVN repository
	sake git:pull                            # Pull new commits from the repository
	sake git:push                            # Push all changes to the repository
	sake git:rebase                          # Pull new commits from the SVN repository
	sake git:src:install                     # Downloads and installs latest version of git
	sake git:status                          # Show the current status of the checkout
	sake git:topic                           # Create a new topic branch
	sake git:update                          # Pull new commits from the repository
	sake mysql:dump                          # Dump the database to FILE (depends on mysql:params)
	sake mysql:load                          # Load the database from FILE (depends on mysql:params)
	sake ssh:install_public_key              # Install your public key on a remote server.

## Adding new recipes/tasks

The installer rake task `rake install` works by assuming that each `.sake` file contains one sake task. This allows it to uninstall the task from sake first, and then re-install it (sake barfs if you attempt to reinstall an existing task).

So, to create a task `foo:bar:baz`, you'll need to add a folder `foo/bar` and create a file `baz.sake` inside it. Within that file you would then specify your task using `namespace` and `task` method calls:

	namespace 'foo' do
	  namespace 'bar' do
	    desc "This task ..."
	    task :baz do

	    end
	  end
	end

### Testing tasks (even if not installed)

Whilst a task is in development you can execute it locally, without sake, using `rake testrun`.

To run the local version of foo/bar/baz.sake, use:

	rake testrun foo:bar:baz

### Installing individual tasks/files

The `rake install` task can selectively install only tasks/files that you are working on, rather than all the files in your repository, using either the `ONLY_FILES` or `ONLY_TASKS` environment variable.

For example, to restrict `rake install` to only re-install a task `foo:bar:baz` you can either use:

	rake install ONLY_FILES=foo/bar/baz.sake
	rake install ONLY_TASKS=foo:bar:baz

The values can be comma-separated lists.

So for iterative install & run development you could run the install task and the sake task via the same command line:

	rake install ONLY_TASKS=foo:bar:baz && sake foo:bar:baz --trace

The optional `--trace` runs sake in trace mode so useful stacktrace information is given as necessary.

### TextMate users

The latest [Ruby.tmbundle](http://github.com/drnic/ruby-tmbundle) on github includes a `task` command that generates the above namespace/task snippet based on the path + file name. That is, inside the `foo/bar/baz.sake` file, make sure your grammar is 'Ruby' or 'Ruby on Rails' and then type "task" and press TAB. The above snippet will be generated ready for you to specify your task.

## Authors

* Luke Melia - many git + mysql + ssh tasks
* Dr Nic Williams - repeatable installer rake task
