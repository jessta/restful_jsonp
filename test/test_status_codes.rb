require 'test/unit'
require 'ostruct'
require 'lib/restful_jsonp/status_codes.rb'

class TestStatusCodes < Test::Unit::TestCase
  def setup
    @sc = RestfulJSONP::StatusCodes.new(nil)
  end

  def test_compatible_status_200
    assert_equal(true, @sc.compatible_status?(100))
  end

  def test_compatible_status_204
    assert_equal(false, @sc.compatible_status?(204))
  end

  def test_compatible_status_301
    assert_equal(true, @sc.compatible_status?(301))
  end

  def test_compatible_status_400
    assert_equal(false, @sc.compatible_status?(400))
  end

  def test_compatible_status_500
    assert_equal(false, @sc.compatible_status?(500))
  end

  def test_enabled_route_no_match
    @sc.instance_variable_set("@routes", ['^hello'])
    @sc.instance_variable_set("@req", OpenStruct.new({:path => 'goodbye'}))

    assert_equal(false, @sc.enabled_route?)
  end

  def test_enabled_route_match
    @sc.instance_variable_set("@routes", ['^kitties'])
    @sc.instance_variable_set("@req", OpenStruct.new({:path => 'kitties'}))

    assert_equal(true, @sc.enabled_route?)
  end
end