# Grace Hrabi

[![Build Status](https://travis-ci.org/kmcphillips/gracehrabi.com.png)](https://travis-ci.org/kmcphillips/gracehrabi.com)


## About

Personal home page for [Grace Hrabi](http://gracehrabi.com). It is written with Rails 4, haml, and jQuery. It provides a full CMS back end using Active Admin, including RMagick image upload, transformation, and thumbnailing.

[http://gracehrabi.com](http://gracehrabi.com)


## Quick Setup

With an OS X or Linux machine with ruby and bundler installed, you should be able to go from 0 to running in under three minutes.


### For the impatient

    $ git clone git://github.com/kmcphillips/gracehrabi.com.git
    $ cd gracehrabi.com
    $ bundle install
    $ cp config/database.yml.example config/database.yml
    $ rake db:create
    $ rake db:migrate
    $ rake db:populate
    $ rails server

Point your browser to [http://localhost:3000/](http://localhost:3000/) and you should be set to go.


## Feedback

Contact me at [github@kevinmcphillips.ca](mailto:github@kevinmcphillips.ca) with questions or feedback.

