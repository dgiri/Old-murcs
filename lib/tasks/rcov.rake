begin
  require 'rake'
  require 'rake/testtask'
  require 'rake/rdoctask'
  require 'tasks/rails'
  require 'cucumber/rake/task'
  
  def cleanup
    rm_f 'coverage'
    rm_f 'coverage.data'
  end
  
  def prepare_test_db
    cmd = "rake db:test:prepare"
    puts cmd
    sh cmd
  end
  
  def run_coverage(files)
    # turn the files we want to run into a  string
    if files.length == 0
      puts "No files were specified for testing"
      return
    end

    files = files.join(" ")

    if PLATFORM =~ /darwin/
      exclude = '--exclude "gems/*"'
    else
      exclude = '--exclude "rubygems/*"'
    end

    rcov = "rcov --rails -Ilib:test --sort coverage --text-report #{exclude}  --aggregate coverage.data"
    cmd = "#{rcov} #{files}"
    puts cmd
    sh cmd
  end
  
  def browse
    if PLATFORM =~ /darwin/
      system("open coverage/index.html") if PLATFORM['darwin']
    end
  end
  
  namespace :rcov do
    Cucumber::Rake::Task.new(:cucumber) do |t|
      t.rcov = true
      t.rcov_opts = %w{--exclude osx\/objc,gems\/,spec\/,features\/}
      t.rcov_opts << %[-o "features_rcov"]
    end
    
    desc "Measures unit, functional, and integration test coverage along with cucumber features"
    task :all do
      cleanup
      prepare_test_db
      Rake::Task["rcov:cucumber"].invoke
      run_coverage Dir["test/unit/**/*.rb", "test/functional/**/*.rb", "test/integration/**/*.rb"]
      browse
    end
    
    desc "Runs coverage on unit tests"
    task :units do
      cleanup
      prepare_test_db
      run_coverage Dir["test/unit/**/*.rb"]
      browse
    end
    
    desc "Runs coverage on functional tests"
    task :functionals do
      cleanup
      prepare_test_db
      run_coverage Dir["test/functional/**/*.rb"]
      browse
    end
    
    desc "Runs coverage on integration tests"
    task :integration do
      cleanup
      prepare_test_db
      run_coverage Dir["test/integration/**/*.rb"]
      browse
    end
  end
  
rescue LoadError => e
  desc 'Rcov rake task not available'
  task :rcov do
    abort e.message
  end
end
