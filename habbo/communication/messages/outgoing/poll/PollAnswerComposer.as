package com.sulake.habbo.communication.messages.outgoing.poll
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PollAnswerComposer implements IMessageComposer
   {
      
      private var var_24:Array;
      
      public function PollAnswerComposer(param1:int, param2:int, param3:Array)
      {
         super();
         var_24 = [param1,param2];
         var_24.push(param3.length);
         var _loc4_:int = 0;
         while(0 < param3.length)
         {
            var_24.push(String(param3[0]));
            _loc4_++;
         }
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

