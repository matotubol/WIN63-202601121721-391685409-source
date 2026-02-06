package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class CancelEventMessageComposer implements IMessageComposer
   {
      
      private var var_120:Array = [];
      
      public function CancelEventMessageComposer(param1:int)
      {
         super();
         var_120.push(param1);
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return var_120;
      }
   }
}

