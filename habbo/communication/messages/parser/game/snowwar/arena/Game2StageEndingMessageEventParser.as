package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class Game2StageEndingMessageEventParser implements IMessageParser
   {
      
      private var var_3209:int;
      
      public function Game2StageEndingMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3209 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3209 = param1.readInteger();
         return true;
      }
      
      public function get timeToNextState() : int
      {
         return var_3209;
      }
   }
}

