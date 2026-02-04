package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3720 implements IMessageParser
   {
      
      public static var var_5257:int = 0;
      
      public static var name_6:int = 1;
      
      public static var var_5391:int = 2;
      
      private var var_2968:int;
      
      public function class_3720()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2968 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2968 = param1.readShort();
         return true;
      }
      
      public function get mintResult() : int
      {
         return var_2968;
      }
   }
}

