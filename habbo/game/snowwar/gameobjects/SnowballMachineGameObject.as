package com.sulake.habbo.game.snowwar.gameobjects
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.habbo.game.snowwar.Tile;
   import com.sulake.habbo.game.snowwar.class_2694;
   import com.sulake.habbo.game.snowwar.utils.Direction8;
   import package_38.SnowballMachineGameObjectData;
   
   public class SnowballMachineGameObject extends SnowballGivingGameObject
   {
      
      public static var BOUNDING_DATA:Array = [1200];
      
      private var _maxSnowballs:int;
      
      private var var_2882:Direction8;
      
      public function SnowballMachineGameObject(param1:SnowballMachineGameObjectData, param2:class_2694)
      {
         super(param1.id,param1.snowballCount,param2.getTileAt(Tile.convertToTileX(param1.locationX3D),Tile.convertToTileY(param1.locationY3D)),param1.fuseObjectId);
         _maxSnowballs = param1.maxSnowballs;
         var_2882 = Direction8.getDirection8(param1.direction);
         param2.addGameObjectToTile(this);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_2882 = null;
      }
      
      override public function get numberOfVariables() : int
      {
         return 8;
      }
      
      override public function getVariable(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return 4;
            case 1:
               return var_611;
            case 2:
               return var_116.location.x;
            case 3:
               return var_116.location.y;
            case 4:
               return var_2882.intValue();
            case 5:
               return _maxSnowballs;
            case 6:
               return var_220;
            case 7:
               return var_3177;
            default:
               throw new Exception("No such variable:" + param1);
         }
      }
      
      override public function get boundingData() : Array
      {
         return BOUNDING_DATA;
      }
      
      public function createSnowball() : void
      {
         if(var_220 < _maxSnowballs)
         {
            var_220 = var_220 + 1;
         }
      }
   }
}

