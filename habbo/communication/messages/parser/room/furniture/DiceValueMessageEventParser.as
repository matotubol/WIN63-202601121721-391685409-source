package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class DiceValueMessageEventParser implements IMessageParser
   {
      
      private var var_197:int;
      
      private var _value:int;
      
      public function DiceValueMessageEventParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function flush() : Boolean
      {
         var_197 = -1;
         _value = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_197 = param1.readInteger();
         _value = param1.readInteger();
         return true;
      }
   }
}

