package com.sulake.habbo.catalog.collectibles
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   
   public interface class_2714 extends class_1829, class_13
   {
      
      function clearPreviewer() : void;
      
      function set imageResult(param1:class_2198) : void;
      
      function set avatarResult(param1:String) : void;
      
      function set badgeResult(param1:String) : void;
      
      function set petResult(param1:String) : void;
      
      function setEffectResult(param1:String, param2:int) : void;
      
      function setUnknownImage() : void;
   }
}

