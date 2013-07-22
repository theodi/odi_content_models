require "odi_content_models/version"
require "mongoid"
require "govuk_content_models"

begin
  module OdiContentModels
    class Engine < Rails::Engine
      config.to_prepare do
        Dir.glob(File.dirname(__FILE__) + "/../app/decorators/**/*_decorator*.rb").each do |c|
          require_dependency(c)
        end
      end
    end
  end
rescue NameError
  module OdiContentModels
  end
end
