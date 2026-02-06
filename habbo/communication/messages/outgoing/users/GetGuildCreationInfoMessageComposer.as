package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetGuildCreationInfoMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function GetGuildCreationInfoMessageComposer()
      {
         super();
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

