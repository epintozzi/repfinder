require_relative 'test_helper'
require './lib/printer'

class PrinterTest < Minitest::Test

  def test_it_initializes
    p = Printer.new(hash)
    assert p
  end

  def test_it_creates_filename
    hash = {
      id: '123',
      first: 'Jeff',
      last: 'Casimir',
      congress: {
        rep: {
          title: 'Sen',
          first: 'Betty',
          last: 'White',
          party: 'A',
          phone: '123-456-7890',
        }
      }
    }
    p = Printer.new(hash)
    assert_equal '00123_casimir_jeff.txt', p.filename
  end

  def test_it_takes_a_hash
    hash = {
      id: '123',
      first: 'Jeff',
      last: 'Casimir',
      congress: {
        rep: {
          title: 'Sen',
          first: 'Betty',
          last: 'White',
          party: 'A',
          phone: '123-456-7890',
        }
      }
    }
    p = Printer.new(hash)
    assert_equal hash, p.rep_data
  end

  def test_it_writes_to_a_file
    skip
    hash = {
      id: '123',
      first: 'Jeff',
      last: 'Casimir',
      congress: {
        rep: {
          title: 'Sen',
          first: 'Betty',
          last: 'White',
          party: 'A',
          phone: '123-456-7890',
        }
      }
    }
    p = Printer.new(hash)
    assert
  end

end
