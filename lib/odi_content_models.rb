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
    class Edition
      def update_from_artefact(artefact)
        ####################################################################
        # Removing the update to title. This action is triggered when there
        # is an update to the artefact in Panopticon. Agreed with @pezolio
        # on 17 June to comment out, in case VERY BAD THINGS happen.
        # slug is the prime linkage, but think that section, department and
        # business_proposition are mastered in Panopticon / artefact, so
        # should maintain them there, and ensure that existing editions are
        # updated.
        # The issue is here: https://github.com/theodi/publisher/issues/135
        #

        # self.title = artefact.name unless published?
        self.slug = artefact.slug
        self.section = artefact.section
        self.department = artefact.department
        self.business_proposition = artefact.business_proposition
        self.save!
      end
    end
  end
rescue NameError
  module OdiContentModels
  end
end
