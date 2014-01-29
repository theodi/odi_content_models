require "edition"
require "attachable"

class ReportEdition < Edition
  include Attachable

  field    :date, type: DateTime
  
  attaches :report

  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:description]

  clone_fields :date, :report, :affiliation, :role, :description, :url,  
               :telephone, :email, :twitter, :linkedin, :github, :node

  def rendering_app
    "www"
  end
  
  def rendering_path
    "/reports/#{slug}"
  end
  
end