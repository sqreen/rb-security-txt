# Security.txt toolbox for your Ruby app

This gem provides a Rack middleware and matching Rails engine
that will provides a nicely formatted [security.txt](https://tools.ietf.org/html/draft-foudil-securitytxt-02) for your application.
It also includes a generator and parser of security.txt files.

References:
* [security.txt rfc draft](https://tools.ietf.org/html/draft-foudil-securitytxt-02)
* [security.txt project on github](https://github.com/securitytxt/security-txt)
* [securitytxt.org](https://securitytxt.org/)


## Installation
Add this line to your application's Gemfile:
```ruby
  gem 'securitytxt'
```

And then execute:
```bash
$ bundle
```

## Using the Rails engine
Create an initializer with the policy you want to set:
```ruby
# config/initializers/securitytxt.rb
SecurityTxt.contact = "me@organization.com"
SecurityTxt.encryption = "https://www.mykey.com/pgp-key.txt"
```

## Using the Rack middleware
Add the middleware to your chain in your config.ru

```ruby
require 'securitytxt'

policy = {
  "contact" => "me@organization.com",
  "encryption" => "https://www.mykey.com/pgp-key.txt"
}
use SecurityTxt::Middleware, policy
```

## Parsing a Security.txt

Simply passing a string should be enough to get data back

```ruby
require "securitytxt/parser"
require "open-uri"
SecurityTxt::Parser.new.parse(open("https://securitytxt.org/.well-known/security.txt").read)
# Outputs {"contact"=>"https://hackerone.com/ed", "encryption"=>"https://keybase.pub/edoverflow/pgp_key.asc", "acknowledgements"=>"https://hackerone.com/ed/thanks"}
```

## Generating a Security.txt

```ruby
require 'securitytxt/generator'
puts SecurityTxt::Generator.new({"contact"=>"https://hackerone.com/ed", "encryption"=>"https://keybase.pub/edoverflow/pgp_key.asc", "acknowledgements"=>"https://hackerone.com/ed/thanks"}).generate
# Outputs
#
# Contact: https://hackerone.com/ed
# Encryption: https://keybase.pub/edoverflow/pgp_key.asc
# Acknowledgements: https://hackerone.com/ed/thanks
```

## CLI usage

```
Securitytxt - A CLI tool to parse and generate securitytxt content.

Help menu:
   -p, --parse FILE | URL           Parse securitytxt file or URL
   -g, --generate                   Generate a securitytxt string.
   -c, --contact DETAILS            List of contact details separated by comma(,) without spaces. (used with -g/--generate)
   -e, --encryption URL             Link to a page which contains your key.(used with -g/--generate)
   -a, --acknowledgements URL       Link to a page where security researchers are recognized for their reports.(used with -g/--generate)
   -h, --help                       Show this help message
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
