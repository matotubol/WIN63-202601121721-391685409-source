package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class LagWarningReportMessageComposer implements IMessageComposer
   {
      
      private var var_1971:int;
      
      public function LagWarningReportMessageComposer(param1:int)
      {
         super();
         var_1971 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_1971];
      }
      
      public function dispose() : void
      {
      }
   }
}

