package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class SpecialRoomEffectMessageEventParser implements IMessageParser
   {
      
      private var var_2200:int = -1;
      
      public function SpecialRoomEffectMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2200 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2200 = param1.readInteger();
         return true;
      }
      
      public function get effectId() : int
      {
         return var_2200;
      }
   }
}

