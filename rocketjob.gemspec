$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'rocket_job/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name                  = 'rocketjob'
  s.version               = RocketJob::VERSION
  s.platform              = Gem::Platform::RUBY
  s.authors               = ['Reid Morrison']
  s.email                 = ['support@rocketjob.io']
  s.homepage              = 'http://rocketjob.io'
  s.summary               = "Ruby's missing batch system."
  s.executables           = ['rocketjob', 'rocketjob_perf']
  s.files                 = Dir['lib/**/*', 'bin/*', 'LICENSE.txt', 'README.md']
  s.test_files            = Dir['test/**/*']
  s.license               = 'Apache-2.0'
  s.has_rdoc              = true
  s.required_ruby_version = '>= 2.1'
  s.add_dependency 'concurrent-ruby', '~> 1.0'
  s.add_dependency 'mongoid', '>= 5.0'
  s.add_dependency 'semantic_logger', '~> 4.1'
  s.add_dependency 'aasm', '~> 4.12'
end
