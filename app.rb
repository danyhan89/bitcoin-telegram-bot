require 'rubygems'
require 'bundler/setup'
require 'block_io'
require 'telegram/bot'
require 'dotenv'
require 'bitcoin'
require 'byebug'
Dotenv.load

puts ENV["BLOCKIO_API_KEY"]
BlockIo.set_options api_key: ENV["BLOCKIO_API_KEY"], pin: ENV["BLOCKIO_API_PIN"], version: 2
Bitcoin.network = :testnet

class TgBtcBot
  def initialize(api)
    @api = api
    @data = {}
  end

  def user_exists?(id)
    @data.keys.include?(id)
  end

  def create_user(id)
    @data[id] = {
      count: 0,
      address: nil,
      requesting_address: false
    }
  end

  def has_address?(id)
    @data[id] && @data[id][:address]
  end

  def request_address(message)
    id = message.chat.id
    @data[id][:requesting_address] = true
    @api.send_message(chat_id: id, text: "Hi #{message.from.first_name}! Please enter your BTC address so we can pay you!")
  end

  def requesting_address?(id)
    @data[id][:requesting_address]
  end


  def collect_and_validate_address(message)
    id = message.chat.id
    if ::Bitcoin.valid_address?(message.text)
      @data[id][:address] = message.text
      @data[id][:requesting_address] = false
      @api.send_message(chat_id: id, text: "Awesome, #{message.from.first_name}, we have saved your BTC address as #{@data[id][:address]}.")
    else
      @api.send_message(chat_id: id, text: "#{message.text} doesn't look like a valid BTC address, please enter your BTC address so we can pay you!")
    end
  end

  def bank_has_funds?(amount)
    balance = BlockIo.get_address_balance(labels: 'default')
    balance["data"]["available_balance"].to_d > amount
  end

  def send_payment(message)
    id = message.chat.id
    amount = 0.00002
    pretty = "%.8f" % amount
    if bank_has_funds?(amount)
      BlockIo.withdraw_from_labels(from_labels: 'default', to_address: @data[id][:address], amount: pretty)
      @api.send_message(chat_id: message.chat.id, text: "Congrats #{message.from.first_name}! We just sent you #{pretty} in BTC!")
    else
      @api.send_message(chat_id: message.chat.id, text: "We apologize, but our account does not have the funds to send you BTC :(")
    end
  end

  def handle_message(message)
    id = message.chat.id
    create_user(id) if !user_exists?(id)
    request_address(message) and return if !has_address?(id) && !requesting_address?(id)
    collect_and_validate_address(message) and return if !has_address?(id) && requesting_address?(id)

    @data[id][:count] = @data[id][:count].to_i+1
    send_payment(message) && @data[id][:count] = 0 if @data[id][:count] === 3

  end
end



Telegram::Bot::Client.run(ENV["TELEGRAM_BOT_TOKEN"]) do |bot|
  @bot = TgBtcBot.new(bot.api)

  bot.listen do |message|
    id = message.chat.id
    case message.text
    when '/start'
      bot.api.send_message(chat_id: id, text: "Hello, #{message.from.first_name}")
    when '/stop'
      bot.api.send_message(chat_id: id, text: "Bye, #{message.from.first_name}")
    else
      @bot.handle_message(message)
    end
  end
end