class User < ActiveRecord::Base
  has_and_belongs_to_many :leads
  def self.without_leads
    where(<<-SQL)
      NOT EXISTS (SELECT 1 
        FROM   leads_users 
        WHERE  users.id = leads_users.user_id) 
    SQL
  end
end
