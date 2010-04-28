Factory.define :repository do |r|
  r.name 'sample-repo'
  r.path File.expand_path(File.dirname(__FILE__) + '/../fixtures/sample-repo/')
end
