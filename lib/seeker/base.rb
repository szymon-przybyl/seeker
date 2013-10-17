class Seeker::Base
  def initialize(params={})
    params.each do |attr, value|
      self.public_send("#{attr}=", value)
    end if params

    super()
  end

  def self.model_name
    @_model_name ||= begin
      model = eval self.name.sub(/Searcher$/, '')
      ActiveModel::Name.new(model)
    end
  end

  def self.model
    model_name.constantize
  end

  def self.searchable(&block)
    self.model.searchable &block
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
