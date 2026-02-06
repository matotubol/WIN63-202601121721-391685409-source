package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class Game2PlayerExitedGameArenaMessageEventParser implements IMessageParser
   {
      
      private var var_1270:int;
      
      private var var_3199:int;
      
      public function Game2PlayerExitedGameArenaMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1270 = NaN;
         var_3199 = NaN;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1270 = param1.readInteger();
         var_3199 = param1.readInteger();
         return true;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get playerGameObjectId() : int
      {
         return var_3199;
      }
   }
}

