require "factory_girl"
require "answer_edition"
require "artefact"
require "tag"
require "user"

FactoryGirl.define do
  
  factory :user do
    sequence(:uid) { |n| "uid-#{n}"}
    sequence(:name) { |n| "Joe Bloggs #{n}" }
    sequence(:email) { |n| "joe#{n}@bloggs.com" }
    if defined?(GDS::SSO::Config)
      # Grant permission to signin to the app using the gem
      permissions { ["signin"] }
    end
  end
  
  factory :artefact do
    sequence(:name) { |n| "Artefact #{n}" }
    sequence(:slug) { |n| "slug-#{n}" }
    kind            Artefact::FORMATS.first
    owning_app      'publisher'
  end
  
  factory :edition, class: AnswerEdition do
    panopticon_id {
        a = create(:artefact)
        a.id
      }

    sequence(:slug) { |n| "slug-#{n}" }
    sequence(:title) { |n| "A key answer to your question #{n}" }

    section "test:subsection test"

    association :assigned_to, factory: :user
  end
  
  factory :course_edition, parent: :edition, :class => 'CourseEdition' do
  end
  
  factory :person_edition, parent: :edition, :class => 'PersonEdition' do
  end

  factory :timed_item_edition, parent: :edition, :class => 'TimedItemEdition' do
  end

  factory :news_edition, parent: :edition, :class => 'NewsEdition' do
  end
  
end