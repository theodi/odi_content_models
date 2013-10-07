govuk_formats = Artefact::FORMATS_BY_DEFAULT_OWNING_APP

Artefact::FORMATS_BY_DEFAULT_OWNING_APP = {
  'publisher' => [
    "creative_work",
    "case_study",
    "course",
    "course_instance",
    "event",
    "news",
    "node",
    "person",
    "organization",
    "article",
    "person",
    "timed_item",
    "faq",
    "job"
  ],
  'whitehall' => [] # Need to define this empty so that govuk_content_models validators still work. See their slug_validator.rb for reasons.
}

Artefact::FORMATS = Artefact::FORMATS_BY_DEFAULT_OWNING_APP.values.flatten + govuk_formats.values.flatten

class Artefact
  field "author", type: String
  
  validate :check_tags
  
  def self.category_tags
    [:person, :timed_item, :asset, :article, :organization]
  end
  
  stores_tags_for :sections, :writing_teams, :propositions,
                  :keywords, :legacy_sources, category_tags
  
  private
  
  def check_tags
    if self.class.category_tags.include? self.kind.to_sym
      errors.add(self.kind.to_sym, "tag must be specified") if self.tag_ids.empty?
    end
  end
  
end