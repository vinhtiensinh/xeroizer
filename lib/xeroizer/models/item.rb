module Xeroizer
  module Record
    
    class ItemModel < BaseModel
        
      set_permissions :read, :write, :update
      
      def mark_dirty(resource)
        return if resource.is_a?(ItemSalesDetails) || resource.is_a?(ItemPurchaseDetails)
        super
      end
    end
    
    class Item < Base
      
      set_primary_key :item_id
      set_possible_primary_keys :item_id, :code
      
      guid    :item_id
      string  :code
      string  :code
      string  :inventory_asset_account_code
      string  :description
      string  :name
      decimal :quantity_on_hand
      boolean :is_tracked_as_inventory


      
      belongs_to :purchase_details, :model_name => 'ItemPurchaseDetails'
      belongs_to :sales_details, :model_name => 'ItemSalesDetails'
      
      validates_presence_of :code

    end
    
  end
end
