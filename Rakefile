require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'net/http'
require 'capybara'
require 'capybara/apparition'
require 'yaml'

RSpec::Core::RakeTask.new(:spec)

def download(origin, target)
  sh "curl #{origin} -o #{target}"
end

desc 'Run specs'
task default: [:spec]

desc 'Update assets'
task update_assets: [:update_braintree, :update_dropin]

desc 'Update braintree client'
task :update_braintree do
  puts 'Downloading braintree.js'

  download(
    'https://js.braintreegateway.com/web/3.78.3/js/client.min.js',
    'spec/dummy/public/braintree.js'
  )

  download(
    "https://js.braintreegateway.com/web/dropin/1.30.1/js/dropin.min.js",
    "spec/dummy/public/dropin.js"
  )
end

desc 'Update braintree drop-in assets'
task :update_dropin do
  puts 'Determining drop-in version from client code'
  uri = URI('https://js.braintreegateway.com/web/3.78.3/js/client.min.js')
  js_client = Net::HTTP.get(uri)
  session = Capybara::Session.new(:apparition, ->{})
  session.execute_script(js_client)
  client_version = session.evaluate_script('braintree.VERSION')
  dropin_version = session.evaluate_script('braintree.dropin.VERSION')

  data = YAML::load_file('asset_versions.yml')
  if dropin_version == data['dropin_version']
    puts 'Drop-in assets up to date'
    next
  end

  rm_rf('lib/fake_braintree/braintree_assets/dropin')

  origin_root = "https://assets.braintreegateway.com/dropin/#{dropin_version}/"
  target_root = "lib/fake_braintree/braintree_assets/dropin/#{dropin_version}/"
  [
    'braintree-dropin-internal.min.js',
    'braintree-dropin.css',
    'inline-frame.html',
    'modal-frame.html',
    'vendor/jquery-2.1.0.js',
    'vendor/modernizr.js',
    'vendor/normalize.css',
    'images/2x-sf9a66b4f5a.png'
  ].each do |path|
    puts "Downloading #{path}"
    sh "curl #{origin_root + path} -o #{target_root + path} --create-dirs"
  end

  puts 'Updating asset_versions.yml'
  data['client_version'] = client_version
  data['dropin_version'] = dropin_version
  File.write('asset_versions.yml', data.to_yaml)
end
