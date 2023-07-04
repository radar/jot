class Jot
  NoAuthorizationHeaderError = Class.new(StandardError)

  module Rails
    module AuthenticationHelper
      def jot_decode(request)
        if request.headers["Authorization"].nil?
          raise NoAuthorizationHeaderError, "no Authorization header detected. Cannot decode token."
        end

        token = request.headers["Authorization"].split(" ").last
        payload, header = Jot.decode(token)
        payload
      end
    end
  end
end
