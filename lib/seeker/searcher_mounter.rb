module SearcherMounter
  def mount_searcher(searcher)
    @_searcher = searcher.construct self
  end

  def searcher(attributes = {})
    @_searcher.new attributes
  end
end