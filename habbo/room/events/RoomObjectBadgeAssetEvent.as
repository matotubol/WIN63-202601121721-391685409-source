package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.object.IRoomObject;
   
   public class RoomObjectBadgeAssetEvent extends RoomObjectEvent
   {
      
      public static const LOAD_BADGE:String = "ROGBE_LOAD_BADGE";
      
      private var var_605:String;
      
      private var var_4319:Boolean;
      
      public function RoomObjectBadgeAssetEvent(param1:String, param2:IRoomObject, param3:String, param4:Boolean = true, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param2,param5,param6);
         var_605 = param3;
         var_4319 = param4;
      }
      
      public function get badgeId() : String
      {
         return var_605;
      }
      
      public function get groupBadge() : Boolean
      {
         return var_4319;
      }
   }
}

