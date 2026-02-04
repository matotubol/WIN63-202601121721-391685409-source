package com.sulake.habbo.friendbar.landingview.widget.elements
{
   public class class_4137 extends class_4135
   {
      
      public function class_4137()
      {
         super();
      }
      
      override protected function onClick() : void
      {
         landingView.questEngine.reenableRoomCompetitionWindow();
         landingView.navigator.goToHomeRoom();
         landingView.tracking.trackGoogle("landingView","click_gotohomeroom");
      }
   }
}

