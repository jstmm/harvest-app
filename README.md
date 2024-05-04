# Harvest App

App to create time entries in bulk in Harvest

## Installation

```bash
$ sudo apt install postgresql postgresql-contrib libpq-dev
$ sudo -u postgres createuser -s harvest_app -P
> secretpw
$ gem install pg
$ bin/setup
```

## Roadmap

Features
- [ ] Reset button
- [x] Error messages
- [x] Add validations
  - [x] Start date strictly before end date
  - [x] Start time strictly before end time
- [x] List added time entries
- [ ] Check if any entry already exists on a given day
- [ ] Remove all entries after a date or between two dates

Log in
- [x] Add sign in with Harvest account
- [x] Store user information in session for easy sign-in

Integrations
- [ ] Investigate if Timetastic API can be used to check time entries against holidays
- [ ] Investifate if Google API can be used to import monthly YouTube Premium invoices

