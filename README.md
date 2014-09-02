## README
**IMPORTANT** - This code is currently under heavy development and is being written/rewritten with the goal of deploying for the first time.  As such, migrations may be removed/rewritten to better organize code.  *This code should be considered **ALPHA** quality with no guarantee of stability.*

### Development
#### Database
1. `rake db:drop`
2. `rake db:create`
3. `rake db:migrate`
4. `rake db:seed` (development ONLY)

**db/seeds.rb** is for development database seeding ONLY!! For production data seeding, place them in an appropriate migration.  **No Database changes (addition/updates/deletion) are to be done on production via rails console unless absolutely necessary.**


### TODO

* Write Controller Specs
* Add support for HTTP Methods other than GET in `/users/api/scraps_controller.rb`
* Add Support to Add/Remove HTTP Headers from `/users/scraps#show > headers`
* `Background save` editor theme to user on selection
* Write ROADMAP.md
* Add more stuff to README
