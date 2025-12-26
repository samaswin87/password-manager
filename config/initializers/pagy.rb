# Pagy configuration for v9.3
require 'pagy/extras/overflow'
require 'pagy/extras/bootstrap'
require 'pagy/extras/metadata'

# Default configuration
Pagy::DEFAULT[:items] = 10
Pagy::DEFAULT[:size] = 7
Pagy::DEFAULT[:overflow] = :last_page
