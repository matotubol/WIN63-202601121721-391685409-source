package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class Game2EnterArenaFailedMessageEventParser implements IMessageParser
   {
      
      public static const const_683:int = 1;
      
      public static const const_961:int = 2;
      
      public static const const_473:int = 3;
      
      public static const const_969:int = 4;
      
      private var var_2352:int;
      
      public function Game2EnterArenaFailedMessageEventParser()
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

