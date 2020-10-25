# shrt

A url shortener

## Requirements
You must have any recent version of Crystal lang

A MongoDB instance with a database and collection named `shrt`

libmongoc-dev libmongoc-1.0-0 libmongoclient-dev for [kimvex/mongodb-crystal](https://github.com/kimvex/mongodb-crystal)
+ If on Debian based system `$ sudo apt install libmongoc-dev libmongoc-1.0-0 libmongoclient-dev`


## Installation

```
$ git clone https://github.com/Domterion/shrt.git
$ cd shrt
$ shards install 
```

You will have to edit the `config.cr.example`, change the mongo uri to your instance with a collection and db called `shrt`. Change the name to `config.cr` 

```
$ shards build && ./bin/shrt
```


## Contributors

- [domterion](https://github.com/domterion) - creator and maintainer
