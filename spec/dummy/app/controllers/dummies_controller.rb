class DummiesController < ApplicationController
  protect_from_forgery with: :exception
  include Wor::Paginate

  def index
    render_paginated DummyModel
  end
end
