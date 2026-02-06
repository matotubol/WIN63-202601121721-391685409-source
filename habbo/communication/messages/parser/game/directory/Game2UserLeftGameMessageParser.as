package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class Game2UserLeftGameMessageParser implements IMessageParser
   {
      
      private var var_1270:int;
      
      public function Game2UserLeftGameMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1270 = param1.readInteger();
         return true;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
   }
}

