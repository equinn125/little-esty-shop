# Little Esty Shop
![Screen Shot 2021-09-22 at 3 35 38 PM](https://user-images.githubusercontent.com/83930724/134426313-23d19857-c6e9-44da-b368-d66ea26c7ce9.png)

## Overview

"Little Esty Shop" is a 10 day group project where Turing Backend Engineering studtends are tasked with building a fully funcitonal e-commerce application using rails. This project requires students to work colaboratively on a project incorperating multiple database relationships in the process.

Little Esty Shop allowed us to practice creating migrations to handle one to many, as well as many to many database relationships. We have used Ruby on rails to build our app with CRUD functionality. This rails app utilizes both class and variable methods in order to best work with the data provided. This Applicaiton has been developed using Test Driven Development which has allowed up to ensure we are testing all features, and models as they are being created allowing for high test coverage globally.

## Tools Utilized
- Ruby 
- Rails
- Heroku
- HTML
- Gems: Faraday, Rspec, SimpleCov, Capybara

## Setup
 To use this application please follow the following steps below:
1. Ruby Version
` ❯ ruby -v
   ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-darwin20] `
2. Rails Version
  `❯ rails -v
     Rails 5.2.6`
3. Database set up
`rails db:{drop,create,migrate}`
4. Load CSV files
`rake csv_load:all`
5. Local deployment please put the following command within your terminal 
`rails s`
6. Then navigate to:
`localhost:3000`
7. Alternatively the heroku deployment can be found [here](https://little-esty-shop987.herokuapp.com/admin/merchants)

## Features
- Github API to show coninous real time metrics for contribution, pull requrests, and total commits
- Merchant and Admin Dashboards


## Contributors

- [Kelsey Thompson](https://github.com/knthompson2)
- [Ryan Teske](https://github.com/Rteske)
- [Erin Quinn](https://github.com/equinn125?tab=repositories)
- [Luis Arroyo](https://github.com/dat1guyluigi)
