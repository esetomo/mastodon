# frozen_string_literal: true

class SecondlifeScript < ApplicationRecord
  belongs_to :secondlife_account, inverse_of: :secondlife_scripts
end
