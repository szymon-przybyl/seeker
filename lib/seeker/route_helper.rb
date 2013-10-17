module ActionDispatch::Routing::PolymorphicRoutes
  def polymorphic_url(record_or_hash_or_array, options = {})
    if record_or_hash_or_array.kind_of?(Array)
      record_or_hash_or_array = record_or_hash_or_array.compact
      if record_or_hash_or_array.first.is_a?(ActionDispatch::Routing::RoutesProxy)
        proxy = record_or_hash_or_array.shift
      end
      record_or_hash_or_array = record_or_hash_or_array[0] if record_or_hash_or_array.size == 1
    end

    record = extract_record(record_or_hash_or_array)
    record = convert_to_model(record)

    args = Array === record_or_hash_or_array ?
      record_or_hash_or_array.dup :
      [ record_or_hash_or_array ]

    inflection = if options[:action] && options[:action].to_s == "new"
                   args.pop
                   :singular
                   # added searcher
                 elsif (record.respond_to?(:persisted?) && !record.persisted? || record.respond_to?(:searcher?))
                   args.pop
                   :plural
                 elsif record.is_a?(Class)
                   args.pop
                   :plural
                 else
                   :singular
                 end

    args.delete_if {|arg| arg.is_a?(Symbol) || arg.is_a?(String)}
    named_route = build_named_route_call(record_or_hash_or_array, inflection, options)

    url_options = options.except(:action, :routing_type)
    unless url_options.empty?
      args.last.kind_of?(Hash) ? args.last.merge!(url_options) : args << url_options
    end

    args.collect! { |a| convert_to_model(a) }

    (proxy || self).send(named_route, *args)
  end
end