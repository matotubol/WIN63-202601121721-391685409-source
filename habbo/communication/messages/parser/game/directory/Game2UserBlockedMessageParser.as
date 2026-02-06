package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class Game2UserBlockedMessageParser implements IMessageParser
   {
      
      private var var_3212:int;
      
      public function Game2UserBlockedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3212 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3212 = param1.readInteger();
         return true;
      }
      
      public function get playerBlockLength() : int
      {
         return var_3212;
      }
   }
}

