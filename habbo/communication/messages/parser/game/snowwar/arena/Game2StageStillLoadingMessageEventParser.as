package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class Game2StageStillLoadingMessageEventParser implements IMessageParser
   {
      
      private var var_4445:int;
      
      private var var_3690:Array;
      
      public function Game2StageStillLoadingMessageEventParser()
      {
         super();
      }
      
      public function get percentage() : int
      {
         return var_4445;
      }
      
      public function get finishedPlayers() : Array
      {
         return var_3690;
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4445 = param1.readInteger();
         var_3690 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_3690.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
   }
}

