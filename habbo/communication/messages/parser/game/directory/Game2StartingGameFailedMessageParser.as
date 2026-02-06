package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class Game2StartingGameFailedMessageParser implements IMessageParser
   {
      
      public static const const_1202:int = 1;
      
      public static const const_593:int = 2;
      
      private var var_2352:int;
      
      public function Game2StartingGameFailedMessageParser()
      {
         super();
      }
      
      public function get reason() : int
      {
         return var_2352;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2352 = param1.readInteger();
         return true;
      }
   }
}

