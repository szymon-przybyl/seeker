class Seeker::Base
  class_attribute :model

  def self.construct(model)
    self.model = model
    model.searchable(@_searchable_options, &@_searchable) if @_searchable
    self
  end

  def initialize(params={})
    params.each do |attr, value|
      self.public_send("#{attr}=", value)
    end
  end

  def self.model_name
    @_model_name ||= ActiveModel::Name.new model
  end

  def self.searchable(searchable_options = {}, &block)
    @_searchable_options = searchable_options
    @_searchable = block
  end

  # Searcher needs to implement it
  def search(query, options = {}); end

  def options
    {}
  end

  def results
    self.class.model.search(options, &method(:search)).results
  end

  def to_key
    nil
  end

  def searcher?
    true
  end
end
