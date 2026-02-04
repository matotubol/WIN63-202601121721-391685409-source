package com.sulake.habbo.game.snowwar.utils
{
   import com.sulake.habbo.game.snowwar.arena.IGameObject;
   
   public class class_2846 implements class_2845
   {
      
      private var _referenceNumber:int = -1;
      
      private var _nodeDirection8:Direction8;
      
      private var var_3733:class_2845;
      
      private var var_2592:int;
      
      private var var_2612:int;
      
      private var var_1134:Boolean = false;
      
      public function class_2846()
      {
         super();
      }
      
      public function dispose() : void
      {
         _nodeDirection8 = null;
         var_3733 = null;
         var_2592 = 0;
         var_2612 = 0;
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get nodeDirection() : Direction8
      {
         return _nodeDirection8;
      }
      
      public function set nodeDirection(param1:Direction8) : void
      {
         _nodeDirection8 = param1;
      }
      
      public function get parentNode() : class_2845
      {
         return var_3733;
      }
      
      public function set parentNode(param1:class_2845) : void
      {
         this.var_3733 = param1;
      }
      
      public function get nodeCostToGoal() : int
      {
         return var_2592;
      }
      
      public function set nodeCostToGoal(param1:int) : void
      {
         this.var_2592 = param1;
      }
      
      public function get nodeCostFromStart() : int
      {
         return var_2612;
      }
      
      public function set nodeCostFromStart(param1:int) : void
      {
         this.var_2612 = param1;
      }
      
      public function compareTo(param1:class_2846) : int
      {
         var _loc3_:int = var_2612 + var_2592;
         var _loc2_:int = param1.var_2612 + param1.var_2592;
         if(_loc3_ < _loc2_)
         {
            return -1;
         }
         if(_loc3_ > _loc2_)
         {
            return 1;
         }
         return 0;
      }
      
      public function distanceTo(param1:class_2845) : int
      {
         return 0;
      }
      
      public function directionTo(param1:class_2845) : Direction8
      {
         return null;
      }
      
      public function getNodeAt(param1:Direction8) : class_2845
      {
         return null;
      }
      
      public function directionIsBlocked(param1:Direction8, param2:IGameObject) : Boolean
      {
         return false;
      }
      
      public function getPathCost(param1:Direction8, param2:IGameObject) : int
      {
         return 0;
      }
   }
}

