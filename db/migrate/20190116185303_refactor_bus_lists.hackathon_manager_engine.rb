# This migration comes from hackathon_manager_engine (originally 20190113231044)
class RefactorBusLists < ActiveRecord::Migration[5.2]
  def up
    make_new_change
    BusList.all.each do |bus_list|
      Questionnaire.joins(
        :school
      ).where(
        "schools.bus_list_id = ? AND riding_bus = 1 AND (acc_status = 'accepted' OR acc_status = 'rsvp_confirmed')", bus_list.id
      ).all.each do |q|
        q.update_attribute(:bus_list_id, bus_list.id)
      end
    end
    cleanup_old
  end

  def down
    revert { cleanup_old }
    BusList.all.each do |bus_list|
      bus_list.passengers.each do |passengers|
        passengers.update_attribute(:riding_bus, true)
      end
    end
    revert { make_new_change }
  end

  private

  def make_new_change
    add_reference :questionnaires, :bus_list, type: :integer, foreign_key: true
  end

  def cleanup_old
    remove_column :schools, :bus_list_id
  end
end
