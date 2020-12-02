# README

* Ruby Version 2.7.2

* Rails Version 6.0.3

#### System Dependencies

* Install `ruby-2.7.2`
* Install `Node.js`, `yarn` and `postgres`

#### Instructions

* Clone the git repository
* Run the commands `bundle install` and `yarn install`
* Create `database.yml` by referring to `database.example.yml` and updating the `username/password`
* Setup the database using the command `bundle exec rails db:setup`
* Run the test suite using `bundle exec rspec` to confirm if the setup is successful.
* Start the rails server using `bundle exec rails s`
* Visit `http://localhost:3000` to view the home page of the application.
* Optionally you can also run `bin/webpack-dev-server` in a separate console for hot recompiling of assets.

## ApacheBench Report

<table >
<tr ><th colspan=2 bgcolor=white>Server Software:</th><td colspan=2 bgcolor=white></td></tr>
<tr ><th colspan=2 bgcolor=white>Server Hostname:</th><td colspan=2 bgcolor=white>localhost</td></tr>
<tr ><th colspan=2 bgcolor=white>Server Port:</th><td colspan=2 bgcolor=white>3000</td></tr>
<tr ><th colspan=2 bgcolor=white>Document Path:</th><td colspan=2 bgcolor=white>/</td></tr>
<tr ><th colspan=2 bgcolor=white>Document Length:</th><td colspan=2 bgcolor=white>Variable</td></tr>
<tr ><th colspan=2 bgcolor=white>Concurrency Level:</th><td colspan=2 bgcolor=white>10</td></tr>
<tr ><th colspan=2 bgcolor=white>Time taken for tests:</th><td colspan=2 bgcolor=white>59.061 seconds</td></tr>
<tr ><th colspan=2 bgcolor=white>Complete requests:</th><td colspan=2 bgcolor=white>1000</td></tr>
<tr ><th colspan=2 bgcolor=white>Failed requests:</th><td colspan=2 bgcolor=white>0</td></tr>
<tr ><th colspan=2 bgcolor=white>Total transferred:</th><td colspan=2 bgcolor=white>3339886 bytes</td></tr>
<tr ><th colspan=2 bgcolor=white>HTML transferred:</th><td colspan=2 bgcolor=white>2478200 bytes</td></tr>
<tr ><th colspan=2 bgcolor=white>Requests per second:</th><td colspan=2 bgcolor=white>16.93</td></tr>
<tr ><th colspan=2 bgcolor=white>Transfer rate:</th><td colspan=2 bgcolor=white>55.22 kb/s received</td></tr>
<tr ><th bgcolor=white colspan=4>Connnection Times (ms)</th></tr>
<tr ><th bgcolor=white>&nbsp;</th> <th bgcolor=white>min</th>   <th bgcolor=white>avg</th>   <th bgcolor=white>max</th></tr>
<tr ><th bgcolor=white>Connect:</th><td bgcolor=white>    0</td><td bgcolor=white>    0</td><td bgcolor=white>    3</td></tr>
<tr ><th bgcolor=white>Processing:</th><td bgcolor=white>  217</td><td bgcolor=white>  586</td><td bgcolor=white> 1377</td></tr>
<tr ><th bgcolor=white>Total:</th><td bgcolor=white>  217</td><td bgcolor=white>  586</td><td bgcolor=white> 1380</td></tr>
</table>


#### Details
* Application to view commit history of github repository
* Filter results by changing the page number, owner, repo and branch/sha of commits.
* Control the number of results by passing commits per page as parameter.
* Currently the rate limit is 60 requests per hour.

#### References
Github REST API: https://docs.github.com/en/free-pro-team@latest/rest/reference/repos#list-commits

#### Future Enhancements
* Feature specs to test the UI level functionality can be added for checking the functionality using libs such as capybara, cucumber, siteprism.
* Fetched results can be stored in the database/cache to reduce number of API calls.
* Sidekiq workers and cron jobs which run at specific intervals can be used to watch the repository and update the records in the database.
* Formatted errors logging and notifying using services such as rollbar can be introduced.
* Other filters can be introduced to filter commits by author, date, etc.
