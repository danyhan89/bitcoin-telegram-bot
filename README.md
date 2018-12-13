# Challenge - Create a BTC Telegram Chatbot

## Run as a client

- Create a telegram account
- Create a account on block.io
- select BTC testnet from the dropdown
- copy your btc testnet wallet address
- join the chat with t.me/danybtctg_bot (or your bot name)
- Say hello (the bot will run from here)
- give bot your testnet wallet address
- send 3 chats to receive testnet coins

- use below wallet info for client
  - https://block.io
  - username: blockclientwallet1234@gmail.com
  - password: blockclientwallet1234
  - btc testnet wallet address: 2MsgmUBvy4tNTuLo65mNxQhvdubJwCUvgxZ

## Run as the server (bot)

ruby-2.3.7

- Create a telegram account
- Create a new bot by chatting with the BotFather
- Save the token in an .env file under TELEGRAM_BOT_TOKEN
- Create an account on block.io
- Create a wallet under BTC testnet (block.io)
- Use a BTC testnet faucet to fund the bot wallet
  (http://bitcoinfaucet.uo1.net/send.php)
- Create an API key at block.io
- save the API key in .env under BLOCKIO_API_KEY
- Save the account secret pin in the .env under BLOCKIO_API_PIN
- Start the server (ruby app.rb)
- Start bot in chat by joining the bot with the link given by the Botfather

##RUN as the server (bot) with pre-existing .env keys & testnet wallet account

- copy paste this in your .env file

  - TELEGRAM_BOT_TOKEN=787218721:AAE0SE0qpLIjERq8Mv_c00X6Gn1oERA22Ew
  - BLOCKIO_API_KEY=950b-24ec-5b91-30cd
  - BLOCKIO_API_PIN=blockbankserver1234

- use below wallet info for server
  - https://block.io
  - username: blockbankserver1234@gmail.com
  - password: blockbankserver1234
  - btc testnet wallet address: 2Mwc74eLGgWiPaeNuuEkkggEx4K7cQPGVCu
