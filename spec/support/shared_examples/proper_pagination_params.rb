shared_examples 'proper pagination params' do
  it 'responds with page' do
    expect(response_body(response)['page'].length).to be pagination_params[:page]
  end

  it 'responds with count' do
    expect(response_body(response)['count']).to be pagination_params[:count]
  end

  it 'responds with total_count' do
    expect(response_body(response)['total_count']).to be pagination_params[:total_count]
  end

  it 'responds with total_pages' do
    expect(response_body(response)['total_pages']).to be pagination_params[:total_pages]
  end

  it 'responds with previous_page' do
    expect(response_body(response)['previous_page']).to be pagination_params[:previous_page]
  end

  it 'responds with current_page' do
    expect(response_body(response)['current_page']).to be pagination_params[:current_page]
  end

  it 'responds with next_page' do
    expect(response_body(response)['next_page']).to be pagination_params[:next_page]
  end

  get_page_from_uri = lambda { |uri|
    uri ? Rack::Utils.parse_query(URI.parse(uri).query)['page'].to_i : nil
  }

  it 'responds with previous_page_url' do
    uri = response_body(response)['previous_page_url']
    page = get_page_from_uri.call(uri)
    expect(page).to be pagination_params[:previous_page]
  end

  it 'responds with next_page_url' do
    uri = response_body(response)['next_page_url']
    page = get_page_from_uri.call(uri)
    expect(page).to be pagination_params[:next_page]
  end
end
