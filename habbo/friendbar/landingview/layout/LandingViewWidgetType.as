package com.sulake.habbo.friendbar.landingview.layout
{
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.widget.AvatarImageWidget;
   import com.sulake.habbo.friendbar.landingview.widget.BonusRarePromoWidget;
   import com.sulake.habbo.friendbar.landingview.widget.CatalogPromoWidget;
   import com.sulake.habbo.friendbar.landingview.widget.CatalogPromoWidgetSmall;
   import com.sulake.habbo.friendbar.landingview.widget.CommunityGoalHallOfFameWidget;
   import com.sulake.habbo.friendbar.landingview.widget.CommunityGoalPrizesWidget;
   import com.sulake.habbo.friendbar.landingview.widget.CommunityGoalVsModeWidget;
   import com.sulake.habbo.friendbar.landingview.widget.CommunityGoalVsModeWidgetWithVoting;
   import com.sulake.habbo.friendbar.landingview.widget.CommunityGoalWidget;
   import com.sulake.habbo.friendbar.landingview.widget.DailyQuestWidget;
   import com.sulake.habbo.friendbar.landingview.widget.ExpiringCatalogPageSmallWidget;
   import com.sulake.habbo.friendbar.landingview.widget.ExpiringCatalogPageWidget;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.friendbar.landingview.widget.HabboModerationPromoWidget;
   import com.sulake.habbo.friendbar.landingview.widget.HabboTalentsPromoWidget;
   import com.sulake.habbo.friendbar.landingview.widget.HabboWayPromoWidget;
   import com.sulake.habbo.friendbar.landingview.widget.NextLimitedRareCountdownWidget;
   import com.sulake.habbo.friendbar.landingview.widget.PromoArticleWidget;
   import com.sulake.habbo.friendbar.landingview.widget.RoomHopperNetworkWidget;
   import com.sulake.habbo.friendbar.landingview.widget.SafetyQuizPromoWidget;
   import com.sulake.habbo.friendbar.landingview.widget.WidgetContainerWidget;
   
   public class LandingViewWidgetType
   {
      
      public static const AVATARIMAGE:String = "avatarimage";
      
      public static const EXPIRINGCATALOGPAGE:String = "expiringcatalogpage";
      
      public static const const_759:String = "expiringcatalogpagesmall";
      
      public static const COMMUNITYGOAL:String = "communitygoal";
      
      public static const COMMUNITYGOALVS:String = "communitygoalvsmode";
      
      public static const COMMUNITYGOALVSVOTE:String = "communitygoalvsmodevote";
      
      public static const CATALOGPROMO:String = "catalogpromo";
      
      public static const CATALOGPROMOSMALL:String = "catalogpromosmall";
      
      public static const ACHIEVEMENTCOMPETITIONHALLOFFAME:String = "achievementcompetition_hall_of_fame";
      
      public static const ACHIEVEMENTCOMPETITIONPRIZES:String = "achievementcompetition_prizes";
      
      public static const DAILYQUEST:String = "dailyquest";
      
      public static const const_651:String = "nextlimitedrarecountdown";
      
      public static const HABBOMODERATIONPROMO:String = "habbomoderationpromo";
      
      public static const HABBOTALENTSPROMO:String = "habbotalentspromo";
      
      public static const HABBOWAYPROMO:String = "habbowaypromo";
      
      public static const ROOMHOPPERNETWORK:String = "roomhoppernetwork";
      
      public static const SAFETYQUIZPROMO:String = "safetyquizpromo";
      
      public static const GENERIC:String = "generic";
      
      public static const WIDGETCONTAINER:String = "widgetcontainer";
      
      public static const PROMOARTICLE:String = "promoarticle";
      
      public static const BONUSRARE:String = "bonusrare";
      
      public function LandingViewWidgetType()
      {
         super();
      }
      
      public static function getWidgetForType(param1:String, param2:HabboLandingView) : ILandingViewWidget
      {
         var _loc3_:ILandingViewWidget = null;
         switch(param1)
         {
            case "achievementcompetition_hall_of_fame":
               _loc3_ = new CommunityGoalHallOfFameWidget(param2);
               break;
            case "achievementcompetition_prizes":
               _loc3_ = new CommunityGoalPrizesWidget(param2);
               break;
            case "avatarimage":
               _loc3_ = new AvatarImageWidget(param2);
               break;
            case "communitygoal":
               _loc3_ = new CommunityGoalWidget(param2);
               break;
            case "communitygoalvsmode":
               _loc3_ = new CommunityGoalVsModeWidget(param2);
               break;
            case "communitygoalvsmodevote":
               _loc3_ = new CommunityGoalVsModeWidgetWithVoting(param2);
               break;
            case "catalogpromo":
               _loc3_ = new CatalogPromoWidget(param2);
               break;
            case "catalogpromosmall":
               _loc3_ = new CatalogPromoWidgetSmall(param2);
               break;
            case "dailyquest":
               _loc3_ = new DailyQuestWidget(param2);
               break;
            case "expiringcatalogpage":
               _loc3_ = new ExpiringCatalogPageWidget(param2);
               break;
            case "expiringcatalogpagesmall":
               _loc3_ = new ExpiringCatalogPageSmallWidget(param2);
               break;
            case "nextlimitedrarecountdown":
               _loc3_ = new NextLimitedRareCountdownWidget(param2);
               break;
            case "habbomoderationpromo":
               _loc3_ = new HabboModerationPromoWidget(param2);
               break;
            case "habbotalentspromo":
               _loc3_ = new HabboTalentsPromoWidget(param2);
               break;
            case "habbowaypromo":
               _loc3_ = new HabboWayPromoWidget(param2);
               break;
            case "roomhoppernetwork":
               _loc3_ = new RoomHopperNetworkWidget(param2);
               break;
            case "safetyquizpromo":
               _loc3_ = new SafetyQuizPromoWidget(param2);
               break;
            case "generic":
               _loc3_ = new GenericWidget(param2);
               break;
            case "widgetcontainer":
               _loc3_ = new WidgetContainerWidget(param2);
               break;
            case "promoarticle":
               _loc3_ = new PromoArticleWidget(param2);
               break;
            case "bonusrare":
               _loc3_ = new BonusRarePromoWidget(param2);
         }
         return _loc3_;
      }
   }
}

