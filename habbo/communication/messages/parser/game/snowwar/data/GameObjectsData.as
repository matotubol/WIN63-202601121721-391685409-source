package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import package_38.SnowWarGameObjectData;
   
   public class GameObjectsData
   {
      
      private var var_206:Array = [];
      
      public function GameObjectsData(param1:IMessageDataWrapper)
      {
         super();
         parse(param1);
      }
      
      public function get gameObjects() : Array
      {
         return var_206;
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:SnowWarGameObjectData = null;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = param1.readInteger();
            _loc4_ = param1.readInteger();
            _loc6_ = SnowWarGameObjectData.create(_loc5_,_loc4_);
            _loc6_.parse(param1);
            var_206.push(_loc6_);
            _loc3_++;
         }
      }
   }
}

