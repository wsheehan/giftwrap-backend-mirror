module GiftsHelper
  def gift_response_html id
    "<form action='#{ENV['host']}donors/update/#{id.to_s}' method='POST' id='update-form'>"  \
      "<h2>Thank You For Your Generous Gift</h2>"                         \
      "We Would Love a little more information about you!"                \
      "<input type='text' name='donor[affiliation]' />"                   \
      "<input type='text' name='donor[class_year]' />"                    \
      "<input type='submit' name='commit' value='Update Information' />"  \
    "</form>"
  end
end
