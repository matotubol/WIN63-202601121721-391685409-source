package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.quest.class_4101;
   
   [SecureSWF(rename="true")]
   public class class_3690 implements IMessageParser
   {
      
      private var var_1475:Array;
      
      public function class_3690()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1475 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var_1475.push(new class_4101(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get prizes() : Array
      {
         return var_1475;
      }
   }
}

