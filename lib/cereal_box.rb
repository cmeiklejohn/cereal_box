require "cereal_box/version"

module CerealBox

  def self.included(base)
    base.send(:attr_accessor, :cereal_box_base_instance)
    base.send(:attr_accessor, :cereal_box_previous_filter)
  end

  def initialize(base)
    @cereal_box_base_instance = base
  end

  def cereal_box_node_name
    self.class.to_s.split(/(?=[A-Z])/).map{ |w| w.downcase }[0...-1].join("_").to_sym
  end

  def serializable_hash(options = {})
    apply(:serializable_hash, options)
  end

  def as_json(options = {}) 
    apply(:as_json, options)
  end

  def as_xml(options = {}) 
    apply(:as_xml, options)
  end

  def apply(message, options = {})
    target = @cereal_box_previous_filter ? @cereal_box_previous_filter : @cereal_box_base_instance
    target.send(message.to_sym, options).merge(
      { cereal_box_node_name => self.send(:attributes, @cereal_box_base_instance) }
    )
  end

end
