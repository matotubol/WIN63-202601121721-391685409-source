package com.sulake.habbo.communication.messages.parser.game.snowwar.ingame
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.FullGameStatusData;
   
   [SecureSWF(rename="true")]
   public class Game2FullGameStatusMessageEventParser implements IMessageParser
   {
      
      private var var_4106:FullGameStatusData;
      
      public function Game2FullGameStatusMessageEventParser()
      {
         super();
      }
      
      public function get fullStatus() : FullGameStatusData
      {
         return var_4106;
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4106 = new FullGameStatusData(param1);
         return true;
      }
   }
}

