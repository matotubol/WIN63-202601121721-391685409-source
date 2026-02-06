package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class LtdRaffleResultMessageEventParser implements IMessageParser
   {
      
      public static const const_1157:int = 0;
      
      public static const const_552:int = 1;
      
      public static const const_763:int = 2;
      
      public static const const_799:int = 3;
      
      private var _className:String;
      
      private var var_1587:int;
      
      public function LtdRaffleResultMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _className = null;
         var_1587 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _className = param1.readString();
         var_1587 = param1.readByte();
         return true;
      }
      
      public function get className() : String
      {
         return _className;
      }
      
      public function get resultCode() : int
      {
         return var_1587;
      }
      
      public function get hasWon() : Boolean
      {
         return var_1587 == 0;
      }
   }
}

