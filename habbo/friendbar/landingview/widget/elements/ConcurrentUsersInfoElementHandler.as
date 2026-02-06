package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetConcurrentUsersRewardMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetConcurrentUsersGoalProgressMessageComposer;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.incoming.quest.ConcurrentUsersGoalProgressMessageEvent;
   
   public class ConcurrentUsersInfoElementHandler implements IElementHandler, class_13
   {
      
      private static const STATE_DISABLED:int = 0;
      
      private static const STATE_ACTIVE:int = 1;
      
      private static const STATE_REDEEM:int = 2;
      
      private static const STATE_REWARDED:int = 3;
      
      private static const UPDATE_INTERVAL_MS:int = 5000;
      
      private var _landingView:HabboLandingView;
      
      private var var_16:GenericWidget;
      
      private var _localizationKey:String;
      
      private var var_61:int = -1;
      
      private var var_3244:int = -1;
      
      private var var_2717:int = -1;
      
      private var _window:class_1812;
      
      private var var_251:Timer;
      
      private var var_1134:Boolean = false;
      
      public function ConcurrentUsersInfoElementHandler()
      {
         super();
         var_251 = new Timer(5000);
         var_251.addEventListener("timer",onUpdateTimer);
      }
      
      private function onUpdateTimer(param1:TimerEvent) : void
      {
         if(_window == null || _window.visible == false || !_landingView.isLandingViewVisible)
         {
            return;
         }
         refresh();
      }
      
      public function dispose() : void
      {
         if(var_251)
         {
            var_251.stop();
         }
         var_251 = null;
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function initialize(param1:HabboLandingView, param2:class_1741, param3:Array, param4:GenericWidget) : void
      {
         var_16 = param4;
         _landingView = param1;
         _window = param2 as class_1812;
         _localizationKey = param3[1];
         _window.findChildByName("users_desc").caption = "${" + _localizationKey + "}";
         var _loc5_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_window.findChildByName("badge_image"));
         var _loc6_:String = param3.length > 2 ? param3[2] : "ConcurrentUsersReward";
         var _loc7_:String = "${image.library.url}album1584/" + _loc6_ + ".png";
         _loc5_.assetUri = _loc7_;
         updateLocalization();
         param2.procedure = onButton;
         param1.communicationManager.addHabboConnectionMessageEvent(new ConcurrentUsersGoalProgressMessageEvent(onConcurrentUsersGoalProgress));
         var_251.start();
      }
      
      public function refresh() : void
      {
         _landingView.send(new GetConcurrentUsersGoalProgressMessageComposer());
      }
      
      private function updateLocalization() : void
      {
         var _loc4_:String = "landing.view.concurrentusers.caption";
         var _loc3_:String = "landing.view.concurrentusers.bodytext";
         _landingView.windowManager.registerLocalizationParameter(_localizationKey,"userCount",var_3244.toString());
         _landingView.windowManager.registerLocalizationParameter(_localizationKey,"userGoal",var_2717.toString());
         _landingView.windowManager.registerLocalizationParameter("landing.view.concurrentusers.bodytext","userCount",var_3244.toString());
         _landingView.windowManager.registerLocalizationParameter("landing.view.concurrentusers.bodytext","userGoal",var_2717.toString());
         _landingView.windowManager.registerLocalizationParameter("landing.view.concurrentusers.bodytext","domain",_landingView.localizationManager.getLocalization("landing.view.hotel.domain","Habbo"));
         switch(var_61)
         {
            case 0:
               _window.findChildByName("state.active").visible = true;
               _window.findChildByName("state.achieved").visible = false;
               break;
            case 1:
               _window.findChildByName("state.active").visible = true;
               _window.findChildByName("state.achieved").visible = false;
               break;
            case 2:
               if(var_251)
               {
                  var_251.stop();
               }
               _loc4_ += ".success";
               _loc3_ += ".success";
               _window.findChildByName("state.active").visible = false;
               _window.findChildByName("state.active").enable();
               _window.findChildByName("state.achieved").visible = true;
               _window.findChildByName("action_button").visible = true;
               break;
            case 3:
               if(var_251)
               {
                  var_251.stop();
               }
               _loc4_ += ".success";
               _loc3_ += ".success";
               _window.findChildByName("state.active").visible = false;
               _window.findChildByName("state.achieved").visible = true;
               _window.findChildByName("action_button").visible = false;
         }
         var _loc1_:class_4133 = var_16.getElementByName("bodytext") as class_4133;
         if(_loc1_)
         {
            _loc1_.localizationKey = _loc3_;
         }
         var _loc2_:class_4133 = var_16.getElementByName("caption") as class_4133;
         if(_loc2_)
         {
            _loc2_.localizationKey = _loc4_;
         }
      }
      
      private function onConcurrentUsersGoalProgress(param1:ConcurrentUsersGoalProgressMessageEvent) : void
      {
         var_61 = param1.getParser().state;
         var_3244 = param1.getParser().userCount;
         var_2717 = param1.getParser().userCountGoal;
         updateLocalization();
      }
      
      private function onButton(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            onClick();
         }
      }
      
      protected function onClick() : void
      {
         _landingView.send(new GetConcurrentUsersRewardMessageComposer());
         _landingView.send(new GetConcurrentUsersGoalProgressMessageComposer());
         _window.findChildByName("state.active").disable();
      }
   }
}

