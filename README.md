# Security.txt for you Rails/Rack App

This gem provides a Rack middleware that will provides a nicely formatted [security.txt](https://tools.ietf.org/html/draft-foudil-securitytxt-02) for your application.

## Installation
Add this line to your application's Gemfile:
```ruby
  gem 'securitytxt'
```

And then execute:
```bash
$ bundle
```

### Rails app
Create an initializer with the policy you want to set:
```ruby
# config/initializers/securitytxt.rb
SecurityTxt.contact = "me@organization.com"
SecurityTxt.encryption = "https://www.mykey.com/pgp-key.txt"
```

### Other Rack app
Add the middleware to your chain in your config.ru
```
require 'securitytxt'

policy = {
  "contact" => "me@organization.com",
  "encryption" => "https://www.mykey.com/pgp-key.txt"
}
use SecurityTxt::Middleware, policy
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
