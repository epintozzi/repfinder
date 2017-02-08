require 'pry'
require 'bunny'
require 'json'

class Printer
  attr_reader :rep_data

  def initialize#(rep_data)
    @rep_data = rep_data
    @connection = Bunny.new
  end

  def bunny_connection
    @connection.start
    @channel = @connection.create_channel
    @queue_receive = @channel.queue("rep.info")
  end

  def subscription
    bunny_connection
    @queue_receive.subscribe do |delivery_info, metadata, payload|
      # binding.pry
    puts message = JSON.parse(payload)
    end
  end

  def filename
    id = @rep_data[:id].rjust(5, "0")
    last = @rep_data[:last].downcase
    first= @rep_data[:first].downcase
    return "#{id}_#{last}_#{first}.txt"
  end

  def write_file
    file_name = filename
    target = open(file_name, 'w')
    header = "=== #{@rep_data[:first]} #{@rep_data[:last]} ==="
    target.write(header)
    target.write("\n")

    @congress_info = @rep_data[:congress]
    @congress_info.each do |line|
      info = "#{line[1][:title]} #{line[1][:first]} #{line[1][:last]} (#{line[1][:party]}): #{line[1][:phone]}"
      target.write(info)
      target.write("\n")
    end
  end

  # loop do
  # end
end

p = Printer.new
binding.pry
p.subscription

# hash = {
#   id: '123',
#   first: 'Jeff',
#   last: 'Casimir',
#   congress: {
#     rep_1: {
#       title: 'Sen',
#       first: 'Betty',
#       last: 'White',
#       party: 'A',
#       phone: '123-456-7890',
#     },
#     rep_2: {
#       title: 'Sen',
#       first: 'Tom',
#       last: 'Hanks',
#       party: 'A',
#       phone: '123-456-7890',
#     }
#   }
# }
#
# p = Printer.new(hash)
# p.write_file

# Desired Format
# === Jeff Casimir ===
# Sen Cory Gardner (R): 202-224-5941
# Rep Diana DeGette (D): 202-225-4431
# Rep Mike Coffman (R): 202-225-7882
# Sen Michael Bennet (D): 202-224-5852
