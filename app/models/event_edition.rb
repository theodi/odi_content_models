require "edition"

class EventEdition < Edition

  field :start_date,  type: DateTime
  field :end_date,    type: DateTime
  field :location,    type: String
  field :description, type: String
  field :booking_url, type: String
  # map "image" is generated from location
  field :hashtag,     type: String
  
  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:description]

  @fields_to_clone = [  
    :start_date, :end_date, :location, :description, :booking_url, :hashtag
  ]

  def whole_body
    description
  end

  def rendering_app
    "www"
  end

end
