Rails.application.routes.draw do
  # TODO put the controllers into a version module namespace instead of this hack for the path
  scope '/api/v1/' do
    resources :time_entries
    resources :timecards
  end
end
