class DummyModelsWithoutGemsController < ApplicationController
  include Wor::Paginate

  def index
    render_paginated DummyModel
  end
end
