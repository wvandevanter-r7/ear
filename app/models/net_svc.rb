class NetSvc < ActiveRecord::Base
  belongs_to   :host
  has_many     :web_apps

  after_save   :log

  include ModelHelper

private
  def log
    EarLogger.instance.log self.to_s
  end

end
