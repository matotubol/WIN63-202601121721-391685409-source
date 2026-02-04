package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.arena.class_2693;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   
   public class NewMoveTargetEvent extends class_2840
   {
      
      private var _humanGameObject:HumanGameObject;
      
      private var var_25:int;
      
      private var var_26:int;
      
      public function NewMoveTargetEvent(param1:HumanGameObject, param2:int, param3:int)
      {
         super();
         this._humanGameObject = param1;
         this.var_25 = param2;
         this.var_26 = param3;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _humanGameObject = null;
      }
      
      override public function apply(param1:class_2693) : void
      {
         _humanGameObject.changeMoveTarget(var_25,var_26);
      }
      
      public function get humanGameObject() : HumanGameObject
      {
         return _humanGameObject;
      }
      
      public function get x() : int
      {
         return var_25;
      }
      
      public function get y() : int
      {
         return var_26;
      }
   }
}

