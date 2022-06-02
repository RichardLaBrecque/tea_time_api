class Api::V1::SubscriptionsController < ApplicationController
  def create
    tea = Tea.find(params[:tea])
    if Subscription.create(customer_id: params[:customer_id],
                                              tea_id: params[:tea],
                                              price: tea.price,
                                              title: params[:subscription][:title],
                                              frequency: params[:subscription][:frequency])
        render status: 201
    else
      render response: :bad_request
    end
  end

  def index
    customer = Customer.find(params[:customer_id])
    render json: SubscriptionSerializer.new(customer.subscriptions)
  end

  def update
    sub = Subscription.find(params[:subscription])
    sub.update(status: 1)
    render json: SubscriptionSerializer.new(sub)

  end
end
