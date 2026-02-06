package com.sulake.habbo.communication.messages.outgoing.handshake
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class class_1840 implements IMessageComposer
   {
      
      private var _username:String;
      
      private var var_2861:String;
      
      private var var_1270:int;
      
      public function class_1840(param1:String, param2:String, param3:int)
      {
         super();
         _username = param1;
         var_2861 = param2;
         var_1270 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [];
      }
   }
}

