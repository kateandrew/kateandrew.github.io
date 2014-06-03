require 'gallery'
require 'nav'

activate :gzip
activate :automatic_image_sizes
activate :gallery
activate :auto_nav

helpers do
  def nav_class(navitem)
    page_classes == navitem ? 'active' : ''
  end
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

configure :build do
  activate :favicon_maker
  activate :minify_css
  activate :minify_javascript
  require "middleman-smusher"
end