package com.sulake.habbo.friendbar.landingview.interfaces
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   
   public interface ILandingViewWidget extends class_13
   {
      
      function initialize() : void;
      
      function refresh() : void;
      
      function get container() : class_1741;
   }
}

