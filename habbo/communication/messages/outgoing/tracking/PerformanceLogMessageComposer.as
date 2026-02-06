package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PerformanceLogMessageComposer implements IMessageComposer
   {
      
      private var var_120:Array;
      
      public function PerformanceLogMessageComposer(param1:int, param2:String, param3:String, param4:String, param5:String, param6:Boolean, param7:int, param8:int, param9:int, param10:int, param11:int)
      {
         super();
         var_120 = [param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11];
      }
      
      public function dispose() : void
      {
         var_120 = null;
      }
      
      public function getMessageArray() : Array
      {
         return var_120;
      }
   }
}

