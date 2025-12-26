# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Remove Regexp patterns from precompile array (not supported in Sprockets 4.x)
# This needs to run after all engines/gems have loaded
Rails.application.config.after_initialize do
  Rails.application.config.assets.precompile.delete_if { |item| item.is_a?(Regexp) }

  # Add explicit font file patterns if needed
  Rails.application.config.assets.precompile += %w[
    bootstrap/glyphicons-halflings-regular.eot
    bootstrap/glyphicons-halflings-regular.svg
    bootstrap/glyphicons-halflings-regular.ttf
    bootstrap/glyphicons-halflings-regular.woff
    bootstrap/glyphicons-halflings-regular.woff2
    login.css
    passwords.css
    custom.css
  ]
end
