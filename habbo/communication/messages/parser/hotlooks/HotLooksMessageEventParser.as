package com.sulake.habbo.communication.messages.parser.hotlooks
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.hotlooks.class_3684;
   
   [SecureSWF(rename="true")]
   public class HotLooksMessageEventParser implements IMessageParser
   {
      
      private var var_880:Array;
      
      public function HotLooksMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_880 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var_880.push(new class_3684(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get hotLooks() : Array
      {
         return var_880;
      }
   }
}

