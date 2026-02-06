package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SignMessageComposer implements IMessageComposer
   {
      
      private var var_5017:int;
      
      public function SignMessageComposer(param1:int)
      {
         super();
         var_5017 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_5017];
      }
      
      public function dispose() : void
      {
      }
   }
}

