require_relative 'test_helper'
require './lib/printer'

class PrinterTest < Minitest::Test

  def test_it_initializes
    p = Printer.new
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
    p = Printer.new
    assert_equal '00123_casimir_jeff.txt', p.filename(hash)
  end

  def test_it_takes_a_hash
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
    assert_equal hash, p.rep_data
  end

  def test_it_writes_to_a_file

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
    p = Printer.new
    assert p.write_file(hash)
  end

end
