package com.sulake.habbo.communication.messages.outgoing.room.layout
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetOccupiedTilesMessageComposer implements IMessageComposer
   {
      
      public function GetOccupiedTilesMessageComposer()
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

