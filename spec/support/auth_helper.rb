module AuthHelper
  def get_with_token(path, params={}, headers={}, user)
    headers.merge!('Authorization' => get_access_token(user))
    get path, params, headers
  end

  def post_with_token(path, params={}, headers={}, user)
    headers.merge!('Authorization' => get_access_token(user))
    post path, params, headers
  end

  def get_access_token(user)
    params = {
      "authentication": {
        "username": user.email,
        "password": "foobar"
      }
    }
    post '/users/authentication', params
    res = JSON.parse(response.body)
    "Bearer " + res["token"]
  end
end
