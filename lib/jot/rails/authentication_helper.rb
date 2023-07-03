class Jot
  module Rails
    module AuthenticationHelper
      def jot_decode(request)
        token = request.headers["Authorization"].split(" ").last
        payload, header = Jot.decode(token)
        payload
      end
    end
  end
end
