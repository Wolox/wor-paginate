module Response
  module JSONParser
    def response_body(response = self.response)
      JSON.parse(response.body)
    end
  end
end
