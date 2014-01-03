# Legislative
[![Build Status](https://travis-ci.org/ciudadanointeligente/legislative.png?branch=master)](https://travis-ci.org/ciudadanointeligente/legislative)
[![Coverage Status](https://coveralls.io/repos/ciudadanointeligente/legislative/badge.png)](https://coveralls.io/r/ciudadanointeligente/legislative)

[Trunk](http://beta.congresodechile.cl)

Legislative is a channel of participation and seeks to bring information to the public what is happening to our Congress. Built using POPLUS environment.

## Quick start

Clone the git repo - `git clone https://github.com/ciudadanointeligente/legislative.git` - or [download it](https://github.com/ciudadanointeligente/legislative/zipball/master)

Go to your legislative folder and run install
<pre>
sh setup.sh
</pre>

Then run your server
<pre>
rails s
</pre>

Check at [http://localhost:3000](http://localhost:3000)

You can try loggin in with `admin@ciudadanointeligente.org / benito`

## Features

##### [HTML5 Boilerplate](https://github.com/h5bp/html5-boilerplate/)

##### [Twitter Bootstrap 3](http://twitter.github.com/bootstrap/index.html)

##### [HAML Template Engine](http://haml.info/)

##### [Ruby on Rails 4.0.0](http://rubyonrails.org/)
* Security Authentication system
* Remember me
* Users CRUD


### Databases support

* SQLite (Default)


### Best practices
---
Change the cookie secret token at
`config/initializers/secret_token.rb`
<pre>
# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Legislative::Application.config.secret_token = 'YOUR-NEW-TOKEN-HERE'
</pre>

To run the RSpec tests
<pre>
rspec
</pre>


#### Todo
---

* You can found this in the [Issues page](https://github.com/ciudadanointeligente/legislative/issues).

## License

### Major components:

* jQuery: MIT/GPL license
* Modernizr: MIT/BSD license
* Normalize.css: Public Domain
* Twitter bootstrap: [Apache License, Version 2.0 (the "License")](http://www.apache.org/licenses/LICENSE-2.0)
* Ruby on Rails: MIT license
* RailStrap scripts: Public Domain

## Does Legislative have a mascot?

Yes.

[![Benito](http://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-ash3/1098148_10151780926822943_1641758220_n.jpg "Legislative's mascot: Benito")](https://www.google.com/search?site=&tbm=isch&source=hp&biw=1263&bih=630&q=perros+adorables+de+chile)


## Thanks you!

Legislative is made possible by the continued contributions and insights from kind-hearted developers everywhere. Just to name a few:

* [@rezzo](https://github.com/rezzo)
* [@maugsbur](https://github.com/maugsbur)
* [@jdgarrido](https://github.com/jdgarrido)
* [@pdaire](https://github.com/pdaire)
* [@lfalvarez](https://github.com/lfalvarez)
* [@camargozzini](https://github.com/camargozzini)
* [@kathemalis](https://github.com/kathemalis)


This project is licensed under the GNU Affero General Public License (AGPL). For more information you can access to the [digital license edition here](http://www.gnu.org/licenses/agpl-3.0.html).

### Everything else:

For more information about us, our site [Fundación Ciudadano Inteligente](http://www.ciudadanointeligente.org/).
And if you want help with patches, report bugs or replicate our project check [our repositories](https://github.com/ciudadanointeligente/).
