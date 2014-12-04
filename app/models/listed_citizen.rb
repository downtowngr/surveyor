class ListedCitizen < ActiveRecord::Base
  belongs_to :citizen
  belongs_to :list
end
