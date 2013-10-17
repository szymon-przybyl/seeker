require 'seeker/form_helper'
require 'seeker/route_helper'

module Seeker
  class Railtie < Rails::Railtie
    initializer 'seeker.form_helper' do
      ActionView::Base.send :include, FormHelper
    end
  end
end