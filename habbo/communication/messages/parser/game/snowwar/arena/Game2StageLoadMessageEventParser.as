package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class Game2StageLoadMessageEventParser implements IMessageParser
   {
      
      private var var_1787:int;
      
      public function Game2StageLoadMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1787 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1787 = param1.readInteger();
         return true;
      }
      
      public function get gameType() : int
      {
         return var_1787;
      }
   }
}

