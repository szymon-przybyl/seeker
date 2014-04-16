require 'seeker/form_helper'
require 'seeker/searcher_mounter'

module Seeker
  class Railtie < Rails::Railtie
    initializer 'seeker.form_helper' do
      ActionView::Base.send :include, FormHelper
    end

    initializer 'seeker.searcher_mounter' do
      ActiveRecord::Base.send :extend, SearcherMounter
    end
  end
end