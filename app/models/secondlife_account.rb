# frozen_string_literal: true

class SecondlifeAccount < ApplicationRecord
  has_secure_token
  belongs_to :user, inverse_of: :secondlife_accounts
  has_many :secondlife_scripts, inverse_of: :secondlife_account
end
