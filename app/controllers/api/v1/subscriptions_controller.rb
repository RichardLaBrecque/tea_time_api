class Api::V1::SubscriptionsController < ApplicationController
  def create
    tea = Tea.find(params[:tea])
    if Subscription.create(customer_id: params[:customer],
                                              tea_id: params[:tea],
                                              price: tea.price,
                                              title: params[:subscription][:title],
                                              frequency: params[:subscription][:frequency])
        render status: 201
    else
      render response: :bad_request
    end
  end
end
