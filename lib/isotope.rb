require 'isotope/isotope'

module Isotope
end

if defined? Rails
  ActionView::Base.send :include, Isotope::ViewHelpers
  ActionController::Base.send :include, Isotope::ViewHelpers
end