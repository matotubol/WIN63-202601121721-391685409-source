package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   
   public class CommunityGoalVsModeWidget extends CommunityGoalWidget
   {
      
      private static const NEEDLE_LEVELS:Array = [-3,-2,-1,0,1,2,3];
      
      private static const NEEDLE_FRAMES:Array = [0,0,4.75,11.5,16.25,23,23];
      
      public function CommunityGoalVsModeWidget(param1:HabboLandingView, param2:Boolean = false)
      {
         super(param1,param2);
      }
      
      override protected function getCurrentNeedleFrame() : int
      {
         if(communityProgress.communityHighestAchievedLevel <= NEEDLE_LEVELS[0])
         {
            return int(Math.round(NEEDLE_FRAMES[0]));
         }
         if(communityProgress.communityHighestAchievedLevel >= NEEDLE_LEVELS[NEEDLE_LEVELS.length - 1])
         {
            return int(Math.round(NEEDLE_FRAMES[NEEDLE_LEVELS.length - 1]));
         }
         var _loc3_:int = communityProgress.scoreRemainingUntilNextLevel < 0 ? -1 : 1;
         var _loc1_:int = communityProgress.communityHighestAchievedLevel;
         var _loc2_:Number = Number(NEEDLE_FRAMES[NEEDLE_LEVELS.indexOf(_loc1_)]);
         var _loc4_:Number = Math.abs(NEEDLE_FRAMES[NEEDLE_LEVELS.indexOf(_loc1_ + _loc3_)] - NEEDLE_FRAMES[NEEDLE_LEVELS.indexOf(_loc1_)]);
         return Math.round(_loc2_ + communityProgress.percentCompletionTowardsNextLevel / 100 * _loc4_ * _loc3_);
      }
      
      override public function update(param1:uint) : void
      {
         updateMeter(Math.floor(getCurrentNeedleFrame()),false);
      }
      
      override public function initialize() : void
      {
         super.initialize();
         var_156.findChildByName("community_total_status").visible = false;
      }
   }
}

