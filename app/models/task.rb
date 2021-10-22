class Task < ApplicationRecord
  belongs_to :project

  STATUS_OPTION = [
    ["No Staterd", "no-started"],
    ["In Progress", "in-progress"],
    ["Completed", "completed"],
  ]
end
