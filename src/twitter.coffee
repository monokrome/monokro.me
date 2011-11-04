required_environment_variables = [
  process.env.TWITTER_CONSUMER_KEY,
  process.env.TWITTER_CONSUMER_SECRET,
  process.env.TWITTER_ACCESS_TOKEN_KEY,
  process.env.TWITTER_ACCESS_TOKEN_SECRET
]

for variable in required_environment_variables
  if variable is undefined
    throw 'Twitter environment variables must be provided.'

twitter = new (require 'ntwitter')
  consumer_key: process.env.TWITTER_CONSUMER_KEY
  consumer_secret: process.env.TWITTER_CONSUMER_SECRET
  access_token_key: process.env.TWITTER_ACCESS_TOKEN_KEY
  access_token_secret: process.env.TWITTER_ACCESS_TOKEN_SECRET

latest_twits = {}

allowed_users = [
  'monokrome',
  'LimpidTech'
]

keywords = [
  'monokro.me',
  'limpidtech.com'
]

streams = []

setup_domain = (domain) ->

  # Restores initial state.
  twitter.search domain, (err, data) ->
    if err
      throw err

    for result in data.results
      if result.from_user in allowed_users
        latest_twits[domain] = latest_twits[domain] || result

  # Listens for any allowed users mentioning this keyword
  streams.push twitter.stream 'statuses/filter',
    follow: '800277,217652097'
    track: domain
  , (stream) ->
    stream.on 'data', (data) ->
      if data.user.screen_name in allowed_users
        latest_twits[domain] = data

    # TODO: stream.destroy on application termination

for domain in keywords
  setup_domain domain

module.exports.latest_twits = latest_twits

