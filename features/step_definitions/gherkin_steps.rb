Given /^there is feature titled "([^\"]*)"$/ do |title|
  @feature = Factory(:feature)
end

Given /^the feature has "([^\"]*)" of "([^\"]*)"$/ do |attribute, value|
 if attribute != "feature_title"
  scenario = Factory(:scenario,:feature_id => @feature.id,attribute=>value)
 end
end
