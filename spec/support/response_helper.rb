module Response
  module JSONParser
    def response_body(response)
      JSON.parse(response.body)
    end
  end
end
