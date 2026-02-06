package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PresentOpenMessageComposer implements IMessageComposer
   {
      
      private var var_315:int;
      
      public function PresentOpenMessageComposer(param1:int)
      {
         super();
         var_315 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_315];
      }
   }
}

