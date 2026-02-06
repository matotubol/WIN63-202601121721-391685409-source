package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ChangeEmailComposer implements IMessageComposer
   {
      
      private var var_4520:String;
      
      public function ChangeEmailComposer(param1:String)
      {
         super();
         var_4520 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_4520];
      }
   }
}

