package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetCommunityGoalProgressMessageComposer;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalProgressMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.class_4083;
   
   public class class_4145 extends class_4142
   {
      
      public function class_4145()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:class_1741, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         param1.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
      }
      
      override public function refresh() : void
      {
         landingView.send(new GetCommunityGoalProgressMessageComposer());
      }
      
      private function onCommunityGoalProgress(param1:CommunityGoalProgressMessageEvent) : void
      {
         var _loc2_:class_4083 = param1.getParser().data;
         setTimer(_loc2_.hasGoalExpired ? 0 : _loc2_.timeRemainingInSeconds);
      }
   }
}

