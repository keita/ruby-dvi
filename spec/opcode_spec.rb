require File.join(File.dirname(__FILE__), 'spec_helper.rb')

describe Dvi::Opcode::SetChar do
  before do
    @ps = Dvi::Processor.new
    tfm = Dvi::Tfm.read(Dvi::LsR.default.find("cmr10.tfm"))
    @ps.font = Dvi::Font.new(nil, 10, 10, nil, "cmr10", tfm)
  end

  it "opcode byte should be in range of 0..127" do
    0.upto(255) do |i|
      if (0..127).include?(i)
        Dvi::Opcode::SetChar.range.should include(i)
      else
        Dvi::Opcode::SetChar.range.should_not include(i)
      end
    end
  end

  it "move right with character width" do
    0.upto(127) do |i|
      setchar = Dvi::Opcode::SetChar.new(i)
      h = @ps.h
      setchar.interpret(@ps)
      @ps.h.should eql(h + @ps.font.design_size * @ps.chars[-1].metric.width)
    end
  end

  it "push a character" do
    0.upto(127) do |i|
      setchar = Dvi::Opcode::SetChar.new(i)
      c = @ps.chars.size
      setchar.interpret(@ps)
      @ps.chars.size.should == c + 1
      @ps.chars[-1].index.should == i
    end
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::Set do
  before do
    @ps = Dvi::Processor.new
    tfm = Dvi::Tfm.read(Dvi::LsR.default.find("cmr10.tfm"))
    @ps.font = Dvi::Font.new(nil, 10, 10, nil, "cmr10", tfm)
  end

  it "opcode byte should be 128..131" do
    0.upto(255) do |i|
      if (128..131).include?(i)
        Dvi::Opcode::Set.range.should include(i)
      else
        Dvi::Opcode::Set.range.should_not include(i)
      end
    end
  end

  it "index of set1 should be between 0..255" do
    -1.upto(256) do |i|
      if (0..255).include?(i)
        Proc.new do
          Dvi::Opcode::Set.new(i, 1)
        end.should_not raise_error(ArgumentError)
      else
        Proc.new do
          Dvi::Opcode::Set.new(i, 1)
        end.should raise_error(ArgumentError)
      end
    end
  end

  it "index of set2 should be between 0..65535" do
    [-1, 0, 65535, 65536].each do |i|
      if (0..65535).include?(i)
        Proc.new do
          Dvi::Opcode::Set.new(i, 2)
        end.should_not raise_error(ArgumentError)
      else
        Proc.new do
          Dvi::Opcode::Set.new(i, 2)
        end.should raise_error(ArgumentError)
      end
    end
  end

  it "index of set3 should be between 0..16777215" do
    [-1, 0, 16777215, 16777216].each do |i|
      if (0..16777215).include?(i)
        Proc.new do
          Dvi::Opcode::Set.new(i, 3)
        end.should_not raise_error(ArgumentError)
      else
        Proc.new do
          Dvi::Opcode::Set.new(i, 3)
        end.should raise_error(ArgumentError)
      end
    end
  end

  it "index of set4 should be between -2147483648..2147483647" do
    [-2147483648, -2147483647, 2147483647, 2147483648].each do |i|
      if (-2147483648..2147483647).include?(i)
        Proc.new do
          Dvi::Opcode::Set.new(i, 4)
        end.should_not raise_error(ArgumentError)
      else
        Proc.new do
          Dvi::Opcode::Set.new(i, 4)
        end.should raise_error(ArgumentError)
      end
    end
  end

  it "shold push a character with set1..set4" do
    1.upto(4) do |n|
      setchar = Dvi::Opcode::Set.new(1, n)
      c = @ps.chars.size
      setchar.interpret(@ps)
      @ps.chars.size.should == c + 1
      @ps.chars[-1].index.should == 1
    end
  end

  it "should move right with character width" do
    1.upto(4) do |n|
      0.upto(127) do |i|
        setchar = Dvi::Opcode::Set.new(i, n)
        h = @ps.h
        setchar.interpret(@ps)
        @ps.h.should eql(h + @ps.font.design_size * @ps.chars[-1].metric.width)
      end
    end
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::Put do
  before do
    @ps = Dvi::Processor.new
    tfm = Dvi::Tfm.read(Dvi::LsR.default.find("cmr10.tfm"))
    @ps.font = Dvi::Font.new(nil, 10, 10, nil, "cmr10", tfm)
  end

  it "opcode byte should be 133..136" do
    0.upto(255) do |i|
      if (133..136).include?(i)
        Dvi::Opcode::Put.range.should include(i)
      else
        Dvi::Opcode::Put.range.should_not include(i)
      end
    end
  end

  it "index of put1 should be between 0..255" do
    -1.upto(256) do |i|
      if (0..255).include?(i)
        Proc.new do
          Dvi::Opcode::Put.new(i, 1)
        end.should_not raise_error(ArgumentError)
      else
        Proc.new do
          Dvi::Opcode::Put.new(i, 1)
        end.should raise_error(ArgumentError)
      end
    end
  end

  it "index of put2 should be between 0..65535" do
    [-1, 0, 65535, 65536].each do |i|
      if (0..65535).include?(i)
        Proc.new do
          Dvi::Opcode::Put.new(i, 2)
        end.should_not raise_error(ArgumentError)
      else
        Proc.new do
          Dvi::Opcode::Put.new(i, 2)
        end.should raise_error(ArgumentError)
      end
    end
  end

  it "index of put3 should be between 0..16777215" do
    [-1, 0, 16777215, 16777216].each do |i|
      if (0..16777215).include?(i)
        Proc.new do
          Dvi::Opcode::Put.new(i, 3)
        end.should_not raise_error(ArgumentError)
      else
        Proc.new do
          Dvi::Opcode::Put.new(i, 3)
        end.should raise_error(ArgumentError)
      end
    end
  end

  it "index of put4 should be between -2147483648..2147483647" do
    [-2147483648, -2147483647, 2147483647, 2147483648].each do |i|
      if (-2147483648..2147483647).include?(i)
        Proc.new do
          Dvi::Opcode::Put.new(i, 4)
        end.should_not raise_error(ArgumentError)
      else
        Proc.new do
          Dvi::Opcode::Put.new(i, 4)
        end.should raise_error(ArgumentError)
      end
    end
  end

  it "should push a character with put1..put4" do
    1.upto(4) do |n|
      setchar = Dvi::Opcode::Put.new(1, n)
      c = @ps.chars.size
      setchar.interpret(@ps)
      @ps.chars.size.should == c + 1
      @ps.chars[-1].index.should == 1
    end
  end

  it "shouldn't move right with character width" do
    1.upto(4) do |n|
      0.upto(127) do |i|
        setchar = Dvi::Opcode::Put.new(i, n)
        h = @ps.h
        setchar.interpret(@ps)
        @ps.h.should eql(h)
      end
    end
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::SetRule do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 132" do
    0.upto(255) do |i|
      if i == 132
        Dvi::Opcode::SetRule.range.should include(i)
      else
        Dvi::Opcode::SetRule.range.should_not include(i)
      end
    end
  end

  it "should push a rule to the processor" do
    setrule = Dvi::Opcode::SetRule.new(1, 2)
    c = @ps.rules.size
    setrule.interpret(@ps)
    @ps.rules.size.should eql(c + 1)
  end

  it "should move right with rule width" do
    setrule = Dvi::Opcode::SetRule.new(1, 2)
    h = @ps.h
    setrule.interpret(@ps)
    @ps.h.should eql(h + 2)
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::PutRule do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 137" do
    0.upto(255) do |i|
      if i == 137
        Dvi::Opcode::PutRule.range.should include(i)
      else
        Dvi::Opcode::PutRule.range.should_not include(i)
      end
    end
  end

  it "should push a rule to the processor" do
    setrule = Dvi::Opcode::PutRule.new(1, 2)
    c = @ps.rules.size
    setrule.interpret(@ps)
    @ps.rules.size.should eql(c + 1)
  end

  it "shouldn't move right" do
    setrule = Dvi::Opcode::PutRule.new(1, 2)
    h = @ps.h
    setrule.interpret(@ps)
    @ps.h.should eql(h)
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::Nop do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 138" do
    0.upto(255) do |i|
      if i == 138
        Dvi::Opcode::Nop.range.should include(i)
      else
        Dvi::Opcode::Nop.range.should_not include(i)
      end
    end
  end

  it "should do nothing" do
    nop = Dvi::Opcode::Nop.new
    Proc.new{ @ps.process(nop) }.should_not raise_error(StandardError)
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::Bop do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 139" do
    0.upto(255) do |i|
      if i == 139
        Dvi::Opcode::Bop.range.should include(i)
      else
        Dvi::Opcode::Bop.range.should_not include(i)
      end
    end
  end

  it "should begin a new page" do
    @ps.h = 100
    @ps.v = 100
    @ps.w = 100
    @ps.x = 100
    @ps.y = 100
    @ps.z = 100
    @ps.process(Dvi::Opcode::Bop.new([0,0,0,0,0,0,0,0,0,0], -1))
    @ps.h.should == 0
    @ps.v.should == 0
    @ps.w.should == 0
    @ps.x.should == 0
    @ps.y.should == 0
    @ps.z.should == 0
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::Eop do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 140" do
    0.upto(255) do |i|
      if i == 140
        Dvi::Opcode::Eop.range.should include(i)
      else
        Dvi::Opcode::Eop.range.should_not include(i)
      end
    end
  end

  it "should set the stack empty" do
    @ps.stack << [1,2,3,4,5,6]
    n = @ps.stack.size
    @ps.process(Dvi::Opcode::Eop.new)
    @ps.stack.size.should == 0
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::Push do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 141" do
    0.upto(255) do |i|
      if i == 141
        Dvi::Opcode::Push.range.should include(i)
      else
        Dvi::Opcode::Push.range.should_not include(i)
      end
    end
  end

  it "should push the stack" do
    n = @ps.stack.size
    @ps.process(Dvi::Opcode::Push.new)
    @ps.stack.size.should == n + 1
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::Pop do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 141" do
    0.upto(255) do |i|
      if i == 142
        Dvi::Opcode::Pop.range.should include(i)
      else
        Dvi::Opcode::Pop.range.should_not include(i)
      end
    end
  end

  it "should pop the stack" do
    @ps.stack << [1,2,3,4,5,6]
    n = @ps.stack.size
    @ps.process(Dvi::Opcode::Pop.new)
    @ps.stack.size.should == n - 1
    @ps.h.should == 1
    @ps.v.should == 2
    @ps.w.should == 3
    @ps.x.should == 4
    @ps.y.should == 5
    @ps.z.should == 6
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::Right do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 143..146" do
    0.upto(255) do |i|
      if (143..146).include?(i)
        Dvi::Opcode::Right.range.should include(i)
      else
        Dvi::Opcode::Right.range.should_not include(i)
      end
    end
  end

  it "should move right" do
    h = @ps.h
    @ps.process(Dvi::Opcode::Right.new(100))
    @ps.h.should == h + 100
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::W0 do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 147" do
    0.upto(255) do |i|
      if i == 147
        Dvi::Opcode::W0.range.should include(i)
      else
        Dvi::Opcode::W0.range.should_not include(i)
      end
    end
  end

  it "should move right" do
    h = @ps.h
    @ps.w = 100
    @ps.process(Dvi::Opcode::W0.new)
    @ps.h.should == h + 100
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::W do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 148..151" do
    0.upto(255) do |i|
      if (148..151).include?(i)
        Dvi::Opcode::W.range.should include(i)
      else
        Dvi::Opcode::W.range.should_not include(i)
      end
    end
  end

  it "should change w and move right" do
    h = @ps.h
    @ps.w = 0
    @ps.process(Dvi::Opcode::W.new(100))
    @ps.w.should == 100
    @ps.h.should == h + 100
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::X0 do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 147" do
    0.upto(255) do |i|
      if i == 152
        Dvi::Opcode::X0.range.should include(i)
      else
        Dvi::Opcode::X0.range.should_not include(i)
      end
    end
  end

  it "should move right" do
    h = @ps.h
    @ps.x = 100
    @ps.process(Dvi::Opcode::X0.new)
    @ps.h.should == h + 100
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::X do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 153..156" do
    0.upto(255) do |i|
      if (153..156).include?(i)
        Dvi::Opcode::X.range.should include(i)
      else
        Dvi::Opcode::X.range.should_not include(i)
      end
    end
  end

  it "should change x and move right" do
    h = @ps.h
    @ps.x = 0
    @ps.process(Dvi::Opcode::X.new(100))
    @ps.x.should == 100
    @ps.h.should == h + 100
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::Down do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 157..160" do
    0.upto(255) do |i|
      if (157..160).include?(i)
        Dvi::Opcode::Down.range.should include(i)
      else
        Dvi::Opcode::Down.range.should_not include(i)
      end
    end
  end

  it "should move down" do
    v = @ps.v
    @ps.process(Dvi::Opcode::Down.new(100))
    @ps.v.should == v + 100
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::Y0 do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 161" do
    0.upto(255) do |i|
      if i == 161
        Dvi::Opcode::Y0.range.should include(i)
      else
        Dvi::Opcode::Y0.range.should_not include(i)
      end
    end
  end

  it "should move down" do
    v = @ps.v
    @ps.y = 100
    @ps.process(Dvi::Opcode::Y0.new)
    @ps.v.should == v + 100
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::Y do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 162..165" do
    0.upto(255) do |i|
      if (162..165).include?(i)
        Dvi::Opcode::Y.range.should include(i)
      else
        Dvi::Opcode::Y.range.should_not include(i)
      end
    end
  end

  it "should change y and move down" do
    v = @ps.v
    @ps.y = 0
    @ps.process(Dvi::Opcode::Y.new(100))
    @ps.y.should == 100
    @ps.v.should == v + 100
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::Z0 do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 166" do
    0.upto(255) do |i|
      if i == 166
        Dvi::Opcode::Z0.range.should include(i)
      else
        Dvi::Opcode::Z0.range.should_not include(i)
      end
    end
  end

  it "should move down" do
    v = @ps.v
    @ps.z = 100
    @ps.process(Dvi::Opcode::Z0.new)
    @ps.v.should == v + 100
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::Z do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 167..170" do
    0.upto(255) do |i|
      if (167..170).include?(i)
        Dvi::Opcode::Z.range.should include(i)
      else
        Dvi::Opcode::Z.range.should_not include(i)
      end
    end
  end

  it "should change z and move down" do
    v = @ps.v
    @ps.z = 0
    @ps.process(Dvi::Opcode::Z.new(100))
    @ps.z.should == 100
    @ps.v.should == v + 100
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::FntNum do
  before do
    @ps = Dvi::Processor.new
    @ps.process(Dvi::Opcode::FntDef.new(1, nil, 1, 1, nil, "cmr8"))
    @ps.process(Dvi::Opcode::FntDef.new(2, nil, 1, 1, nil, "cmr10"))
    @ps.process(Dvi::Opcode::FntDef.new(3, nil, 1, 1, nil, "cmb10"))
  end

  it "opcode byte should be 171..234" do
    0.upto(255) do |i|
      if (171..234).include?(i)
        Dvi::Opcode::FntNum.range.should include(i)
      else
        Dvi::Opcode::FntNum.range.should_not include(i)
      end
    end
  end

  it "should change the current font" do
    @ps.process(Dvi::Opcode::FntNum.new(1))
    @ps.font.name.should == "cmr8"
    @ps.process(Dvi::Opcode::FntNum.new(2))
    @ps.font.name.should == "cmr10"
    @ps.process(Dvi::Opcode::FntNum.new(3))
    @ps.font.name.should == "cmb10"
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::Fnt do
  before do
    @ps = Dvi::Processor.new
    @ps.process(Dvi::Opcode::FntDef.new(1, nil, 1, 1, nil, "cmr8"))
    @ps.process(Dvi::Opcode::FntDef.new(2, nil, 1, 1, nil, "cmr10"))
    @ps.process(Dvi::Opcode::FntDef.new(3, nil, 1, 1, nil, "cmb10"))
  end

  it "opcode byte should be 171..234" do
    0.upto(255) do |i|
      if (171..234).include?(i)
        Dvi::Opcode::FntNum.range.should include(i)
      else
        Dvi::Opcode::FntNum.range.should_not include(i)
      end
    end
  end

  it "should change the current font" do
    @ps.process(Dvi::Opcode::FntNum.new(1))
    @ps.font.name.should == "cmr8"
    @ps.process(Dvi::Opcode::FntNum.new(2))
    @ps.font.name.should == "cmr10"
    @ps.process(Dvi::Opcode::FntNum.new(3))
    @ps.font.name.should == "cmb10"
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::XXX do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 239..242" do
    0.upto(255) do |i|
      if (239..242).include?(i)
        Dvi::Opcode::XXX.range.should include(i)
      else
        Dvi::Opcode::XXX.range.should_not include(i)
      end
    end
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::FntDef do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 243..246" do
    0.upto(255) do |i|
      if (243..246).include?(i)
        Dvi::Opcode::FntDef.range.should include(i)
      else
        Dvi::Opcode::FntDef.range.should_not include(i)
      end
    end
  end

  it "should add a font" do
    f = @ps.fonts.size
    @ps.process(Dvi::Opcode::FntDef.new(1, nil, 1, 1, nil, "cmr10"))
    @ps.fonts.size.should == f + 1
  end

  after do
    @ps = nil
  end
end

describe Dvi::Opcode::Pre do
  before do
    @ps = Dvi::Processor.new
  end

  it "opcode byte should be 247" do
    0.upto(255) do |i|
      if i == 247
        Dvi::Opcode::Pre.range.should include(i)
      else
        Dvi::Opcode::Pre.range.should_not include(i)
      end
    end
  end

  it "set processor's dvi_version" do
    @ps.dvi_version = nil
    @ps.process(Dvi::Opcode::Pre.new(2, 25400000, 473628672, 1000, "This is a test."))
    @ps.dvi_version.should == 2
  end

  it "set processor's numerator" do
    @ps.numerator = nil
    @ps.process(Dvi::Opcode::Pre.new(2, 25400000, 473628672, 1000, "This is a test."))
    @ps.numerator.should == 25400000
  end

  it "set processor's denominator" do
    @ps.denominator = nil
    @ps.process(Dvi::Opcode::Pre.new(2, 25400000, 473628672, 1000, "This is a test."))
    @ps.denominator.should == 473628672
  end

  it "set processor's mag" do
    @ps.mag = nil
    @ps.process(Dvi::Opcode::Pre.new(2, 25400000, 473628672, 1000, "This is a test."))
    @ps.mag.should == 1000
  end

  after do
    @ps = nil
  end
end
