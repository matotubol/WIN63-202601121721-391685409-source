package com.sulake.habbo.friendbar.landingview.interfaces.elements
{
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public interface IElementHandler
   {
      
      function initialize(param1:HabboLandingView, param2:class_1741, param3:Array, param4:GenericWidget) : void;
      
      function refresh() : void;
   }
}

