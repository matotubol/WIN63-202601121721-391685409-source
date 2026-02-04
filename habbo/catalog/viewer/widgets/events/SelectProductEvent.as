package com.sulake.habbo.catalog.viewer.widgets.events
{
   import com.sulake.habbo.catalog.class_1793;
   import flash.events.Event;
   
   public class SelectProductEvent extends Event
   {
      
      private var _offer:class_1793;
      
      public function SelectProductEvent(param1:class_1793, param2:Boolean = false, param3:Boolean = false)
      {
         super("SELECT_PRODUCT",param2,param3);
         _offer = param1;
      }
      
      public function get offer() : class_1793
      {
         return _offer;
      }
   }
}

