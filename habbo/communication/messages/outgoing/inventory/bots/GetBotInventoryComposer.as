package com.sulake.habbo.communication.messages.outgoing.inventory.bots
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetBotInventoryComposer implements IMessageComposer
   {
      
      public function GetBotInventoryComposer()
      {
         super();
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

