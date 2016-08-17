module Campaign::Validator

  @freq = ["monthly", "quarterly", "yearly"]

  def validate_response body
    parsed = body.split(",").map(&:strip)
    if parsed[0].match(/^[+]?([0-9]+(?:[\.][0-9]*)?|\.[0-9]+)$/)
      @freq.include?(parsed[1].downcase) ? [parsed[0], parsed[1].downcase] : [parsed[0]]
    else
      false
    end
  end

end
