module Xeroizer
  module Record
    class AllocationModel < BaseModel
      attr_accessor :credit_note

      set_api_controller_name 'CreditNotes'

      def url
        "#{super}/#{credit_note.id}/Allocations"
      end
    end

    class Allocation < Base
      attr_accessor :credit_note
      set_primary_key :id

      guid    :id
      decimal :applied_amount
      belongs_to :invoice
      validates_presence_of :invoice

      def save
        self.parent.credit_note = self.credit_note
        super
      end
    end
  end
end
