class Commoditylive
  require 'rest-client'
  require 'json'
  require 'time'


  $live_uri = 'http://127.0.0.1:3000/api/v1'#'https://commodity.live/api/v1'
  $live_usertoken = '36pJHrwJI47PexW5srEXzFnTNKgxnDh71cb3FQY-dgcrN' #Rails.application.secrets.live_usertoken
  $live_teamtoken = '7a4c442f-ee93-45fb-9b5a-464157d2246e' #Rails.application.secrets.live_teamtoken
  $live_emailaddress = 'fredrik.holst@elmatica.com' #Rails.application.secrets.live_emailaddress

  def initialize(mode)
    if mode == 'live'
      @cl_uri = $live_uri
      @cl_usertoken = $live_usertoken
      @cl_teamtoken = $live_teamtoken
      @cl_emailaddress = $live_emailaddress
    else
      @cl_uri = $sandbox_uri
      @cl_usertoken = $sandbox_usertoken
      @cl_teamtoken = $sandbox_teamtoken
      @cl_emailaddress = $sandbox_emailaddress
    end
    @cl_headers = {'refresh-token' => @cl_usertoken, 'email-address' => @cl_emailaddress, 'Team' => @cl_teamtoken, 'Content-Type' => 'application/json', 'X-Key-Inflection' => 'dash'}
    @cl_token_expire = Time.now.to_i
    authenticated = self.authenticate()
  end

  def execute(method, url, payload=nil)
    case method
    when 'get'
      RestClient.get(url, headers = @cl_headers) { |response, request, result, &block|
      case response.code
      when 200
        return true, response
      when 400
        return false, response
      else
        return false, response
      end
      }
    when 'post'
      RestClient.post(url, payload, headers = @cl_headers) { |response, request, result, &block|
      case response.code
      when 200
        return true, response
      when 400
        return false, response
      else
        return false, response
      end
      }
    end
  end

  def authenticate()
    return true, {error: false, code: 200, description: "Authenticated for another #{@cl_token_expire - Time.now.to_i} seconds" } unless @cl_token_expire < ( Time.now.to_i + 30 )
    url = @cl_uri + '/oauth/token'
    authstate, response = execute('get', url)
    @cl_headers["Authorization"] = JSON.parse(response.body)["access-token"]
    @cl_token_expire = Time.now.to_i +  JSON.parse(response.body)["expires-in"].to_i
    return authstate, response
  end

  def get_all_materials(clas_id)
    authstate, response = self.authenticate()
    return false, response unless authstate
    url = @cl_uri + '/classifications/' + clas_id
    success, response = self.execute('get', url )
    return success, response
  end

  def get_material(com_id)
    authstate, response = self.authenticate()
    return false, response unless authstate
    url = @cl_uri + '/commodities/' + com_id
    success, response = self.execute('get', url )
    return success, response
  end

  def get_brand(brand_id)
    authstate, response = self.authenticate()
    return false, response unless authstate
    url = @cl_uri + '/brands/' + brand_id
    success, response = self.execute('get', url )
    return success, response
  end
end