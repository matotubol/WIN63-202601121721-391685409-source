package com.sulake.habbo.inventory.events
{
   import flash.events.Event;
   
   public class HabboInventoryFurniListParsedEvent extends Event
   {
      
      public static const const_161:String = "HFLPE_FURNI_LIST_PARSED";
      
      private var var_191:String;
      
      public function HabboInventoryFurniListParsedEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super("HFLPE_FURNI_LIST_PARSED");
         var_191 = param1;
      }
      
      public function get category() : String
      {
         return var_191;
      }
   }
}

