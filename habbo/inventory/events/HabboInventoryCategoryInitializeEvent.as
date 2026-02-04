package com.sulake.habbo.inventory.events
{
   import flash.events.Event;
   
   public class HabboInventoryCategoryInitializeEvent extends Event
   {
      
      public static const HABBO_INVENTORY_CATEGORY_INITIALIZED:String = "HABBO_INVENTORY_CATEGORY_INITIALIZED";
      
      private var var_191:String;
      
      public function HabboInventoryCategoryInitializeEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super("HABBO_INVENTORY_CATEGORY_INITIALIZED",param2,param3);
         var_191 = param1;
      }
      
      public function get category() : String
      {
         return var_191;
      }
   }
}

