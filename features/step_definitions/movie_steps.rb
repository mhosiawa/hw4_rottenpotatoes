# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    #if !Movie.find(movie)
    Movie.create!(movie)
    #end
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.

  end
  #flunk "Unimplemented"
end

Then /director of "(.*)" should be "(.*)"/ do |e1,e2|
  page.body.should =~/#{e2}/m
end



