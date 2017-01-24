# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #fail "Unimplemented"
  assert page.body =~ /#{e1}.*#{e2}/m, "#{e1} was not before #{e2}"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(", ").each do |rating|
    uncheck ? uncheck("ratings[#{rating}]") : check("ratings[#{rating}]")
  end
end

Then /^I should see movies with the following ratings: (.*)/ do |ratings|
  ratings.split(", ").each do |rating|
    expect(page).to have_content(rating)  
  end
end

Then /I should see all the movies/ do
  totalMovies = Movie.all.length
  page.should have_selector('table tbody tr', :count => totalMovies)
end
