package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import package_140.class_2880;
   import package_81.class_2385;
   
   public class class_4143 extends class_4142
   {
      
      private var var_3666:String;
      
      public function class_4143()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:class_1741, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         var_3666 = param3[6];
         param1.communicationManager.addHabboConnectionMessageEvent(new class_2880(onTime));
      }
      
      override public function refresh() : void
      {
         landingView.send(new class_2385(var_3666));
      }
      
      private function onTime(param1:class_2880) : void
      {
         if(param1.getParser().timeStr == var_3666)
         {
            setTimer(param1.getParser().secondsUntil);
         }
      }
   }
}

