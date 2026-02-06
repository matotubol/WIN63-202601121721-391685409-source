package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IssuePickFailedMessageEventParser implements IMessageParser
   {
      
      private var var_463:Array;
      
      private var var_4336:Boolean;
      
      private var var_4961:int;
      
      public function IssuePickFailedMessageEventParser()
      {
         super();
      }
      
      public function get issues() : Array
      {
         return var_463;
      }
      
      public function get retryEnabled() : Boolean
      {
         return var_4336;
      }
      
      public function get retryCount() : int
      {
         return var_4961;
      }
      
      public function flush() : Boolean
      {
         var_463 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_463 = [];
         var _loc6_:int = param1.readInteger();
         var _loc7_:int = 0;
         while(0 < _loc6_)
         {
            var _loc3_:int = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            var _loc5_:String = param1.readString();
            var _loc4_:class_3291 = new class_3291(0,0,0,0,0,0,0,0,null,0,null,0,null,null,0,[]);
            var_463.push(null);
            _loc7_++;
         }
         var_4336 = param1.readBoolean();
         var_4961 = param1.readInteger();
         return true;
      }
   }
}

