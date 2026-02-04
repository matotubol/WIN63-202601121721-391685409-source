package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import package_62.class_2098;
   
   [SecureSWF(rename="true")]
   public class class_3566 implements IMessageParser
   {
      
      private var var_1446:Array;
      
      public function class_3566()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1446 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var_1446.push(new class_2098(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get quests() : Array
      {
         return var_1446;
      }
   }
}

