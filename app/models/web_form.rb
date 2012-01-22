class WebForm < ActiveRecord::Base
  belongs_to :web_app

  after_save :log

  include ModelHelper

private
  def log
    EarLogger.instance.log self.to_s
  end
end
