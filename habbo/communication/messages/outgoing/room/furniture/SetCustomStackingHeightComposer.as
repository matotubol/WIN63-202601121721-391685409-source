package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetCustomStackingHeightComposer implements IMessageComposer
   {
      
      private var var_24:Array;
      
      public function SetCustomStackingHeightComposer(param1:Array)
      {
         super();
         var_24 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
      
      public function dispose() : void
      {
         var_24 = null;
      }
   }
}

