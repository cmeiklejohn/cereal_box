require "cereal_box/version"

module CerealBox

  def self.included?(base)
    base.attr_accessor :cereal_base_instance
    base.attr_accessor :cereal_previous_filter
  end

  def initialize(base)
    @cereal_base_instance = base
  end

  def as_json(options = {})
    target = @cereal_previous_filter ? @cereal_previous_filter : @cereal_base_instance
    target.send(:as_json, options).merge(self.send(:attributes, @cereal_base_instance))
  end

end
