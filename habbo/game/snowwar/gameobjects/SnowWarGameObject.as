package com.sulake.habbo.game.snowwar.gameobjects
{
   import com.sulake.habbo.game.snowwar.arena.ISynchronizedGameObject;
   import com.sulake.habbo.game.snowwar.arena.class_2693;
   import com.sulake.habbo.game.snowwar.class_2694;
   import com.sulake.habbo.game.snowwar.utils.Direction360;
   import com.sulake.habbo.game.snowwar.utils.Location3D;
   import com.sulake.habbo.game.snowwar.utils.class_3256;
   import com.sulake.habbo.game.snowwar.utils.class_4067;
   
   public class SnowWarGameObject implements ISynchronizedGameObject, class_3256
   {
      
      protected var _active:Boolean = false;
      
      protected var var_611:int = -1;
      
      protected var var_2886:Boolean = false;
      
      private var var_1134:Boolean = false;
      
      public function SnowWarGameObject(param1:int, param2:Boolean)
      {
         super();
         var_611 = param2 ? -param1 : param1;
         var_2886 = param2;
      }
      
      public function dispose() : void
      {
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get isActive() : Boolean
      {
         return _active;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         this._active = param1;
      }
      
      public function get numberOfVariables() : int
      {
         return -1;
      }
      
      public function getVariable(param1:int) : int
      {
         return -1;
      }
      
      public function get gameObjectId() : int
      {
         return var_611;
      }
      
      public function set gameObjectId(param1:int) : void
      {
         var_611 = param1;
      }
      
      public function subturn(param1:class_2693) : void
      {
      }
      
      public function get boundingType() : int
      {
         return 0;
      }
      
      public function get boundingData() : Array
      {
         return null;
      }
      
      public function get location3D() : Location3D
      {
         return null;
      }
      
      public function get direction360() : Direction360
      {
         return null;
      }
      
      public function get isGhost() : Boolean
      {
         return var_2886;
      }
      
      public function get ghostObjectId() : int
      {
         return -(var_611 + 1);
      }
      
      public function onRemove() : void
      {
      }
      
      public function get collisionHeight() : int
      {
         return boundingData[0];
      }
      
      public function testSnowBallCollision(param1:SnowBallGameObject) : Boolean
      {
         return param1.location3D.z < collisionHeight && class_4067.testForObjectToObjectCollision(this,param1);
      }
      
      public function onSnowBallHit(param1:class_2694, param2:SnowBallGameObject) : void
      {
      }
   }
}

