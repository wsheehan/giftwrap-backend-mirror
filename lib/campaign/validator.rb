module Campaign::Validator

  def validate_response body
    parsed = body.split(",").map(&:strip)
    if parsed[0].match(/^[+]?([0-9]+(?:[\.][0-9]*)?|\.[0-9]+)$/)
      ["monthly", "quarterly", "yearly"].include?(parsed[1].try(:downcase)) ? [parsed[0], parsed[1].downcase] : [parsed[0]]
    else
      false
    end
  end

end
