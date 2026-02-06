package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3840
   {
      
      private var var_1951:int;
      
      private var _roomName:String;
      
      private var var_4787:int;
      
      private var var_4536:int;
      
      public function class_3840(param1:IMessageDataWrapper)
      {
         super();
         var_1951 = param1.readInteger();
         _roomName = param1.readString();
         var_4787 = param1.readInteger();
         var_4536 = param1.readInteger();
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function get enterHour() : int
      {
         return var_4787;
      }
      
      public function get enterMinute() : int
      {
         return var_4536;
      }
   }
}

