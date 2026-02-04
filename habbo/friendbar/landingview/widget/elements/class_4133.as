package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class class_4133 implements IElementHandler
   {
      
      private var _window:ITextWindow;
      
      public function class_4133()
      {
         super();
      }
      
      public function initialize(param1:HabboLandingView, param2:class_1741, param3:Array, param4:GenericWidget) : void
      {
         _window = param2 as ITextWindow;
         var _loc5_:String = param3[1];
         _window.caption = "${" + _loc5_ + "}";
         if(param3.length > 2)
         {
            _window.width = parseInt(param3[2]);
         }
         if(param3.length > 3 && param3[3] == "true")
         {
            _window.border = true;
         }
      }
      
      public function refresh() : void
      {
      }
      
      public function set localizationKey(param1:String) : void
      {
         _window.caption = "${" + param1 + "}";
      }
   }
}

