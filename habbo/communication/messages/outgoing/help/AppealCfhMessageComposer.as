package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class AppealCfhMessageComposer implements IMessageComposer
   {
      
      private var var_4100:int;
      
      public function AppealCfhMessageComposer(param1:int)
      {
         super();
         var_4100 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_4100];
      }
      
      public function dispose() : void
      {
      }
   }
}

