package com.sulake.habbo.communication.messages.outgoing.room
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ClickCharacterComposer implements IMessageComposer
   {
      
      private var var_4416:int;
      
      public function ClickCharacterComposer(param1:int)
      {
         super();
         var_4416 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_4416];
      }
   }
}

