package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.utils.class_55;
   
   public class GameStatusData
   {
      
      private var var_412:int;
      
      private var var_4209:int;
      
      private var var_3720:class_55;
      
      public function GameStatusData(param1:IMessageDataWrapper)
      {
         super();
         parse(param1);
      }
      
      public function get turn() : int
      {
         return var_412;
      }
      
      public function get checksum() : int
      {
         return var_4209;
      }
      
      public function get events() : class_55
      {
         return var_3720;
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
         var_412 = param1.readInteger();
         var_4209 = param1.readInteger();
         var_3720 = new class_55();
         var _loc2_:int = param1.readInteger();
         var _loc5_:int = 0;
         while(0 < _loc2_)
         {
            var _loc6_:int = param1.readInteger();
            var _loc8_:Array = [];
            var _loc7_:int = 0;
            var_3720.add(0,null);
            _loc5_++;
         }
      }
   }
}

