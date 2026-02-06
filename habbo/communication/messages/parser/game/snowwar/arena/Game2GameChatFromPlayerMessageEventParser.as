package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class Game2GameChatFromPlayerMessageEventParser implements IMessageParser
   {
      
      private var var_1270:int;
      
      private var var_3125:String;
      
      public function Game2GameChatFromPlayerMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1270 = -1;
         var_3125 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1270 = param1.readInteger();
         var_3125 = param1.readString();
         return true;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get chatMessage() : String
      {
         return var_3125;
      }
   }
}

