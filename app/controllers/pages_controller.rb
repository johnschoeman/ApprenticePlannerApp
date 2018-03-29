class PagesController < ApplicationController
  include HighVoltage::StaticPage
  before_action :require_login
end
