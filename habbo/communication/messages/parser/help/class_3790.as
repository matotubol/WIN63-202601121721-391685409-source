package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3790 implements IMessageParser
   {
      
      public static const const_588:int = 0;
      
      public static const const_996:int = 1;
      
      public static const const_230:int = 2;
      
      public static const const_827:int = 3;
      
      public static const const_373:int = 4;
      
      private var var_2759:int;
      
      public function class_3790()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2759 = param1.readInteger();
         return true;
      }
      
      public function get errorCode() : int
      {
         return var_2759;
      }
   }
}

