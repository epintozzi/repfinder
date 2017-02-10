require 'pry'
require 'bunny'
require 'json'

class Printer
  attr_reader :queue_receive

  def initialize
    @connection = Bunny.new
    bunny_connection
    subscription
  end

  def bunny_connection
    @connection.start
    @channel = @connection.create_channel
    @queue_receive = @channel.queue("rep.info")
  end

  def subscription
    @queue_receive.subscribe do |delivery_info, metadata, payload|
      puts "Got #{payload}"
      message = JSON.parse(payload)
      puts message
      write_file(message)
    end
  end

  def filename(message)
    id = message["id"].rjust(5, "0")
    last = message["last"].downcase
    first = message["first"].downcase
    return "#{id}_#{last}_#{first}.txt"
  end

  def write_file(message)
    file_name = filename(message)
    target = open(file_name, 'w')
    header = "=== #{message["first"]} #{message["last"]} ==="
    target.write(header)
    target.write("\n")

    @congress_info = message["congress"]
    @congress_info.each do |line|
      info = "#{line[1]["title"]} #{line[1]["first"]} #{line[1]["last"]} (#{line[1]["party"]}): #{line[1]["phone"]}"
      target.write(info)
      target.write("\n")
    end
    target.close
  end
end

# hash = {
#   id: '26',
#   first: 'Erin',
#   last: 'Pintozzi',
#   congress: {
#     rep: {
#       title: 'Sen',
#       first: 'Betty',
#       last: 'White',
#       party: 'A',
#       phone: '123-456-7890',
#     }
#   }
# }

p = Printer.new
loop do
  sleep 0.1
end
# p.write_file(hash)
