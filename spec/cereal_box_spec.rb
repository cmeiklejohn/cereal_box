require 'spec_helper'

class Base
  def c
    "ceee"
  end

  def as_json(options = {})
    { :a => "a" }
  end
end

class AdditiveFilter
  include CerealBox

  def attributes(base)
    { :b => "b", :c => base.c }
  end
end

describe CerealBox do 

  describe 'with the base class' do 
    subject { Base.new } 

    it 'should serialize the base class correctly' do 
      subject.as_json.keys.should include :a
    end
  end

  describe 'with one additive filter' do 
    subject { AdditiveFilter.new(Base.new) } 

    it 'should include the base attributes' do 
      subject.as_json.keys.should include :a
    end

    it 'should include the additional direct attributes' do 
      subject.as_json.keys.should include :b
    end

    it 'should include the additional method attributes' do 
      subject.as_json.keys.should include :c
      subject.as_json[:c].should == "ceee"
    end
  end

end
