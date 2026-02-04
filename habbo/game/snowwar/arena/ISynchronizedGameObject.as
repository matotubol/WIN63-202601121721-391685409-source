package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.core.runtime.class_13;
   
   public interface ISynchronizedGameObject extends IGameObject, class_13
   {
      
      function get isActive() : Boolean;
      
      function set isActive(param1:Boolean) : void;
      
      function get numberOfVariables() : int;
      
      function getVariable(param1:int) : int;
      
      function subturn(param1:class_2693) : void;
      
      function onRemove() : void;
   }
}

