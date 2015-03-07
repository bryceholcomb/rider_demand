[ ![Codeship Status for bryceholcomb/rider_demand](https://codeship.com/projects/46f27c40-a337-0132-04a3-366d28abf18c/status?branch=master)](https://codeship.com/projects/65964)
[![Code Climate](https://codeclimate.com/github/bryceholcomb/rider_demand/badges/gpa.svg)](https://codeclimate.com/github/bryceholcomb/rider_demand)
# RiderDemand
An app that helps Uber drivers find areas of high demand and low supply in order to generate more rides.

This was an individual project while a student at the [Turing School of Software and Design](http://www.turing.io). We were tasked with picking a solution to a common problem and consuming one or more APIs as well as OAuth for authorization.

I drive occasionally for Uber, and often find myself looking at the rider app to see where other drivers are, since this data is not available to me otherwise. This allows me to place myself in underserved areas, and turns out to be a little trick that many drivers use.

I set out to make a web application that would pull in event data as well as ETAs from Uber's API to plot areas of high demand and low supply on a map for other drivers to utilize.

## Stack/Tools
- Ruby on Rails
- Uber API
- Uber OmniAuth
- Eventful API
- MapBox for my maps
- Heroku for hosting
- Codeship for continuous integration and deployment
- Bootstrap

## My Focus
- AJAX calls to populate the map with event data and ETAs

