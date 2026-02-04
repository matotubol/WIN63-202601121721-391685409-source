package com.sulake.habbo.room.object.visualization.avatar.additions
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   
   public interface class_2504 extends class_13
   {
      
      function get id() : int;
      
      function update(param1:IRoomObjectSprite, param2:Number) : void;
      
      function animate(param1:IRoomObjectSprite) : Boolean;
   }
}

