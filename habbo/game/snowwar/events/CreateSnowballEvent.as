package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.arena.class_2693;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowBallGameObject;
   
   public class CreateSnowballEvent extends class_2840
   {
      
      private var _snowBallGameObject:SnowBallGameObject;
      
      private var var_1781:HumanGameObject;
      
      private var var_1440:int;
      
      private var var_1401:int;
      
      private var var_277:int;
      
      public function CreateSnowballEvent(param1:int, param2:HumanGameObject, param3:int, param4:int, param5:int)
      {
         super();
         this._snowBallGameObject = new SnowBallGameObject(param1);
         this.var_1781 = param2;
         this.var_1440 = param3;
         this.var_1401 = param4;
         this.var_277 = param5;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _snowBallGameObject = null;
         var_1781 = null;
      }
      
      public function set snowBallGameObject(param1:SnowBallGameObject) : void
      {
         this._snowBallGameObject = param1;
      }
      
      override public function apply(param1:class_2693) : void
      {
         param1.addGameObject(_snowBallGameObject.gameObjectId,_snowBallGameObject);
         _snowBallGameObject.isActive = true;
         var _loc2_:int = var_1781.currentLocation.x;
         var _loc3_:int = var_1781.currentLocation.y;
         _snowBallGameObject.initialize(_loc2_,_loc3_,3000,var_277,var_1440,var_1401,var_1781);
      }
   }
}

