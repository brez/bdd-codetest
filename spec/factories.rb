Factory.define :feature do |f|
  f.title 'Some terse yet descriptive text of what is desired'
end

Factory.define :scenario do |s|
  s.association :feature_id, :factory => :feature
end
