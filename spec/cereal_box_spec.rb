require 'spec_helper'

class Base
  def as_json 
    { :a => "a" }
  end
end

class AdditiveFilter
  include CerealBox

  def attributes
    { :b => "b" }
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

    it 'should include the additional attributes' do 
      subject.as_json.keys.should include :b
    end
  end

end
