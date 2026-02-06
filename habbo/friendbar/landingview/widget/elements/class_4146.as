package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.communication.messages.outgoing.competition.ForwardToRandomCompetitionRoomMessageComposer;
   
   public class class_4146 extends class_4135
   {
      
      private var var_897:String;
      
      public function class_4146()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:class_1741, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         var_897 = param3[2];
      }
      
      override protected function onClick() : void
      {
         landingView.questEngine.reenableRoomCompetitionWindow();
         landingView.send(new ForwardToRandomCompetitionRoomMessageComposer(var_897));
         landingView.tracking.trackGoogle("landingView","click_gotocompetitionroom");
      }
   }
}

