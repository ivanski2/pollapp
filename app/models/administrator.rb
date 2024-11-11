class Administrator < ApplicationRecord
  self.table_name = "admins"
  has_secure_password
end
