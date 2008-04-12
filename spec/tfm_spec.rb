require File.join(File.dirname(__FILE__), 'spec_helper.rb')

describe Dvi::Tfm do
  before do
    @ps = Dvi::Processor.new
  end

  it "can read tfm files." do
    Proc.new do
      Dvi::Tfm.read(Dvi::LsR.default.find("cmr8.tfm"))
    end.should_not raise_error(Dvi::Tfm::Format::Error)
  end
end

describe Dvi::Tfm, " when cmr8.tfm" do
  before do
    @tfm = Dvi::Tfm.read(Dvi::LsR.default.find("cmr8.tfm"))
  end

  it "font_size should be 8pt." do
    @tfm.design_size.should == 8.0
  end

  it "font_coding_scheme should be 'TeX text.'" do
    @tfm.font_coding_scheme.should == "TeX text"
  end

  it "font_identifier should be 'CMR'." do
    @tfm.font_identifier.should == "CMR"
  end

  it "should contains 128 character informations." do
    @tfm.char.size.should == 128
  end

  it "width of 'a' should be 0.531258(design-size unit)." do
    (@tfm.char[97].width*1000000).round.should == 531258
  end

  it "height of 'a' should be 0.430555(design-size unit)." do
    (@tfm.char[97].height*1000000).round.should == 430555
  end

  it "depth of 'a' should be 0." do
    @tfm.char[97].depth.should == 0
  end

  it "italic correction size of 'a' should be 0." do
    @tfm.char[97].italic_correction.should == 0
  end

  it "lig_kern size of 'a' should be 4." do
    @tfm.char[97].kerning.size.should == 4
  end

  it "kerning of 'a' should be a kind of Dvi::Tfm::Kerning." do
    @tfm.char[97].kerning.values.each do |k|
      k.should be_a_kind_of(Dvi::Tfm::Kerning)
    end
  end

  it "the kenring amount of 'av' should be -0.029514(design-size unit)." do
    (@tfm.char[97].kerning[118].amount*1000000).round.should == -29514
  end

  it "the kenring amount of 'aj' should be 0.059029(design-size unit)." do
    (@tfm.char[97].kerning[106].amount*1000000).round.should == 59029
  end

  it "the kenring amount of 'ay' should be -0.029514(design-size unit)." do
    (@tfm.char[97].kerning[121].amount*1000000).round.should == -29514
  end

  it "the kenring amount of 'aw' should be -0.029514(design-size unit)." do
    (@tfm.char[97].kerning[119].amount*1000000).round.should == -29514
  end

  it "ligature of 'fi' should be 12. (MAYBE)" do
    @tfm.char[102].ligature[105].index.should == 12
  end

  it "ligature of 'ff' should be 11. (MAYBE)" do
    @tfm.char[102].ligature[102].index.should == 11
  end

  it "ligature of 'fl' should be 13. (MAYBE)" do
    @tfm.char[102].ligature[108].index.should == 13
  end

  it "width of 'y' should be width 0.560772(design-size unit)." do
    (@tfm.char[121].width*1000000).round.should == 560772
  end

  it "height of 'y' should be 0.430555(design-size unit)." do
    (@tfm.char[121].height*1000000).round.should == 430555
  end

  it "depth of 'y' should be 0.194445(design-size unit)." do
    (@tfm.char[121].depth*1000000).round.should == 194445
  end

  it "italic correction size of 'y' should be 0.014757(design-size unit)." do
    (@tfm.char[121].italic_correction*1000000).round.should == 14757
  end

  after do
    @tfm = nil
  end
end

describe Dvi::Tfm, " when cmb10.tfm" do
  before do
    @tfm = Dvi::Tfm.read(Dvi::LsR.default.find("cmb10.tfm"))
  end

  it "font_size should be 10pt." do
    @tfm.design_size.should == 10.0
  end

  it "font_coding_scheme should be 'TeX text.'" do
    @tfm.font_coding_scheme.should == "TeX text"
  end

  it "font_identifier should be 'CMB'." do
    @tfm.font_identifier.should == "CMB"
  end

  it "should contains 128 character informations." do
    @tfm.char.size.should == 128
  end

  it "width of 'a' should be 0.486113(design-size unit)." do
    (@tfm.char[97].width*1000000).round.should == 486113
  end

  it "height of 'a' should be 0.444445(design-size unit)." do
    (@tfm.char[97].height*1000000).round.should == 444445
  end

  it "depth of 'a' should be 0." do
    @tfm.char[97].depth.should == 0
  end

  it "italic correction size of 'a' should be 0." do
    @tfm.char[97].italic_correction.should == 0
  end

  it "width of 'y' should be width 0.527781(design-size unit)." do
    (@tfm.char[121].width*1000000).round.should == 527781
  end

  it "height of 'y' should be 0.444445(design-size unit)." do
    (@tfm.char[121].height*1000000).round.should == 444445
  end

  it "depth of 'y' should be 0.194445(design-size unit)." do
    (@tfm.char[121].depth*1000000).round.should == 194445
  end

  it "italic correction size of 'y' should be 0.013888(design-size unit)." do
    (@tfm.char[121].italic_correction*1000000).round.should == 13888
  end

  after do
    @tfm = nil
  end
end
