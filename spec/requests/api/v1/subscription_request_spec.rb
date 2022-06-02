require 'rails_helper'

RSpec.describe 'subscriptions requests' do
  describe 'post requests' do
    it 'can add a customer to a tea subscription' do
      user = Customer.create!(first_name: "user_1", last_name: "user_last", email: "someemail@email.com", address: "123 fake st, place, state")
      tea = Tea.create!(title: "earl grey", description: "some tastey tea", temperature: 212.5, brew_time: 15, price: 22)
      data = {
              'tea': tea.id,
              'subscription': {title: 'trytea', frequency: 1}
            }
            headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json'}
      post "/api/v1/customers/#{user.id}/subscriptions", headers: headers, params: JSON.generate(data)
      expect(response).to be_successful
    end
  end

  describe 'get requests' do
    it 'can get all a users subscriptions' do
      user = Customer.create!(first_name: "user_1", last_name: "user_last", email: "someemail@email.com", address: "123 fake st, place, state")
      tea_1 = Tea.create!(title: "earl grey", description: "some tastey tea", temperature: 212.5, brew_time: 15, price: 22)
      tea_2 = Tea.create!(title: "earl grey", description: "some tastey tea", temperature: 212.5, brew_time: 15, price: 22)
      Subscription.create(customer_id: user.id,
                                                tea_id: tea_1.id,
                                                price: tea_1.price,
                                                title: "trial 1",
                                                frequency: 1)
      Subscription.create(customer_id: user.id,
                          tea_id: tea_2.id,
                          price: tea_2.price,
                          title: "A second trial of tea",
                          frequency: 0)
      get "/api/v1/customers/#{user.id}/subscriptions"
      subs = JSON.parse(response.body, symbolize_names: true)
      expect(subs).to be_a Hash
      expect(subs).to have_key(:data)
      expect(subs[:data]).to be_a Array
      expect(subs[:data].count).to eq(2)
       subs[:data].each do |sub|
         expect(sub).to be_a Hash
         expect(sub).to have_key(:id)
         expect(sub).to have_key(:type)
         expect(sub).to have_key(:attributes)
         expect(sub[:attributes]).to have_key(:title)
         expect(sub[:attributes]).to have_key(:price)
         expect(sub[:attributes]).to have_key(:status)
         expect(sub[:attributes]).to have_key(:frequency)
         expect(sub[:attributes]).to have_key(:tea)
         expect(sub[:attributes][:tea]).to have_key(:title)
         expect(sub[:attributes][:tea]).to have_key(:description)
         expect(sub[:attributes][:tea]).to have_key(:temperature)
         expect(sub[:attributes][:tea]).to have_key(:brew_time)
       end
    end
  end

  describe 'patch requests' do
    it 'can cancel a subscription' do
      user = Customer.create!(first_name: "user_1", last_name: "user_last", email: "someemail@email.com", address: "123 fake st, place, state")
      tea_1 = Tea.create!(title: "earl grey", description: "some tastey tea", temperature: 212.5, brew_time: 15, price: 22)
      tea_2 = Tea.create!(title: "earl grey", description: "some tastey tea", temperature: 212.5, brew_time: 15, price: 22)
      sub_1 = Subscription.create(customer_id: user.id,
                                                tea_id: tea_1.id,
                                                price: tea_1.price,
                                                title: "trial 1",
                                                frequency: 1)
      sub_2 = Subscription.create(customer_id: user.id,
                          tea_id: tea_2.id,
                          price: tea_2.price,
                          title: "A second trial of tea",
                          frequency: 0)
      data = {'subscription': sub_1.id, status_change: "cancel"}
      headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json'}
      put "/api/v1/customers/#{user.id}/subscriptions", headers: headers, params: JSON.generate(data)
      subs = JSON.parse(response.body, symbolize_names: true)
      expect(subs).to be_a Hash
      expect(subs).to have_key(:data)
      expect(subs[:data]).to be_a Hash
      expect(subs[:data]).to have_key(:id)
      expect(subs[:data]).to have_key(:type)
      expect(subs[:data][:type]).to eq("subscription")
      expect(subs[:data]).to have_key(:attributes)
      expect(subs[:data][:attributes]).to have_key(:title)
      expect(subs[:data][:attributes]).to have_key(:price)
      expect(subs[:data][:attributes]).to have_key(:status)
      expect(subs[:data][:attributes]).to have_key(:frequency)
      expect(subs[:data][:attributes]).to have_key(:tea)
    end
  end
end
