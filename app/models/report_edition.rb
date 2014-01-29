require "edition"
require "attachable"

class ReportEdition < Edition
  include Attachable

  field    :date, type: DateTime
  
  attaches :report

  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:description]

  clone_fields :date

  def rendering_app
    "www"
  end
  
  def whole_body
    nil
  end
  
  def rendering_path
    "/reports/#{slug}"
  end
  
end