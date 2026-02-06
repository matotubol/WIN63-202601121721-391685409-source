package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.communication.messages.incoming.competition.IsUserPartOfCompetitionMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.competition.ForwardToASubmittableRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.competition.GetIsUserPartOfCompetitionMessageComposer;
   
   public class class_4150 extends class_4135
   {
      
      private var _submittedKey:String;
      
      private var var_897:String;
      
      private var var_3594:Boolean;
      
      private var var_4433:int;
      
      public function class_4150()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:class_1741, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         _submittedKey = param3[2];
         var_897 = param3[3];
         param1.communicationManager.addHabboConnectionMessageEvent(new IsUserPartOfCompetitionMessageEvent(onInfo));
      }
      
      override public function refresh() : void
      {
         super.refresh();
         landingView.send(new GetIsUserPartOfCompetitionMessageComposer(var_897));
      }
      
      override protected function onClick() : void
      {
         landingView.questEngine.reenableRoomCompetitionWindow();
         if(var_3594)
         {
            landingView.navigator.goToPrivateRoom(var_4433);
            landingView.tracking.trackGoogle("landingView","click_submittedroom");
         }
         else
         {
            landingView.send(new ForwardToASubmittableRoomMessageComposer());
            landingView.tracking.trackGoogle("landingView","click_startsubmit");
         }
      }
      
      private function onInfo(param1:IsUserPartOfCompetitionMessageEvent) : void
      {
         var_3594 = param1.getParser().isPartOf;
         var_4433 = param1.getParser().targetId;
         if(var_3594)
         {
            window.caption = "${" + _submittedKey + "}";
         }
      }
   }
}

