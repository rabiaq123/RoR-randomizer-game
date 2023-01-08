class ApplicationController < ActionController::Base
    def home
        render html: "To sign up, visit the /signup endpoint."
    end
end
