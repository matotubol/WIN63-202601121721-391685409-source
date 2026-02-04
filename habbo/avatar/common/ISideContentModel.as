package com.sulake.habbo.avatar.common
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   
   public interface ISideContentModel
   {
      
      function dispose() : void;
      
      function reset() : void;
      
      function get controller() : HabboAvatarEditor;
      
      function getWindowContainer() : class_1812;
   }
}

