# TCRMP Data Entry Web Form

[Enter Data](https://tcrmpdataentry.herokuapp.com)

This repository contains the code behind the web entry form for data entry for the University of the Virgin Islands' Territorial Coral Reef Monitoring Program (TCRMP). For more information about the program, [click here](https://tcrmpdataentry.herokuapp.com/about).

This site does require a login and is only available to scientific divers collecting TCRMP data.

## Some specifications

* Ruby version: 2.7.4

* Rails version: 6.0.4

* Database: PostgreSQL

* How to run the test suite:
```
$ rspec
```

## Current features

* A user account is required to access the site, with the exception of the home and about pages.

* A user with admin privileges can add, edit, and delete users, and export a csv of their attributes.

* A user with admin privileges can add, edit, and delete boatlog managers.

* A user with manager privileges can add, edit, and delete boatlogs with nested surveys, which are used as metadata and QA/QC for surveys. 

* A user with manager privileges can view field progress by site.

* Any user can enter fish transect and rover data, and view and edit previously entered data.

* Any user can export their own entered data for proofing purposes.

## In-progress features

* A user with manager privileges can export all data from all users.

## Upcoming features

* Any user can enter coral health and algae height data, and view and edit previously entered data.
