require 'rubygems'
require 'sake'

namespace :install do
  
  desc "Install all tasks contained in this directory and it's subdirectories"
  task :all do
    Dir['**/*.sake'].each do |task_file|
      tasks = Sake::TasksFile.parse(task_file).tasks
      uninstall_tasks(tasks)
      puts `sake -i #{task_file}`
    end
  end
  
  desc "Install the sake file that was updated last"
  task :latest do 
    sorted_tasks = Dir['**/*.sake'].sort_by do |task| 
      File.ctime(task)
    end
    
    task_file = sorted_tasks.last
    tasks = Sake::TasksFile.parse(task_file).tasks
    uninstall_tasks(tasks)
    puts `sake -i #{task_file}`
  end
  
  desc "Install specified file(s) [f=load,params] (no need to include .sake extension)"
  task :file do
    files = ENV['f'].split(',') rescue []
    files.collect { |f| f.sub('.sake', '') }
  
    Dir["**/*.sake"].find do |task_file|
      stripped_name = task_file.sub('.sake', '')
      if files.include?(stripped_name)
        tasks = Sake::TasksFile.parse(task_file).tasks
        uninstall_tasks(tasks)
        puts `sake -i #{task_file}`
      end
    end
  end
  
  # Not exactly the most effecient method, but it works
  desc "Install specified task(s) [t=git:push,git:pull]"
  task :task do
    specified_tasks = ENV['t'].split(',') rescue []
    uninstall_tasks(specified_tasks)
    
    Dir["**/*.sake"].each do |task_file|
      tasks = Sake::TasksFile.parse(task_file).tasks
      tasks.each do |task|
        if specified_tasks.include?(task.to_s)
         puts `sake -i #{task_file} #{task}` 
        end
      end
    end
    
  end
  
  def uninstall_tasks(tasks)
    tasks.each {|t| `sake -u #{t}`}
  end
end


desc "Run latest source of task"
task :testrun do
  task_names = ARGV.grep(/(.+:)+/)
  
  task_names.each do |task_name|
    sake_file = task_name.gsub(':','/') + '.sake'
    import(sake_file) if File.exists?(sake_file)

    Rake.application.load_imports
    (task_names << Rake::Task[task_name].prerequisites).flatten!
  end
end

task :install => "install:all"
task :default => "install:all"