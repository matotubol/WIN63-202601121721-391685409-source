package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class GameLevelData
   {
      
      private var _width:int;
      
      private var var_385:int;
      
      private var var_936:String;
      
      private var var_2871:Array = [];
      
      public function GameLevelData(param1:IMessageDataWrapper)
      {
         super();
         parse(param1);
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return var_385;
      }
      
      public function get heightMap() : String
      {
         return var_936;
      }
      
      public function get fuseObjects() : Array
      {
         return var_2871;
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
         _width = param1.readInteger();
         var_385 = param1.readInteger();
         var_936 = param1.readString();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var _loc4_:FuseObjectData = new FuseObjectData();
            _loc4_.parse(param1);
            var_2871.push(null);
            _loc3_++;
         }
      }
   }
}

