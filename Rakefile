desc "List underlying sake-tasks"
task :list do
  tasks.each {|task| puts "%-35s %s" % [task.name, task.desc]  }
end

desc "Install sake tasks, uninstalling any pre-existing tasks first"
task :install do
  tasks.map do |task|
    puts `sake -u #{task.name}`
    puts `sake -i #{task.file}`
  end
end

task :default => :list

# helpers
require 'ostruct'
class SakeTask < OpenStruct
  def self.from_file(task_file)
    name = task_file.gsub('/', ':').gsub('.sake','')
    desc = `cat #{task_file}`.chomp[/desc +(?:["'](.*)['"])\n/,1]
    file = task_file
    new({:name=>name,:desc=>desc,:file=>task_file})
  end
end

# Array of sake-files relative to current path
# e.g. ['git/status.sake','git/pull.sake']
def task_files
  dir = (ENV['DIR'] ||= '')
  @task_files ||= Dir['**/*.sake'].grep(Regexp.new(dir)).sort
end

# Array of SakeTasks
def tasks
  @tasks = task_files.collect{|tf| SakeTask.from_file(tf)}
end