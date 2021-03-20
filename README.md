# README

**run rswag**

`rake rswag:specs:swaggerize`

**DOCKER**
###### First setup

`sudo RAILS_ENV=development docker-compose build`
<br>
`sudo RAILS_ENV=development docker-compose exec app bundle exec rake db:create db:migrate `

##### to run

`sudo RAILS_ENV=development docker-compose build`
<br>
`sudo RAILS_ENV=development docker-compose up`
<br>
In case you have migrations:
`RAILS_ENV=development sudo docker-compose exec app rake db:migrate`

##### to stop
`sudo RAILS_ENV=development docker-compose down` or `ctrl + c`