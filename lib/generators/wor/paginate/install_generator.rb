module Wor
  module Paginate
    module Generators
      class InstallGenerator < Rails::Generators::Base
        source_root File.expand_path('../../../templates', __FILE__)
        desc 'Creates Wor-Paginate initializer for your application'

        def copy_initializer
          template 'wor_paginate.rb', 'config/initializers/wor_paginate.rb'
        end
      end
    end
  end
end
