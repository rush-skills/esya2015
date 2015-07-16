class OrganizersController < ApplicationController
  # GET /organizers
  # GET /organizers.json
  def index
    @organizers = Organizer.all
    @response = "<h1>Team"
    @response +="</h1>"

    @organizers.each do |org|
      @response += '<img class="team" height="400px" src="'+org.photo.url+'">' if org.photo.present?
    end
  end
end
