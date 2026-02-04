package com.sulake.habbo.room.object.visualization.avatar.additions
{
   import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   
   public class ExpressionAddition implements IExpressionAddition
   {
      
      protected var var_197:int;
      
      protected var var_213:AvatarVisualization;
      
      private var var_230:int = -1;
      
      public function ExpressionAddition(param1:int, param2:int, param3:AvatarVisualization)
      {
         super();
         var_230 = param2;
         var_197 = param1;
         var_213 = param3;
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get disposed() : Boolean
      {
         return var_213 == null;
      }
      
      public function dispose() : void
      {
         var_213 = null;
      }
      
      public function update(param1:IRoomObjectSprite, param2:Number) : void
      {
      }
      
      public function animate(param1:IRoomObjectSprite) : Boolean
      {
         return false;
      }
   }
}

