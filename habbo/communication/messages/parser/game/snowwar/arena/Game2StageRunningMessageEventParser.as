package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class Game2StageRunningMessageEventParser implements IMessageParser
   {
      
      private var var_2807:int;
      
      public function Game2StageRunningMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_2807 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2807 = param1.readInteger();
         return true;
      }
      
      public function get timeToStageEnd() : int
      {
         return var_2807;
      }
   }
}

