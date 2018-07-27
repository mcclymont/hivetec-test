class RootController < ApplicationController
  def redirect
    redirect_to imports_url
  end
end
