module Plugins
  # The Plugins::Import module will be filled in with functionality by the 
  # different import plugins installed in this dradis instance. The 
  # ImportController will expose this functionality through an standarised
  # interface.
  module Import
  end
end

# The ImportContoller will be the centralised point from which all the 
# functionality exposed by plugins is made available to the user.
class ImportController < ApplicationController
  include Plugins::Import
  before_filter :login_required

  def list
    respond_to do |format|
      format.html{ redirect_to '/' }
      format.json{
        list = []
        Plugins::Import.included_modules.each do |plugin|
          list << {:name => plugin.name }
        end
        render :json => list
      }
    end
  end
end
