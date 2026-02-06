package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.communication.messages.incoming.landingview.votes.CommunityVoteReceivedEvent;
   
   public class CommunityGoalVsModeWidgetWithVoting extends CommunityGoalVsModeWidget
   {
      
      private var var_2426:class_1741;
      
      private var var_2214:class_1741;
      
      private var var_5279:String;
      
      public function CommunityGoalVsModeWidgetWithVoting(param1:HabboLandingView)
      {
         super(param1,true);
      }
      
      override public function initialize() : void
      {
         super.initialize();
         var_2426 = var_156.findChildByName("community_vote_one_button");
         var_2426.procedure = onVoteOptionOneClick;
         var_2214 = var_156.findChildByName("community_vote_two_button");
         var_2214.procedure = onVoteOptionTwoClick;
         _landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityVoteReceivedEvent(onInfo));
      }
      
      override public function refresh() : void
      {
         super.refresh();
         if(communityProgress != null)
         {
            if(var_2426 != null)
            {
               var_2426.visible = communityProgress.personalContributionScore == 0;
            }
            if(var_2214 != null)
            {
               var_2214.visible = communityProgress.personalContributionScore == 0;
            }
         }
      }
      
      private function onVoteOptionOneClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            hideVoteButtons();
            _landingView.communityGoalVote(1);
            _landingView.tracking.trackGoogle("landingView","click_voteoption_one");
         }
      }
      
      private function onVoteOptionTwoClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            hideVoteButtons();
            _landingView.communityGoalVote(2);
            _landingView.tracking.trackGoogle("landingView","click_voteoption_two");
         }
      }
      
      private function onInfo(param1:CommunityVoteReceivedEvent) : void
      {
         if(param1.getParser().acknowledged)
         {
            hideVoteButtons();
         }
      }
      
      private function hideVoteButtons() : void
      {
         var_2426.visible = false;
         var_2214.visible = false;
      }
   }
}

