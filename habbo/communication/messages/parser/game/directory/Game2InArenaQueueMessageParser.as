package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class Game2InArenaQueueMessageParser implements IMessageParser
   {
      
      private var var_2134:int;
      
      public function Game2InArenaQueueMessageParser()
      {
         super();
      }
      
      public function get position() : int
      {
         return var_2134;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2134 = param1.readInteger();
         return true;
      }
   }
}

