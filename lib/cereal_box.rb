require "cereal_box/version"

module CerealBox

  def self.included?(base)
    base.attr_accessor :_base_instance
  end

  def initialize(base)
    @_base_instance = base 
  end

  def as_json
    @_base_instance.send(:as_json).merge(self.send(:attributes))
  end

end
