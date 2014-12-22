express = require 'express'
mongoose = require 'mongoose'
morgan = require 'morgan'
bodyParser = require 'body-parser'
methodOverride = require 'method-override'

app = express()

mongoose.connect('mongodb://uname:passwd@proximus.modulusmongo.net:27017/Zyxab3eh')

app.use express.static('#{__dirname}/public')
app.use morgan('dev')
app.use bodyParser.urlencoded({'extended': 'true'})
app.use bodyParser.json()
app.use bodyParser.json({type: 'application/vnd.api+json'})
app.use methodOverride()

Todo = mongoose.model  'Todo', {text: String}

app.get '/api/todos', (req, res) ->
  Todo.find (err, todos) ->
    if err
      res.send err
    res.json todos

app.post '/api/todos', (req, res) ->
  Todo.create {
    text: req.body.text,
    done: false
  }, (err, todo) ->
    if err
      res.send err

    Todo.find (err, todos) ->
      if err
        res.send err
      res.json todos

app.delete '/api/todos/:todo_id', (req, res) ->
  Todo.remove {
    id: req.params.todo_id
  }, (err, todo) ->
    if err
      res.send err

    Todo.find (err, todos) ->
      if err
        res.send err
      res.json todos

app.get '*', (req, res) ->
  res.sendfile './public/index.html'

app.listen(8080)
console.log "listening on port 8080"