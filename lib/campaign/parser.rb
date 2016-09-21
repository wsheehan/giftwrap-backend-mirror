module Campaign::Parser

  def retrieve_campaign_id link
    CGI.parse(URI.parse(link).query)["c"].first.to_i
  end

end