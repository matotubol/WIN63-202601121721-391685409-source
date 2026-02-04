package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetSettingsUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_1137:String = "RWSUE_SETTINGS";
      
      private var _uiVolume:Number;
      
      private var _furniVolume:Number;
      
      private var _traxVolume:Number;
      
      public function RoomWidgetSettingsUpdateEvent(param1:String, param2:Number, param3:Number, param4:Number, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         _uiVolume = param4;
         _furniVolume = param3;
         _traxVolume = param2;
      }
      
      public function get uiVolume() : Number
      {
         return _uiVolume;
      }
      
      public function get furniVolume() : Number
      {
         return _furniVolume;
      }
      
      public function get traxVolume() : Number
      {
         return _traxVolume;
      }
   }
}

