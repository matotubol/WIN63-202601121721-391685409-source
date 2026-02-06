package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class LtdRaffleEnteredMessageEventParser implements IMessageParser
   {
      
      private var _className:String;
      
      public function LtdRaffleEnteredMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _className = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _className = param1.readString();
         return true;
      }
      
      public function get className() : String
      {
         return _className;
      }
   }
}

