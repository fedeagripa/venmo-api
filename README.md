# Venmo example

## How to use

1. Clone this repo
2. Install PostgreSQL in case you don't have it
3. Create your `database.yml` and `application.yml` file
4. `bundle install`
5. Generate a secret key with `rake secret` and paste this value into the `application.yml`.
6. `rake db:create`
7. `rake db:migrate`
8. `rspec` and make sure all tests pass
9. `rails s`
10. You can now try your REST services!


## Optional configuration

- Set your [frontend URL](https://github.com/cyu/rack-cors#origin) in `config/initializers/rack_cors.rb`
- Set your mail sender in `config/initializers/devise.rb`
- Config your timezone accordingly in `application.rb`.


## Code quality

With `rake code_analysis` you can run the code analysis tool, you can omit rules with:

- [Rubocop](https://github.com/bbatsov/rubocop/blob/master/config/default.yml) Edit `.rubocop.yml`
- [Reek](https://github.com/troessner/reek#configuration-file) Edit `config.reek`
- [Rails Best Practices](https://github.com/flyerhzm/rails_best_practices#custom-configuration) Edit `config/rails_best_practices.yml`
- [Brakeman](https://github.com/presidentbeef/brakeman) Run `brakeman -I` to generate `config/brakeman.ignore`
- [Bullet](https://github.com/flyerhzm/bullet#whitelist) You can add exceptions to a bullet initializer or in the controller
