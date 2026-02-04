package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.core.runtime.class_13;
   
   public interface IGameObject extends class_13
   {
      
      function get gameObjectId() : int;
      
      function get isGhost() : Boolean;
      
      function get ghostObjectId() : int;
   }
}

