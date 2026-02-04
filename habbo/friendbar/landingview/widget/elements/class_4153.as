package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.class_4118;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import package_62.class_3284;
   
   public class class_4153 implements IElementHandler, class_4118
   {
      
      private var var_48:IStaticBitmapWrapperWindow;
      
      private var var_61:int;
      
      private var var_3244:int;
      
      private var var_2717:int;
      
      public function class_4153()
      {
         super();
      }
      
      public function initialize(param1:HabboLandingView, param2:class_1741, param3:Array, param4:GenericWidget) : void
      {
         var_48 = IStaticBitmapWrapperWindow(param2);
         var _loc5_:String = param3[1];
         var_48.assetUri = _loc5_;
         var_48.x = param3.length > 2 ? int(param3[2]) : 0;
         var_48.y = param3.length > 3 ? int(param3[3]) : 0;
         class_21.log("Init Concurrent users meter: " + _loc5_);
         param1.communicationManager.addHabboConnectionMessageEvent(new class_3284(onConcurrentUsersGoalProgress));
      }
      
      public function refresh() : void
      {
      }
      
      public function isFloating(param1:Boolean) : Boolean
      {
         return true;
      }
      
      private function onConcurrentUsersGoalProgress(param1:class_3284) : void
      {
         var_61 = param1.getParser().state;
         var_3244 = param1.getParser().userCount;
         var_2717 = param1.getParser().userCountGoal;
         var _loc3_:int = var_3244 / var_2717 * 100;
         _loc3_ = Math.max(20,Math.min(100,_loc3_));
         _loc3_ = Math.floor(_loc3_ / 10) * 10;
         var _loc2_:String = "challenge_meter_" + _loc3_;
         var_48.assetUri = "${image.library.url}reception/" + _loc2_ + ".png";
         class_21.log("Updating meter: " + _loc2_);
      }
   }
}

