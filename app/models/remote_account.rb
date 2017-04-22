# frozen_string_literal: true

class RemoteAccount < ApplicationRecord
  belongs_to :user, inverse_of: :remote_accounts
  belongs_to :account, inverse_of: :remote_accounts
  validates_uniqueness_of :account_id, scope: [:user_id]
end
