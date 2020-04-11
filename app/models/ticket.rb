class Ticket < ApplicationRecord
  belongs_to :order
  belongs_to :ticket_type

  # TODO: complete the folowing
  # before_xxxxx :update_stats
  after_destroy :update_destroy
  before_create :update_stats

  private
    def update_stats
      es = self.ticket_type.event.event_stat
      ev = self.ticket_type.event.event_venue
      # TODO: complete in order to update event stats
      unless es.tickets_sold >= ev.capacity
        es.attendance=es.attendance+1
        es.tickets_sold=es.tickets_sold+1
        es.save!
      else
        raise "Capacity full, Ticket can't be created."
      end
    end

    def update_destroy
      es = self.ticket_type.event.event_stat
      es.attendance=es.attendance-1
      es.tickets_sold=es.tickets_sold-1
      es.save!
    end
end
