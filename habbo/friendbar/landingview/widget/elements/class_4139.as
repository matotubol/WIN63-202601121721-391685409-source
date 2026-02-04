package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.habbo.communication.messages.outgoing.quest.class_3232;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.ILayoutNameProvider;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.class_4112;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.class_4118;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.window.widgets.IRunningNumberWidget;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import package_62.class_2885;
   import package_62.class_4083;
   
   public class class_4139 implements IElementHandler, class_13, class_4118, ILayoutNameProvider, class_4112
   {
      
      private var _landingView:HabboLandingView;
      
      private var _window:class_1812;
      
      private var var_3430:Boolean;
      
      private var var_1176:Timer;
      
      private var var_2891:Boolean;
      
      public function class_4139()
      {
         super();
      }
      
      public function dispose() : void
      {
         if(_landingView)
         {
            _landingView.communicationManager.removeHabboConnectionMessageEvent(new class_2885(onCommunityGoalProgress));
            _landingView = null;
         }
         if(var_1176)
         {
            var_1176.stop();
            var_1176.removeEventListener("timer",onPollTimer);
            var_1176 = null;
         }
         _window = null;
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      public function initialize(param1:HabboLandingView, param2:class_1741, param3:Array, param4:GenericWidget) : void
      {
         _landingView = param1;
         _window = class_1812(param2);
         var _loc7_:int = int(param3[1]);
         var _loc6_:int = int(param3[2]);
         var _loc8_:int = int(param3[3]);
         var_3430 = param3[4] == "true";
         var _loc5_:class_2010 = class_2010(_window.findChildByName("running_number_widget"));
         var _loc9_:IRunningNumberWidget = IRunningNumberWidget(_loc5_.widget);
         _loc9_.digits = _loc7_;
         _loc9_.updateFrequency = _loc6_;
         if(var_3430)
         {
            _window.x = int(param3[5]);
            _window.y = int(param3[6]);
         }
         _landingView.communicationManager.addHabboConnectionMessageEvent(new class_2885(onCommunityGoalProgress));
         var_1176 = new Timer(_loc8_);
         var_1176.addEventListener("timer",onPollTimer);
      }
      
      public function disable() : void
      {
         var_1176.stop();
      }
      
      public function refresh() : void
      {
         _landingView.send(new class_3232());
         var_2891 = false;
         var_1176.start();
      }
      
      public function isFloating(param1:Boolean) : Boolean
      {
         return var_3430;
      }
      
      public function get layoutName() : String
      {
         return "element_community_goal_score";
      }
      
      private function onCommunityGoalProgress(param1:class_2885) : void
      {
         var _loc4_:class_4083 = null;
         var _loc2_:class_2010 = null;
         var _loc3_:IRunningNumberWidget = null;
         if(_landingView)
         {
            _loc4_ = param1.getParser().data;
            _loc2_ = class_2010(_window.findChildByName("running_number_widget"));
            _loc3_ = IRunningNumberWidget(_loc2_.widget);
            if(var_2891)
            {
               _loc3_.number = _loc4_.communityTotalScore;
            }
            else
            {
               _loc3_.initialNumber = _loc4_.communityTotalScore;
               var_2891 = true;
            }
         }
      }
      
      private function onPollTimer(param1:TimerEvent) : void
      {
         _landingView.send(new class_3232());
      }
   }
}

