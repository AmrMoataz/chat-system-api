# README

### This is my first ruby on rails project, created to practice and test my ruby on rails skills.
#### It uses different libraries to test different functionalities including:
* Elasticsearch
* Redis
* MysqlDB
* docker

## Ruby Version
`ruby 2.6.10p210`
## Rails Version
`Rails 5.0.7.2`

## Running Project
* Pull Project from this repository using `git clone https://github.com/AmrMoataz/chat-system-api.git`
* From project directory run `docker-compose up`
* Project will run on `http://localhost:3000/`

## Services (job queues, cache servers, search engines, etc.)
* redis service/container is created when building and running docker compose.
* elastic search server is being connected to through code.
* from **web** container cli, run `rake resque:work QUEUE=* ` to register resqeue workers
* from **web** container cli, run `rake resque:scheduler` to register resqueu schedulers
* navigate to `http://localhost:3000/jobs` to monitor all the queues, schedulers and registerd jobs

