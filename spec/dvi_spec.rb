require File.join(File.dirname(__FILE__), 'spec_helper.rb')

describe Dvi do
  it "can parse a dvi file(misc/latex/latex.dvi)" do
    path = File.join(File.dirname(__FILE__), "..", "misc", "latex", "latex.dvi")
    Proc.new{ Dvi.parse(File.open(path)) }.should_not raise_error(StandardError)
  end

  it "can process a dvi file(misc/latex/latex.dvi)" do
    path = File.join(File.dirname(__FILE__), "..", "misc", "latex", "latex.dvi")
    Proc.new{
      Dvi.process(File.open(path)).chars.each do |char|
        p [char.h, char.v, char.index]
      end
    }.should_not raise_error(StandardError)
  end
end
