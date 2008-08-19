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

task :testing do
  # puts "Tasks before missing:\n"+Rake::Task.tasks.inspect
  ARGV.shift
  
  ARGV.each do |task_name|
    sake_file = task_name.gsub(':','/') + '.sake'
    import(sake_file)
  end
  
  Rake.application.load_imports
  
  # ARGV.each do |task_name|
  #   task_file = task_name.gsub(':','/') + '.sake'
  #   `rake -f #{task_file} #{task_name}`
  # end
  new_task = ARGV.first
  # Rake::Task.define_task(new_task) do 
  #   p 'running new task!'
  # end
  # import('folder/compress.sake')
  # Rake.application.load_imports
  # puts "Tasks end of missing:\n"+Rake::Task.tasks.inspect
end

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