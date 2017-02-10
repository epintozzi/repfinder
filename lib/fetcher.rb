require 'pry'
require 'bunny'
require 'json'

class Fetcher

  def initialize
    @connection = Bunny.new
    bunny_connection
  end

  def bunny_connection
    @connection.start
    @channel = @connection.create_channel
    @queue_send = @channel.queue("rep.info")
    json_hash = rep_hash.to_json
    @queue_send.publish(json_hash)
  end

  def rep_hash
    {
     id: '123',
     first: 'Bob',
     last: 'Smith',
     congress: {
       rep_1: {
         title: 'Sen',
         first: 'Betty',
         last: 'White',
         party: 'A',
         phone: '123-456-7890',
       },
       rep_2: {
         title: 'Sen',
         first: 'Tom',
         last: 'Hanks',
         party: 'A',
         phone: '123-456-7890',
       }
     }
   }
  end
end

p = Fetcher.new
