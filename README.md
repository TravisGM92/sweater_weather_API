# Sweater Weather

## Purpose

To demonstrate knowledge and skill in the ability to consume and build API's.

## Learning Goals

1. Expose an API that aggregates data from multiple external APIs
2. Expose an API that requires an authentication token
3. Expose an API for CRUD functionality
4. Determine completion criteria based on the needs of other developers
5. Research, select, and consume an API based on your needs as a developer
6. Research and choose appropriate HTTP codes for both happy and sad paths of an API call

## Design decisions

1. First and foremost, since this app is meant to act as an API consumption and exposure program, there is no need for any views. So you'll find that the project has no `app/views` folder.
2. Secondly, you'll see the API calls are broken up into three separate files; controllers, facades, then services.
3. Serializers had to be built (and were made with the help of gem FastJsonApi) in order to ensure response of the correct format were given


## Local Setup

1. Make sure you have the correct Ruby version installed (2.5.3). To check your Ruby version, from your command line, run `ruby -v`
  - If you do not have the correct version, follow the instructions to install 2.5.3: from the command line, run `rbenv install 2.5.3`
2. Make sure you have the correct Rails version installed (5.2.4.3). To check your Rails version, from your command line, run `rails -v`
  - If you do not have the correct Rails version, [follow these instructions to install 2.5.4.3](https://github.com/turingschool-examples/task_manager_rails/blob/master/rails_uninstall.md)
3. Fork and Clone this repo
4. Install gem packages: `bundle install`
5. Setup the database: `rails db:create`
6. You will need to sign up for an API key through [Open Weather API](https://openweathermap.org/), [Map Quest API](https://developer.mapquest.com/) and [Upsplash API](https://unsplash.com/developers). You'll need to save them in the project directory in a folder that will not be uploaded to GitHub (if you decide to work on the repo and push up to your own profile).
7. From the command line, run `bundle exec figaro install`. By running this command, rails will create an application.yml file under your config folder. Open up that file, and paste your API key in by following this format: MOVIE_API_KEY: 'your api key here'
8. Once inside the project directory, run `bundle exec rspec` and you'll see several passing tests.
9. To test out the API endpoints that I've built, you'll need to open your API testing program of choice, I use [Postman](https://www.postman.com/)
10. Once you've got an API program downloaded and open, run the following command in your terminal: `rails s`. Then put a valid endpoint into your API program and send it off. You should see the terminal running through the program, and you should get some output. For ideas of what kinds of API endpoints to test, check out the spec folders inside the project.
