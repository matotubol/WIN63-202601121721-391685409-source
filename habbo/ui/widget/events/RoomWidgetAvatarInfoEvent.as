package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetAvatarInfoEvent extends RoomWidgetUpdateEvent
   {
      
      public static const AVATAR_INFO:String = "RWAIE_AVATAR_INFO";
      
      private var var_1270:int;
      
      private var _userName:String;
      
      private var var_3359:int;
      
      private var var_3322:Boolean;
      
      private var var_3915:int;
      
      public function RoomWidgetAvatarInfoEvent(param1:int, param2:String, param3:int, param4:int, param5:Boolean, param6:Boolean = false, param7:Boolean = false)
      {
         super("RWAIE_AVATAR_INFO",param6,param7);
         var_1270 = param1;
         _userName = param2;
         var_3359 = param3;
         var_3915 = param4;
         var_3322 = param5;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get userType() : int
      {
         return var_3359;
      }
      
      public function get roomIndex() : int
      {
         return var_3915;
      }
      
      public function get allowNameChange() : Boolean
      {
         return var_3322;
      }
   }
}

