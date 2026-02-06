package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CallForHelpPendingCallsMessageEventParser implements IMessageParser
   {
      
      private var var_1345:Array = [];
      
      public function CallForHelpPendingCallsMessageEventParser()
      {
         super();
      }
      
      public function get callArray() : Array
      {
         return var_1345;
      }
      
      public function get callCount() : int
      {
         return var_1345.length;
      }
      
      public function flush() : Boolean
      {
         var_1345 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1345 = [];
         var _loc3_:int = param1.readInteger();
         while(0 < _loc3_)
         {
            var _loc2_:Object = {};
            null.callId = param1.readString();
            null.timeStamp = param1.readString();
            null.message = param1.readString();
            var_1345.push(null);
            _loc4_++;
         }
         return true;
      }
   }
}

