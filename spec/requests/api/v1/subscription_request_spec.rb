require 'rails_helper'

RSpec.describe 'subscriptions requests' do
  describe 'post requests' do
    it 'can add a customer to a tea subscription' do
      user = Customer.create!(first_name: "user_1", last_name: "user_last", email: "someemail@email.com", address: "123 fake st, place, state")
      tea = Tea.create!(title: "earl grey", description: "some tastey tea", temperature: 212.5, brew_time: 15, price: 22)
      data = {  'customer': user.id,
              'tea': tea.id,
              'subscription': {title: 'trytea', frequency: 1}
            }
            headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json'}
      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(data)
    end
  end
end
