package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class class_4140 extends class_4135
   {
      
      private var var_777:String;
      
      private var var_3163:String;
      
      public function class_4140()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:class_1741, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         var_777 = param3[2];
         var_3163 = param4.configurationCode;
      }
      
      override protected function onClick() : void
      {
         landingView.context.createLinkEvent(var_777);
         landingView.tracking.trackEventLog("LandingView",var_3163,"client_link",var_777);
      }
   }
}

