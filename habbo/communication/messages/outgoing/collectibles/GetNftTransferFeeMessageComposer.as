package com.sulake.habbo.communication.messages.outgoing.collectibles
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetNftTransferFeeMessageComposer implements IMessageComposer
   {
      
      public function GetNftTransferFeeMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return [];
      }
      
      public function dispose() : void
      {
      }
   }
}

