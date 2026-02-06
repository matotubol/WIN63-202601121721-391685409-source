package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameObjectsData;
   
   [SecureSWF(rename="true")]
   public class Game2StageStartingMessageEventParser implements IMessageParser
   {
      
      private var var_206:GameObjectsData;
      
      private var var_1787:int;
      
      private var var_3171:String;
      
      private var var_1572:int;
      
      public function Game2StageStartingMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1787 = param1.readInteger();
         var_3171 = param1.readString();
         var_1572 = param1.readInteger();
         var_206 = new GameObjectsData(param1);
         return true;
      }
      
      public function get gameObjects() : GameObjectsData
      {
         return var_206;
      }
      
      public function get gameType() : int
      {
         return var_1787;
      }
      
      public function get roomType() : String
      {
         return var_3171;
      }
      
      public function get countDown() : int
      {
         return var_1572;
      }
   }
}

