require "odi_content_models/version"
require "mongoid"
require "govuk_content_models"

begin
  module OdiContentModels
    class Engine < Rails::Engine
    end
  end
rescue NameError
  module OdiContentModels
  end
end

require "odi_content_models/artefact_patches"