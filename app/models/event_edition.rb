require "edition"

class EventEdition < Edition

  field :start_date,  type: DateTime
  field :end_date,    type: DateTime
  field :location,    type: String
  field :description, type: String
  field :booking_url, type: String
  # map "image" is generated from location
  field :hashtag,     type: String
  field :livestream,  type: Boolean
  
  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:description]

  @fields_to_clone = [  
    :start_date, :end_date, :location, :description, :booking_url, :hashtag, :livestream
  ]

  def whole_body
    description
  end

  def rendering_app
    "www"
  end

  def rendering_path
    tag_to_rendering_path  "lunchtime-lecture"          => "lunchtime-lectures",
                           "meetup"                     => "meetups",
                           "research-afternoon"         => "research-afternoons",
                           "open-data-challenge-series" => "challenge-series",
                           "roundtable"                 => "roundtables",
                           "workshop"                   => "workshops",
                           "networking-event"           => "networking-events",
                           "panel-discussion"           => "panel-discussions",
                           :default => 'events'
  end

end
