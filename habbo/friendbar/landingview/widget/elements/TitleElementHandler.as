package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.class_4118;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class TitleElementHandler implements IElementHandler, class_4118
   {
      
      private var var_4371:Boolean = false;
      
      public function TitleElementHandler()
      {
         super();
      }
      
      public function initialize(param1:HabboLandingView, param2:class_1741, param3:Array, param4:GenericWidget) : void
      {
         var _loc5_:class_1812 = class_1812(param2);
         var _loc6_:String = param3[1];
         var_4371 = param3.length > 2 ? param3[2] == "true" : false;
         _loc5_.findChildByName("title_txt").caption = "${" + _loc6_ + "}";
         HabboLandingView.positionAfterAndStretch(_loc5_,"title_txt","hdr_line");
      }
      
      public function isFloating(param1:Boolean) : Boolean
      {
         return param1 || var_4371;
      }
      
      public function refresh() : void
      {
      }
   }
}

