package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class LatencyPingReportMessageComposer implements IMessageComposer
   {
      
      private var var_4201:int;
      
      private var var_5074:int;
      
      private var var_3904:int;
      
      public function LatencyPingReportMessageComposer(param1:int, param2:int, param3:int)
      {
         super();
         var_4201 = param1;
         var_5074 = param2;
         var_3904 = param3;
      }
      
      public function getMessageArray() : Array
      {
         return [var_4201,var_5074,var_3904];
      }
      
      public function dispose() : void
      {
      }
   }
}

