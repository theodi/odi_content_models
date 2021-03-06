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
    tag_to_rendering_path  "event:lunchtime-lecture"                => "lunchtime-lectures",
                           "event:meetup"                           => "meetups",
                           "event:research-afternoon"               => "research-afternoons",
                           "event:open-data-challenge-series"       => "challenge-series",
                           "event:roundtable"                       => "roundtables",
                           "event:workshop"                         => "workshops",
                           "event:networking-event"                 => "networking-events",
                           "event:panel-discussion"                 => "panel-discussions",
                           "event:summit"                           => "summit",
                           "event:summit-session-2016"              => "summit/2016/sessions",
                           "event:summit-training-day-session-2016" => "summit/2016/training-day/sessions",
                           :default => 'events'
  end

end
