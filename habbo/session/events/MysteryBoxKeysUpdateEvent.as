package com.sulake.habbo.session.events
{
   import flash.events.Event;
   
   public class MysteryBoxKeysUpdateEvent extends Event
   {
      
      public static const MYSTERY_BOX_KEYS_UPDATE:String = "mbke_update";
      
      private var _boxColor:String;
      
      private var _keyColor:String;
      
      public function MysteryBoxKeysUpdateEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super("mbke_update",param3,param4);
         _boxColor = param1;
         _keyColor = param2;
      }
      
      public function get boxColor() : String
      {
         return _boxColor;
      }
      
      public function get keyColor() : String
      {
         return _keyColor;
      }
   }
}

