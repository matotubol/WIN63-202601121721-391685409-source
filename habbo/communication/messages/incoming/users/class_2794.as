package com.sulake.habbo.communication.messages.incoming.users
{
   [SecureSWF(rename="true")]
   public class class_2794
   {
      
      private var var_1951:int;
      
      private var _roomName:String;
      
      private var var_4419:Boolean = false;
      
      public function class_2794(param1:int, param2:String, param3:Boolean)
      {
         super();
         var_1951 = param1;
         _roomName = param2;
         var_4419 = param3;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function get hasControllers() : Boolean
      {
         return var_4419;
      }
   }
}

