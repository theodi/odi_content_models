require "odi_content_models/version"
require "mongoid"

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