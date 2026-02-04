package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class class_4149 extends class_4135
   {
      
      private var var_3436:String;
      
      public function class_4149()
      {
         super();
      }
      
      override protected function onClick() : void
      {
         landingView.goToRoom(var_3436);
         landingView.tracking.trackGoogle("landingView","click_promotedroom" + var_3436);
      }
      
      override public function initialize(param1:HabboLandingView, param2:class_1741, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         if(param3.length > 1)
         {
            var_3436 = param3[2];
         }
      }
   }
}

