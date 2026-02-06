package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class DanceMessageComposer implements IMessageComposer
   {
      
      private var _style:int;
      
      public function DanceMessageComposer(param1:int)
      {
         super();
         _style = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [_style];
      }
   }
}

