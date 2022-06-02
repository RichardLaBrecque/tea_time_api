class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :price, :status, :frequency
    attribute :tea do |object|
      {title: object.tea.title,
      description: object.tea.description,
      temperature: object.tea.temperature,
      brew_time: object.tea.brew_time
      }
    end
end
