package com.sulake.habbo.ui.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetPresentDataUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const UPDATE_PACKAGEINFO:String = "RWPDUE_PACKAGEINFO";
      
      public static const const_119:String = "RWPDUE_CONTENTS";
      
      public static const const_375:String = "RWPDUE_CONTENTS_CLUB";
      
      public static const const_1245:String = "RWPDUE_CONTENTS_FLOOR";
      
      public static const UPDATE_CONTENTS_LANDSCAPE:String = "RWPDUE_CONTENTS_LANDSCAPE";
      
      public static const UPDATE_CONTENTS_WALLPAPER:String = "RWPDUE_CONTENTS_WALLPAPER";
      
      public static const UPDATE_CONTENTS_IMAGE:String = "RWPDUE_CONTENTS_IMAGE";
      
      private var var_315:int = -1;
      
      private var var_1015:int = 0;
      
      private var var_757:String = "";
      
      private var _text:String;
      
      private var var_55:Boolean;
      
      private var var_4075:BitmapData;
      
      private var _purchaserName:String;
      
      private var var_3886:String;
      
      private var var_195:int = -1;
      
      private var var_982:String = "";
      
      private var _placedInRoom:Boolean;
      
      private var var_2271:Boolean;
      
      public function RoomWidgetPresentDataUpdateEvent(param1:String, param2:int, param3:String, param4:Boolean = false, param5:BitmapData = null, param6:String = null, param7:String = null, param8:Boolean = false, param9:Boolean = false, param10:* = false)
      {
         super(param1,param8,param9);
         var_315 = param2;
         _text = param3;
         var_55 = param4;
         var_4075 = param5;
         _purchaserName = param6;
         var_3886 = param7;
         var_2271 = param10;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get classId() : int
      {
         return var_1015;
      }
      
      public function set classId(param1:int) : void
      {
         var_1015 = param1;
      }
      
      public function get itemType() : String
      {
         return var_757;
      }
      
      public function set itemType(param1:String) : void
      {
         var_757 = param1;
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
      
      public function get purchaserName() : String
      {
         return _purchaserName;
      }
      
      public function get purchaserFigure() : String
      {
         return var_3886;
      }
      
      public function get placedItemId() : int
      {
         return var_195;
      }
      
      public function set placedItemId(param1:int) : void
      {
         var_195 = param1;
      }
      
      public function get placedInRoom() : Boolean
      {
         return _placedInRoom;
      }
      
      public function set placedInRoom(param1:Boolean) : void
      {
         _placedInRoom = param1;
      }
      
      public function get placedItemType() : String
      {
         return var_982;
      }
      
      public function set placedItemType(param1:String) : void
      {
         var_982 = param1;
      }
      
      public function get trustedSender() : Boolean
      {
         return var_2271;
      }
   }
}

