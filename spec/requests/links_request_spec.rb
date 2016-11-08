require 'rails_helper'

RSpec.describe Api::V1::LinksController, type: :request do
  it 'returns JSON data when updating read status' do
    user = User.create!(email: 'hello@example.com', password: 'pass')

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).
      and_return(user)

    user.links.create!(title: 'Google', url: 'http://www.google.com')
    link = user.links.create!(
      title: 'Hi',
      url: 'http://www.hi.com',
      read: 'true'
    )

    put "/api/v1/links/#{link.id}"

    returned_json = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response.content_type).to eq('application/json')
    expect(returned_json['read']).to eq('false')
    expect(returned_json['title']).to eq(link.title)
    expect(returned_json['url']).to eq(link.url)
  end
end
