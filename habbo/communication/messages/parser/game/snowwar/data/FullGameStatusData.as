package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class FullGameStatusData
   {
      
      private var var_4286:int;
      
      private var var_4923:int;
      
      private var var_206:GameObjectsData;
      
      private var _numberOfTeams:int;
      
      private var var_4608:GameStatusData;
      
      public function FullGameStatusData(param1:IMessageDataWrapper)
      {
         super();
         parse(param1);
      }
      
      public function get remainingTimeSeconds() : int
      {
         return var_4286;
      }
      
      public function get durationInSeconds() : int
      {
         return var_4923;
      }
      
      public function get gameObjects() : GameObjectsData
      {
         return var_206;
      }
      
      public function get numberOfTeams() : int
      {
         return _numberOfTeams;
      }
      
      public function get gameStatus() : GameStatusData
      {
         return var_4608;
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
         param1.readInteger();
         var_4286 = param1.readInteger();
         var_4923 = param1.readInteger();
         var_206 = new GameObjectsData(param1);
         param1.readInteger();
         _numberOfTeams = param1.readInteger();
         var_4608 = new GameStatusData(param1);
      }
   }
}

