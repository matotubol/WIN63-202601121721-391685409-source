package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3550 implements class_2565
   {
      
      private var var_1270:int;
      
      private var _userName:String;
      
      public function class_3550(param1:IMessageDataWrapper)
      {
         super();
         var_1270 = param1.readInteger();
         _userName = param1.readString();
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

