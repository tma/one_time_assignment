require File.dirname(__FILE__) + '/helper'

class Post < ActiveRecord::Base
  allow_one_time_assignment :title, :body
end

class TestOneTimeAssignment < Test::Unit::TestCase
  def setup
    setup_db
    @subject = Post.new
  end
  
  should "raise error if we assign a field twice" do
    [:title, :body].each do |attribute_name|
      @subject.send("#{attribute_name}=", "first")
      assert_equal @subject.send(attribute_name), "first"
      
      assert_raise RuntimeError do
        @subject.send("#{attribute_name}=", "second")
      end

      assert_equal @subject.send(attribute_name), "first"
    end
  end
  
  def teardown
    teardown_db
  end
end
