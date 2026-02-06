package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetCommunityGoalProgressMessageComposer;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalProgressMessageEvent;
   
   public class HabboWayPromoWidget implements ILandingViewWidget
   {
      
      private var _landingView:HabboLandingView;
      
      private var _container:class_1812;
      
      private var var_5160:int;
      
      public function HabboWayPromoWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public function get container() : class_1741
      {
         return _container;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _container = null;
      }
      
      public function initialize() : void
      {
         _container = class_1812(_landingView.getXmlWindow("habbo_way_promo"));
         _container.findChildByName("go_button").procedure = onGoButton;
         _landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
      }
      
      public function refresh() : void
      {
         _landingView.send(new GetCommunityGoalProgressMessageComposer());
         refreshContent();
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      private function onGoButton(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.habboHelp.showHabboWay();
         }
      }
      
      private function onCommunityGoalProgress(param1:CommunityGoalProgressMessageEvent) : void
      {
         var_5160 = param1.getParser().data.communityTotalScore;
         refreshContent();
      }
      
      private function refreshContent() : void
      {
         var _loc1_:String = "" + var_5160;
         while(_loc1_.length < 8)
         {
            _loc1_ = "0" + _loc1_;
         }
         _container.findChildByName("counter_txt").caption = _loc1_;
      }
   }
}

