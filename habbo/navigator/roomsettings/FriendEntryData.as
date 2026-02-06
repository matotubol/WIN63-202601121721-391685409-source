package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_2565;
   
   public class FriendEntryData implements class_2565
   {
      
      private var var_1270:int;
      
      private var _userName:String;
      
      public function FriendEntryData(param1:int, param2:String)
      {
         super();
         var_1270 = param1;
         _userName = param2;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
   }
}

