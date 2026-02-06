package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class UpdateGuildIdentityMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function UpdateGuildIdentityMessageComposer(param1:int, param2:String, param3:String)
      {
         super();
         var_24.push(param1);
         var_24.push(param2);
         var_24.push(param3);
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
      
      public function dispose() : void
      {
         var_24 = null;
      }
   }
}

