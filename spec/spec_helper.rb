begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")

require "pp"
require "dvi"

$TEXMF = File.join(File.dirname(__FILE__), "..", "tmp")
Dvi::LsR.default = Dvi::LsR.new($TEXMF)

