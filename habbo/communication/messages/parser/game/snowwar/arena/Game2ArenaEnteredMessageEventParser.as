package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2PlayerData;
   
   [SecureSWF(rename="true")]
   public class Game2ArenaEnteredMessageEventParser implements IMessageParser
   {
      
      private var var_201:Game2PlayerData;
      
      public function Game2ArenaEnteredMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(var_201)
         {
            var_201.dispose();
            var_201 = null;
         }
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_201 = new Game2PlayerData();
         var_201.parse(param1);
         return true;
      }
      
      public function get player() : Game2PlayerData
      {
         return var_201;
      }
   }
}

