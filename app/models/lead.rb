class Lead < ActiveRecord::Base
  has_and_belongs_to_many :users
  def self.without_users
    where(<<-SQL)
      NOT EXISTS (SELECT 1 
        FROM   leads_users 
        WHERE  leads.id = leads_users.lead_id) 
    SQL
  end

  def self.not_connected_to(user)
    where(<<-SQL, user.id)
      NOT EXISTS (SELECT 1 
        FROM   leads_users 
        WHERE  leads.id = leads_users.lead_id
        AND leads_users.user_id <> ?
        ) 
    SQL
  end

  def self.without_users
    habtm_table = Arel::Table.new(:leads_users)
    join_table_with_condition = habtm_table.project(habtm_table[:lead_id])
    where(Lead.arel_table[:id].not_in(join_table_with_condition))
  end
end
