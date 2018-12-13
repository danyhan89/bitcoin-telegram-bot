# Challenge - Create a BTC Telegram Chatbot

## Run as a client

- Create a telegram account
- Create a account on block.io
- select BTC testnet from the dropdown
- copy your btc testnet wallet address
- join the chat with t.me/danybtctg_bot (or your bot name)
- Say hello (the bot will run from here)

## Run as the server (bot)

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
