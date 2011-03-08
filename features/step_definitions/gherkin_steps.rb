Given /^there is feature titled "([^\"]*)"$/ do |title|
  Feature.make(:title => title)
end

Given /^the feature has "([^\"]*)" of "([^\"]*)"$/ do |attribute, value|
  
end
