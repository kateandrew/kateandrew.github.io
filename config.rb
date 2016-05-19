require 'pry'
activate :sprockets
activate :gzip
activate :automatic_image_sizes

helpers do
  def nav_class(navitem)
    page_classes == navitem ? 'active' : ''
  end
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

configure :build do
  # activate :favicon_maker, :icons => {
  #     "favicon_base.png" => [
  #         { icon: "apple-touch-icon-152x152-precomposed.png" },
  #         { icon: "apple-touch-icon-114x114-precomposed.png" },
  #         { icon: "apple-touch-icon-72x72-precomposed.png" },
  #     ]
  # }
  activate :deploy do |deploy|
    deploy.deploy_method = :git
  end
  # activate :minify_css
  # activate :minify_javascript
end