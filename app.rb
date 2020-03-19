require 'sinatra'
require "sinatra/reloader"
require "pry"
require_relative "person"
require_relative "model"

before do
    # request.body.rewind
    # @request_payload = JSON.parse(request.body.read)
end

get '/v1/sir_model' do
    model = Model.new(
        eons: params["eons"].to_i,
        susceptible: params["susceptible"].to_i,
        infected: params["infected"].to_i,
        resistant: params["resistant"].to_i,
        rate_si: params["rate_si"].to_f,
        rate_ir: params["rate_ir"].to_f
    )

    content_type :json
    { results: model.results }.to_json
end

post '/v1/policy_prices' do
    people = @request_payload["people"].map do |person|
        Person.new(
            gender: person["gender"].downcase,
            age: person["age"],
            name: person["name"],
            health_condition: person["health condition"].downcase
        )
    end

    policy_prices = people.map do |person|
        { name: person.name, policy_price: person.policy_price }
    end

    content_type :json
    { policy_prices: policy_prices }.to_json
end

# ?eons=5&susceptible=10&infected=0&resistant=0&rate_si=0.01&rate_ir=0.05