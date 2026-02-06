package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class Game2StartCounterMessageParser implements IMessageParser
   {
      
      private var var_4198:int;
      
      public function Game2StartCounterMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4198 = param1.readInteger();
         return true;
      }
      
      public function get countDownLength() : int
      {
         return var_4198;
      }
   }
}

