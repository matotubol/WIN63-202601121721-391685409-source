package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ScrGetKickbackInfoMessageComposer implements IMessageComposer
   {
      
      public function ScrGetKickbackInfoMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return null;
      }
      
      public function dispose() : void
      {
      }
   }
}

