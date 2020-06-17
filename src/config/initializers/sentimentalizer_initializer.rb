require 'sentimentalizer'

Rateemall::Application.configure do
  config.after_initialize do
    Sentimentalizer.setup
  end
end
