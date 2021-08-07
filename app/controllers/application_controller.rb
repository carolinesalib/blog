class ApplicationController < ActionController::Base
  private

  def set_site_prefix
    @title_prefix = "#{params["controller"].capitalize} | "
  end
end
