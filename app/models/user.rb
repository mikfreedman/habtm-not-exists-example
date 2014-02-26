class User < ActiveRecord::Base
  has_and_belongs_to_many :leads
  def self.without_leads_not_exists
    where(<<-SQL)
      NOT EXISTS (SELECT 1 
        FROM   leads_users 
        WHERE  users.id = leads_users.user_id) 
    SQL
  end

  def self.without_leads_arel_not_in
    habtm_table = Arel::Table.new(:leads_users)
    join_table_with_condition = habtm_table.project(habtm_table[:user_id])
    where(User.arel_table[:id].not_in(join_table_with_condition))
  end
end
