package com.sulake.habbo.communication.messages.parser.game.score
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class class_4032 implements IMessageParser
   {
      
      private var var_2912:int;
      
      private var var_2631:Array = [];
      
      public function class_4032()
      {
         super();
      }
      
      public function get gameTypeId() : int
      {
         return var_2912;
      }
      
      public function get winners() : Array
      {
         return var_2631;
      }
      
      public function flush() : Boolean
      {
         var_2912 = -1;
         var_2631 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2912 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2631.push(new class_4072(param1));
            _loc3_++;
         }
         return true;
      }
   }
}

