class WebApp < ActiveRecord::Base
  belongs_to :net_svc
  has_many :web_forms

  after_save :log
  
  include ModelHelper
  
private
  def log
    EarLogger.instance.log self.to_s
  end
end
