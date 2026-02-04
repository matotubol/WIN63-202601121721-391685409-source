package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.components.class_2250;
   
   public interface ITrackedWindow extends class_13
   {
      
      function getType() : int;
      
      function getId() : String;
      
      function getFrame() : class_2250;
      
      function show() : void;
   }
}

