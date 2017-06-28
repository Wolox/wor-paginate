class AuthenticationController < ApplicationController
  include Wor::Authentication::SessionsController
  skip_before_action :authenticate_request, only: [:create]
end
