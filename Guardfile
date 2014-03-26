guard :rspec, cmd: 'bundle exec rspec' do
  watch %r{^spec/.+_spec\.rb$}

  watch %r{^lib/(.+)\.rb$} do |m|
    "spec/lib/#{m[1]}_spec.rb"
  end

  watch 'spec/spec_helper.rb' do
    'spec'
  end
end
