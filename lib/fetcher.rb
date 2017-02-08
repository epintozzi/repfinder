require 'pry'
require 'bunny'
require 'json'

class Fetcher

  def initialize
    @connection = Bunny.new
  end

  def bunny_connection
    @connection.start
    @channel = @connection.create_channel
    @queue_send = @channel.queue("rep.info")
    # binding.pry
    json_hash = rep_hash.to_json
    @queue_send.publish(json_hash)
  end

  def rep_hash
    return hash = {
     id: '123',
     first: 'Jeff',
     last: 'Casimir',
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


  # loop do
  #
  # end
end

p = Fetcher.new
p.bunny_connection
