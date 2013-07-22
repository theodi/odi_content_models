require "edition"

class PersonEdition < Edition

  field :biography,      type: String
  field :twitter,        type: String
  field :email,          type: String
  field :gravatar_email, type: String

  GOVSPEAK_FIELDS = Edition::GOVSPEAK_FIELDS + [:biography]

  @fields_to_clone = [:biography, :twitter, :email, :gravatar_email]

  def whole_body
    biography
  end
end
