package com.sulake.habbo.communication.messages.outgoing.room.layout
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetRoomEntryTileMessageComposer implements IMessageComposer
   {
      
      public function GetRoomEntryTileMessageComposer()
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

