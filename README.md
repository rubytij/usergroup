# RubyTij UserGroup

[![Build Status](https://secure.travis-ci.org/rubytij/usergroup.png?branch=master)](http://travis-ci.org/rubytij/usergroup)

This is Tijuana Ruby user group app.

## Getting it to work (the short version)
This assumes that you have `postgres` running and you know how to set up your OAuth secret and id.

Simply:

1. Clone it
2. Run the generations
3. Install dependecies
4. Run the migrations
5. Run the seeds
6. Run the application and enjoy!

```sh
git clone git://github.com/rubytij/usergroup.git
cd usergroup
rake config:generate
bundle install
rake db:migrate db:seed
rails s
```
You can now open your browser and go to `http://localhost:3000` to see the app Running.

You can find the **longer** and **more detailed** version of how to set up a development environment [here](https://github.com/rubytij/usergroup/wiki/Setting-up-your-development-environment).

## Running the tests

Simply run `rake` inside the app folder.

## Deployment (the short version)

The app supports multistaging deployment with `staging` and `production` pre-configured to use the defaults just tell capistrano what stage to use like this:

`cap [stage] deploy`

To deploy using staging simply `cap deploy` (`staging` is the default stage).
To deploy to production do `cap production deploy`.

The **longer** and **more detailed** version is coming soon.
