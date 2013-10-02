require "factory_girl"
require "answer_edition"
require "artefact"
require "tag"
require "user"
require "govuk_content_models/test_helpers/factories"

FactoryGirl.define do
  
  factory :case_study_edition, parent: :edition, :class => 'CaseStudyEdition' do
  end
  
  factory :faq_edition, parent: :edition, :class => 'FaqEdition' do
  end
  
  factory :creative_work_edition, parent: :edition, :class => 'CreativeWorkEdition' do
  end
  
  factory :course_edition, parent: :edition, :class => 'CourseEdition' do
  end
  
  factory :course_instance_edition, parent: :edition, :class => 'CourseInstanceEdition' do
  end
  
  factory :job_edition, parent: :edition, :class => 'JobEdition' do
  end
  
  factory :person_edition, parent: :edition, :class => 'PersonEdition' do
  end

  factory :timed_item_edition, parent: :edition, :class => 'TimedItemEdition' do
  end

  factory :article_edition, parent: :edition, :class => 'ArticleEdition' do
  end
  
  factory :organization_edition, parent: :edition, :class => 'OrganizationEdition' do
  end
  
end