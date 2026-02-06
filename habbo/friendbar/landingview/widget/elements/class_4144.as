package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredRewardResultMessageEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.class_4118;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.IsBadgeRequestFulfilledEvent;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetIsBadgeRequestFulfilledComposer;
   
   public class class_4144 extends class_4135 implements class_4118
   {
      
      private var var_2106:String;
      
      private var var_3848:Boolean = true;
      
      public function class_4144()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:class_1741, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         var_2106 = param3[2];
         param2.x = int(param3[3]);
         param2.y = int(param3[4]);
         if(param3.length > 5)
         {
            var_3848 = param3[5] == "true";
         }
         param1.communicationManager.addHabboConnectionMessageEvent(new IsBadgeRequestFulfilledEvent(onInfo));
         param1.communicationManager.addHabboConnectionMessageEvent(new WiredRewardResultMessageEvent(onReward));
      }
      
      override protected function onClick() : void
      {
         landingView.requestBadge(var_2106);
         landingView.tracking.trackGoogle("landingView","click_requestbadge_" + var_2106);
      }
      
      override public function refresh() : void
      {
         super.refresh();
         landingView.send(new GetIsBadgeRequestFulfilledComposer(var_2106));
      }
      
      public function isFloating(param1:Boolean) : Boolean
      {
         return var_3848;
      }
      
      private function onInfo(param1:IsBadgeRequestFulfilledEvent) : void
      {
         if(param1.getParser().requestCode == var_2106)
         {
            window.visible = !param1.getParser().fulfilled;
         }
      }
      
      private function onReward(param1:WiredRewardResultMessageEvent) : void
      {
         if(window)
         {
            landingView.send(new GetIsBadgeRequestFulfilledComposer(var_2106));
         }
      }
   }
}

