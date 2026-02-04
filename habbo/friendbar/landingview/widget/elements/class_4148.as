package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class class_4148 extends class_4135
   {
      
      private var var_1951:int;
      
      public function class_4148()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:class_1741, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         var_1951 = int(param3[2]);
      }
      
      override protected function onClick() : void
      {
         landingView.navigator.goToPrivateRoom(var_1951);
         landingView.tracking.trackGoogle("landingView","click_gotoroom");
      }
   }
}

