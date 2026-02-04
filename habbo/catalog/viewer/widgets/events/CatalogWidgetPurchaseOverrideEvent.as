package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetPurchaseOverrideEvent extends Event
   {
      
      private var _callback:Function;
      
      public function CatalogWidgetPurchaseOverrideEvent(param1:Function, param2:Boolean = false, param3:Boolean = false)
      {
         super("PURCHASE_OVERRIDE",param2,param3);
         _callback = param1;
      }
      
      public function get callback() : Function
      {
         return _callback;
      }
   }
}

