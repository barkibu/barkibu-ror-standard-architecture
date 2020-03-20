=begin
  Rails AR model. In hexagonal architecture or clean architecture it is
  suggested to use Repository patter and Object mapper, leaving AR as just a
  DB connectivity layer. This seems like an overkill for a small-medium sized app

  If any complex queries arise or complex buisness logic appears inside AR model,
  It can be extracted to a query object or repository
=end

class Consultation < ApplicationRecord
end
