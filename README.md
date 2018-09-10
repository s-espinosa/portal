# Portal

This is a work in progress.

## Setup

This project uses [Omniauth Census](https://github.com/turingschool-projects/omniauth-census).

### Dev Environment

In order to run this application in your Dev environment, you will first need an invitation to Turing's Census app in staging. Contact Sal to request an invitation.

Once you have received your invitation and successfully logged in, you will need to register a new application. Use "http://localhost:3000/auth/census/callback" as your callback URL, and then copy the Application Id, and Secret that Census provides you.

You will need to set `CENSUS_CLIENT_ID`, `CENSUS_SECRET_ID`, and `CENSUS_BASE_URL` before you run the application locally. We have used [Figaro](https://github.com/laserlemon/figaro) to set these variables, and that gem is included in the Gemfile.

A sample `application.yml` file has been included in this repository in `config/sample_application.yml`. Copy that file into a new `appliaction.yml` file and enter your credentials into the dev environment.

### Production Environment

The steps to set up the Production environment are the same as those described above for dev, except that the invitation needs to be to Turing's Census application. Contact Sal if you believe you need this functionality.

## Roadmap

For a list of current issues, please see the [Waffle board](https://waffle.io/s-espinosa/portal).

