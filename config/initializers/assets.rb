# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths += [
  Rails.root.join('vendor', 'assets').to_s,
  Rails.root.join('public', 'vendor', 'images').to_s,
  Rails.root.join('node_modules')
]

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Reffered: https://stackoverflow.com/a/36032861
js_prefix    = 'app/assets/javascripts/'
javascripts = Dir["#{js_prefix}**/*.js"].map      { |x| x.gsub(js_prefix,    '') }
Rails.application.config.assets.precompile +=(javascripts)
Rails.application.config.assets.precompile += %w( api.js datatables.css jquery-fileupload )
