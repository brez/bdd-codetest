Given /^there is feature titled "([^\"]*)"$/ do |title|
  Feature.make!(:title => title)
end

Given /^the feature has "([^\"]*)" of "([^\"]*)"$/ do |attribute, value|
  pending # express the regexp above with the code you wish you had
end
