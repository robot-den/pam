ThinkingSphinx::Index.define :article, :with => :active_record do
  # fields
  indexes header
  indexes announce
  indexes body
  indexes user(:name), :as => :author

  # attributes
  has updated_at, approved
end