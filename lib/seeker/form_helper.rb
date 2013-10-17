module Seeker::FormHelper
  def apply_form_for_options!(object_or_array, options) #:nodoc:
    object = object_or_array.is_a?(Array) ? object_or_array.last : object_or_array
    object = convert_to_model(object)

    as = options[:as]
    # added searcher
    action, method = if object.respond_to?(:searcher?)
                       [:search, :get]
                     else
                       object.respond_to?(:persisted?) && object.persisted? ? [:edit, :put] : [:new, :post]
                     end

    options[:html].reverse_merge!(
      :class  => as ? "#{action}_#{as}" : dom_class(object, action),
      :id     => as ? "#{action}_#{as}" : [options[:namespace], dom_id(object, action)].compact.join("_").presence,
      :method => method
    )

    options[:url] ||= polymorphic_path(object_or_array, :format => options.delete(:format))
  end
end
