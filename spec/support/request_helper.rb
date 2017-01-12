module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end
    def json_err_msg
      json["errors"]["msg"]
    end
  end
end
