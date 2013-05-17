require 'rabl'

# Set autoload directory
%w{models controllers}.each do |dir|
  Dir.glob(File.expand_path("../#{dir}", __FILE__) + '/**/*.rb').each do |file|
    require file
  end
end

Rabl.register!
