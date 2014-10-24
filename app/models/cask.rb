class Cask < ActiveRecord::Base
  Sections = {
    "California" => "CALIFORNIA (#1-40)",
    "UK" => "UNITED KINGDOM (#41-62)",
    "BC" => "BRITISH COLUMBIA (#63-91)",
    "Alberta" => "ALBERTA (#92-108)",
    "Maritimes" => "MARITIMES (#109-125)",
    "Quebec" => "QUEBEC (#126-171)",
    "Ontario" => "ONTARIO (#172-280)",
    "IPA Challenge" => "IPA CHALLENGE (#281-314)",
    "Cider " => "CIDER (#315-336)",
  }

  default_scope { order('cask') }

  paginates_per 50
end
