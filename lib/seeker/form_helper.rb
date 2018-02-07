module Seeker::FormHelper
  def apply_form_for_options!(record, object, options) #:nodoc:
    object = convert_to_model(object) unless object.class < Seeker::Base

    as = options[:as]
    namespace = options[:namespace]
    # added searcher
    action, method = if object.class < Seeker::Base
                       [:search, :get]
                     else
                       object.respond_to?(:persisted?) && object.persisted? ? [:edit, :patch] : [:new, :post]
                     end

    object = convert_to_model(object) if object.class < Seeker::Base

    options[:html].reverse_merge!(
      class:  as ? "#{action}_#{as}" : dom_class(object, action),
      id:     (as ? [namespace, action, as] : [namespace, dom_id(object, action)]).compact.join("_").presence,
      method: method
    )

    options[:url] ||= if options.key?(:format)
                        polymorphic_path(record, format: options.delete(:format))
                      else
                        polymorphic_path(record, {})
                      end
  end
end