package com.sulake.habbo.game.snowwar.gameobjects
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.habbo.game.snowwar.Tile;
   import com.sulake.habbo.game.snowwar.arena.class_2693;
   import com.sulake.habbo.game.snowwar.class_2694;
   import com.sulake.habbo.game.snowwar.utils.Direction360;
   import com.sulake.habbo.game.snowwar.utils.Direction8;
   import com.sulake.habbo.game.snowwar.utils.Location3D;
   import package_38.TreeGameObjectData;
   
   public class TreeGameObject extends SnowWarGameObject
   {
      
      private static const NO_BOUNDING_DATA:Array = [0];
      
      private static const BOUNDING_DATA:Array = [3200 - SnowBallGameObject.BOUNDING_DATA[0] - 1];
      
      private var var_3177:int;
      
      private var var_1489:Tile;
      
      private var _direction8:Direction8;
      
      private var _direction360:Direction360;
      
      private var var_385:int;
      
      private var var_1736:int;
      
      private var _hits:int;
      
      public function TreeGameObject(param1:TreeGameObjectData, param2:class_2694)
      {
         super(param1.id,false);
         isActive = true;
         var_1489 = param2.getTileAt(Tile.convertToTileX(param1.locationX3D),Tile.convertToTileY(param1.locationY3D));
         _direction8 = Direction8.getDirection8(param1.direction);
         _direction360 = new Direction360(Direction360.direction8ToDirection360Value(_direction8));
         var_3177 = param1.fuseObjectId;
         var_385 = param1.height;
         _hits = param1.hits;
         var_1736 = param1.maxHits;
         if(_hits < var_1736)
         {
            param2.addGameObjectToTile(this);
         }
         var_1489.addToHeight(-var_385);
         var_1489.blocked = true;
      }
      
      override public function get numberOfVariables() : int
      {
         return 9;
      }
      
      override public function getVariable(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return 2;
            case 1:
               return gameObjectId;
            case 2:
               return var_1489.location.x;
            case 3:
               return var_1489.location.y;
            case 4:
               return _direction8.intValue();
            case 5:
               return var_385;
            case 6:
               return var_3177;
            case 7:
               return var_1736;
            case 8:
               return _hits;
            default:
               throw new Exception("No such variable:" + param1);
         }
      }
      
      override public function get boundingType() : int
      {
         return 2;
      }
      
      override public function subturn(param1:class_2693) : void
      {
      }
      
      override public function get boundingData() : Array
      {
         if(_hits < var_1736)
         {
            return BOUNDING_DATA;
         }
         return NO_BOUNDING_DATA;
      }
      
      override public function get location3D() : Location3D
      {
         return var_1489.location;
      }
      
      override public function get direction360() : Direction360
      {
         return _direction360;
      }
      
      override public function onSnowBallHit(param1:class_2694, param2:SnowBallGameObject) : void
      {
         if(_hits < var_1736)
         {
            _hits = _hits + 1;
         }
         if(_hits >= var_1736)
         {
            var_1489.removeGameObject();
         }
      }
      
      public function get maxHits() : int
      {
         return var_1736;
      }
      
      public function get hits() : int
      {
         return _hits;
      }
      
      public function get fuseObjectId() : int
      {
         return var_3177;
      }
      
      override public function get collisionHeight() : int
      {
         return var_385;
      }
   }
}

