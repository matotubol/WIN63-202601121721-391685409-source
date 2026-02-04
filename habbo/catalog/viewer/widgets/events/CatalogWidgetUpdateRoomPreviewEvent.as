package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetUpdateRoomPreviewEvent extends Event
   {
      
      private var var_2865:String = "default";
      
      private var var_2808:String = "default";
      
      private var var_2981:String = "1.1";
      
      private var var_4311:int = 64;
      
      public function CatalogWidgetUpdateRoomPreviewEvent(param1:String, param2:String, param3:String, param4:int, param5:Boolean = false, param6:Boolean = false)
      {
         super("UPDATE_ROOM_PREVIEW",param5,param6);
         var_2808 = param1;
         var_2865 = param2;
         var_2981 = param3;
         var_4311 = param4;
      }
      
      public function get wallType() : String
      {
         return var_2865;
      }
      
      public function get floorType() : String
      {
         return var_2808;
      }
      
      public function get landscapeType() : String
      {
         return var_2981;
      }
      
      public function get tileSize() : int
      {
         return var_4311;
      }
   }
}

