package com.sulake.habbo.ui.widget.messages
{
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   
   public class RoomWidgetInventoryUpdatedMessage extends RoomWidgetUpdateEvent
   {
      
      public static const INVENTORY_UPDATED:String = "RWIUM_INVENTORY_UPDATED";
      
      public function RoomWidgetInventoryUpdatedMessage(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

