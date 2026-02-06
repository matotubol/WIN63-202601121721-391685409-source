package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetCommunityGoalHallOfFameMessageComposer;
   import com.sulake.habbo.friendbar.landingview.*;
   import com.sulake.habbo.communication.messages.incoming.competition.CurrentTimingCodeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalHallOfFameMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.class_4082;
   import com.sulake.habbo.communication.messages.incoming.quest.class_4116;
   import com.sulake.habbo.communication.messages.incoming.quest.class_4117;
   import com.sulake.habbo.communication.messages.outgoing.competition.ForwardToACompetitionRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.competition.GetCurrentTimingCodeMessageComposer;
   
   public class CommunityGoalHallOfFameWidget extends UserListWidget
   {
      
      private var var_24:class_4082;
      
      private var var_3488:String;
      
      public function CommunityGoalHallOfFameWidget(param1:HabboLandingView)
      {
         super(param1);
      }
      
      override public function initialize() : void
      {
         super.initialize();
         var_3488 = landingView.getProperty("landing.view.dynamic.slot.6.conf");
      }
      
      override protected function registerMessageListeners() : void
      {
         landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalHallOfFameMessageEvent(onCommunityGoalHallOfFame));
         landingView.communicationManager.addHabboConnectionMessageEvent(new CurrentTimingCodeMessageEvent(onTimingCode));
      }
      
      override public function refresh() : void
      {
         landingView.send(new GetCurrentTimingCodeMessageComposer(var_3488));
      }
      
      override protected function get users() : Array
      {
         return var_24?.hof;
      }
      
      override protected function refreshPopup(param1:class_4116, param2:class_1812) : void
      {
         var _loc4_:class_4117 = class_4117(param1);
         param2.findChildByName("user_name_txt").caption = _loc4_.userName;
         landingView.localizationManager.registerParameter("landing.view.competition.hof.points","points","" + _loc4_.currentScore);
         param2.findChildByName("score_txt").caption = getText("landing.view.competition.hof.points");
         param2.findChildByName("rank_desc_txt").caption = getText("landing.view.competition.hof." + var_24.goalCode + ".rankdesc.leader");
      }
      
      override protected function getPopupXml() : String
      {
         return "competition_user_popup";
      }
      
      private function onCommunityGoalHallOfFame(param1:CommunityGoalHallOfFameMessageEvent) : void
      {
         var_24 = param1.getParser().data;
         refreshContent();
      }
      
      override protected function hasExtraLink() : Boolean
      {
         return landingView.getBoolean("landing.view.communitygoalhof.hasroomlink");
      }
      
      override protected function extraLinkClicked(param1:class_4116) : void
      {
         landingView.send(new ForwardToACompetitionRoomMessageComposer(var_24.goalCode,param1.userId));
      }
      
      private function onTimingCode(param1:CurrentTimingCodeMessageEvent) : void
      {
         var _loc2_:String = param1.getParser().code;
         if(param1.getParser().schedulingStr == var_3488 && _loc2_ != "" && !disposed)
         {
            loadConfigurationOverrides(_loc2_);
            landingView.send(new GetCommunityGoalHallOfFameMessageComposer(param1.getParser().code));
         }
      }
      
      private function loadConfigurationOverrides(param1:String) : void
      {
         var _loc6_:String = "landing.view." + param1 + ".avatarlist.yoffsets.array";
         if(landingView.propertyExists(_loc6_))
         {
            var _loc4_:Array = landingView.getProperty(_loc6_).split(",");
            var _loc3_:int = 0;
            while(0 < null.length)
            {
               null[0] = parseInt(null[0]);
               _loc3_++;
            }
            avatarOffsetsY = null;
         }
         var _loc5_:String = "landing.view." + param1 + ".avatarlist.widths.array";
         if(landingView.propertyExists(_loc5_))
         {
            _loc4_ = landingView.getProperty(_loc5_).split(",");
            _loc3_ = 0;
            while(0 < null.length)
            {
               null[0] = parseInt(null[0]);
               _loc3_++;
            }
            avatarContainerWidths = null;
         }
         var _loc2_:String = "landing.view." + param1 + ".avatarlist.startoffset";
         if(landingView.propertyExists(_loc2_))
         {
            startOffset = parseInt(landingView.getProperty(_loc2_));
         }
      }
   }
}

