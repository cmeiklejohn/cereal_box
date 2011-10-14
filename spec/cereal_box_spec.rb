require 'spec_helper'

class Base
  def c
    "ceee"
  end

  def as_xml(options = {})
    { :a => "a" }
  end

  def serializable_hash(options = {})
    { :a => "a" }
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

class SecondAdditiveFilter
  include CerealBox

  def attributes(base)
    { :d => "d" }
  end
end

class Basket
  def as_json(options = {})
    {}
  end
end

class LotionFilter 
  include CerealBox

  def attributes(base) 
    { :lotion => true }
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
      subject.as_json[:additive].should include :b
    end

    it 'should include the additional method attributes' do 
      subject.as_json[:additive].should include :c
      subject.as_json[:additive][:c].should == "ceee"
    end
  end

  describe 'with two additive filters' do 
    subject { SecondAdditiveFilter.new(AdditiveFilter.new(Base.new)) } 

    it 'should include the base attributes' do 
      subject.as_json.keys.should include :a
    end

    it 'should include the additional direct attributes' do 
      subject.as_json[:additive].should include :b
    end

    it 'should include the additional method attributes' do 
      subject.as_json[:additive].should include :c
      subject.as_json[:additive][:c].should == "ceee"
    end

    it 'should include the additional method attributes' do 
      subject.as_json[:second_additive].should include :d
    end
  end

  describe 'with one additive filter and using serializable_hash' do 
    subject { AdditiveFilter.new(Base.new) } 

    it 'should include the base attributes' do 
      subject.serializable_hash.keys.should include :a
    end

    it 'should include the additional direct attributes' do 
      subject.serializable_hash[:additive].should include :b
    end

    it 'should include the additional method attributes' do 
      subject.serializable_hash[:additive].should include :c
      subject.serializable_hash[:additive][:c].should == "ceee"
    end
  end

  describe 'with one additive filter and using as_xml' do 
    subject { AdditiveFilter.new(Base.new) } 

    it 'should include the base attributes' do 
      subject.as_xml.keys.should include :a
    end

    it 'should include the additional direct attributes' do 
      subject.as_xml[:additive].should include :b
    end

    it 'should include the additional method attributes' do 
      subject.as_xml[:additive].should include :c
      subject.as_xml[:additive][:c].should == "ceee"
    end
  end

  describe 'with a basket and some lotion' do
    subject { LotionFilter.new(Basket.new) }

    it 'puts the lotion in the basket' do 
      subject.as_json[:lotion].should include :lotion
    end
  end

end
