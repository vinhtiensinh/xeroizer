module Xeroizer
  module Record
    class AllocationModel < BaseModel
      attr_accessor :credit_note
      attr_accessor :prepayment


      def api_controller_name
        if self.prepayment
          'Prepayments'
        elsif self.credit_note
          'CreditNotes'
        end
      end

      def url
        if self.prepayment
          "#{super}/#{self.prepayment.id}/Allocations"
        elsif self.credit_note
          "#{super}/#{credit_note.id}/Allocations"
        end
      end
    end

    class Allocation < Base
      attr_accessor :credit_note
      attr_accessor :prepayment

      set_primary_key :id

      guid    :id
      decimal :applied_amount
      belongs_to :invoice
      validates_presence_of :invoice

      def save
        if self.prepayment
          self.parent.prepayment = self.prepayment
        elsif self.credit_note
          self.parent.credit_note = self.credit_note
        end
        super
      end
    end
  end
end
