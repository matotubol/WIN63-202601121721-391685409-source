package com.sulake.habbo.communication.messages.parser.game.snowwar.ingame
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameStatusData;
   
   [SecureSWF(rename="true")]
   public class Game2GameStatusMessageEventParser implements IMessageParser
   {
      
      private var _status:GameStatusData;
      
      public function Game2GameStatusMessageEventParser()
      {
         super();
      }
      
      public function get status() : GameStatusData
      {
         return _status;
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _status = new GameStatusData(param1);
         return true;
      }
   }
}

