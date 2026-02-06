package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GamePlayerValueMessageEventParser implements IMessageParser
   {
      
      private var var_1270:int = 0;
      
      private var _value:int = 0;
      
      public function GamePlayerValueMessageEventParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1270 = param1.readInteger();
         _value = param1.readInteger();
         return true;
      }
   }
}

