# YourWeb.Expert

[![Build Status](https://travis-ci.org/darryl-snow/yourweb.expert.svg?branch=master)](https://travis-ci.org/darryl-snow/yourweb.expert)

This is the repo for the personal site of Darryl Snow ([https://yourwebsite.expert](https://yourwebsite.expert)). It's built using the following technologies:

* Jade
* Stylus (with automatically generated styleguide at /styles)
* CoffeeScript
* Gulp
* Unit testing with Karma & Jasmine
* NodeJS with ExpressJS

During development, a server is run on port 8080 with livereload. The processing of source files is handled by gulp and gulp plugins. The server-side code runs on port 8000 and provides an API used by the front end. Once the front-end is finished, it can be packaged for production and then served just using the server-side code.

## Prerequisites

* NodeJS / NPM
* Gulp

```
npm install -g gulp
```

## Development instructions

* npm run start:dev		(run the back-end API server then run the dev server for the front-end )
* npm run build			(compile front-end code for production)
* npm start				(run the server)
* npm run test:fe		(run front-end tests)
* npm run test:be		(run back-end tests)
* npm test				(run both front-end and back-end tests)

### Gulp tasks

* gulp                  (development build)
* gulp accessibility    (check against WCAG2 guidelines)
* gulp dev              (build and run dev server at localhost:8080)
* gulp pagespeed        (test against Google pagespeed)
* gulp prod             (production build)
* gulp reset            (rm /public)
* gulp serve			(run the server for the API)
* gulp test             (run unit tests)

**Development URL**: [http://localhost:8080](http://localhost:8080)
**API URL**: [http://localhost:8000/api/2.0.0/](http://localhost:8000/api/2.0.0/)

## TODO

* Lint coffeescript