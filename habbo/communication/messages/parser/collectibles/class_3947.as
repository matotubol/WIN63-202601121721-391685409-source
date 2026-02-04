package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3947 implements IMessageParser
   {
      
      private var var_808:int;
      
      private var var_5003:int;
      
      private var var_2493:int;
      
      public function class_3947()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_808 = param1.readInteger();
         var_5003 = param1.readInteger();
         var_2493 = param1.readInteger();
         return true;
      }
      
      public function get score() : int
      {
         return var_808;
      }
      
      public function get highestScore() : int
      {
         return var_5003;
      }
      
      public function get level() : int
      {
         return var_2493;
      }
   }
}

