package com.sulake.habbo.ui.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetEcotronBoxDataUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const UPDATE_PACKAGEINFO:String = "RWEBDUE_PACKAGEINFO";
      
      public static const const_119:String = "RWEBDUE_CONTENTS";
      
      private var var_315:int = -1;
      
      private var _text:String;
      
      private var _furniTypeName:String;
      
      private var var_55:Boolean;
      
      private var var_4075:BitmapData;
      
      public function RoomWidgetEcotronBoxDataUpdateEvent(param1:String, param2:int, param3:String, param4:String, param5:Boolean = false, param6:BitmapData = null, param7:Boolean = false, param8:Boolean = false)
      {
         super(param1,param7,param8);
         var_315 = param2;
         _text = param3;
         _furniTypeName = param4;
         var_55 = param5;
         var_4075 = param6;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get controller() : Boolean
      {
         return var_55;
      }
      
      public function get iconBitmapData() : BitmapData
      {
         return var_4075;
      }
      
      public function get furniTypeName() : String
      {
         return _furniTypeName;
      }
   }
}

