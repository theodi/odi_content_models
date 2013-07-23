govuk_formats = Artefact::FORMATS_BY_DEFAULT_OWNING_APP

Artefact::FORMATS_BY_DEFAULT_OWNING_APP = {
  'publisher' => [
    "course",
    "news",
    "person"
  ],
  'whitehall' => [] # Need to define this empty so that govuk_content_models validators still work. See their slug_validator.rb for reasons.
}

Artefact::FORMATS = Artefact::FORMATS_BY_DEFAULT_OWNING_APP.values.flatten + govuk_formats.values.flatten