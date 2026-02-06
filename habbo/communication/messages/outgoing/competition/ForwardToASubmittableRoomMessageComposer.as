package com.sulake.habbo.communication.messages.outgoing.competition
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ForwardToASubmittableRoomMessageComposer implements IMessageComposer
   {
      
      public function ForwardToASubmittableRoomMessageComposer()
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
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

