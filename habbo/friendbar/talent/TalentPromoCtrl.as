package com.sulake.habbo.friendbar.talent
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import package_153.class_2665;
   import package_153.class_3659;
   import package_187.class_3707;
   import package_187.class_3807;
   import package_4.class_2005;
   import package_53.class_2595;
   import package_53.class_3520;
   
   public class TalentPromoCtrl implements class_13
   {
      
      private static const BG_COLOR_LIGHT:uint = 4286084205;
      
      private static const BG_COLOR_DARK:uint = 4283781966;
      
      private var var_52:HabboTalent;
      
      private var _window:class_1812;
      
      private var var_2493:int;
      
      private var var_4315:int;
      
      private var var_4284:int;
      
      public function TalentPromoCtrl(param1:HabboTalent)
      {
         super();
         var_52 = param1;
      }
      
      public function dispose() : void
      {
         if(toolbarAttachAllowed())
         {
            var_52.toolbar.extensionView.detachExtension("talent_promo");
         }
         var_52 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_52 == null;
      }
      
      public function initialize() : void
      {
         if(!enabled)
         {
            return;
         }
         var_52.communicationManager.addHabboConnectionMessageEvent(new class_2005(onUserObject));
         var_52.communicationManager.addHabboConnectionMessageEvent(new class_3659(onTalentTrackLevel));
         var_52.communicationManager.addHabboConnectionMessageEvent(new class_2665(onTalentLevelUp));
      }
      
      private function onUserObject(param1:class_2005) : void
      {
         var_52.send(new class_2595(promotedTalentTrack));
      }
      
      private function onTalentTrackLevel(param1:class_3659) : void
      {
         var _loc2_:class_3807 = param1.getParser();
         if(_loc2_.talentTrackName == promotedTalentTrack)
         {
            var_4315 = _loc2_.maxLevel;
            var_2493 = _loc2_.level;
            refresh();
         }
      }
      
      private function onTalentLevelUp(param1:class_2665) : void
      {
         var _loc2_:class_3707 = param1.getParser();
         if(_loc2_.talentTrackName == promotedTalentTrack)
         {
            var_2493 = _loc2_.level;
            refresh();
         }
      }
      
      private function refresh() : void
      {
         if(!enabled || maxLevelReached)
         {
            close();
            return;
         }
         prepareWindow();
         setText("title");
         _window.x = 0;
         _window.y = 0;
         if(toolbarAttachAllowed())
         {
            var_52.toolbar.extensionView.attachExtension("talent_promo",_window,7);
         }
      }
      
      private function setText(param1:String) : void
      {
         _window.findChildByName(param1 + "_txt").caption = "${talentpromo." + promotedTalentTrack + "." + param1 + "}";
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = class_1812(var_52.getXmlWindow("track_promo"));
         _window.addEventListener("WME_CLICK",onCheckProgress);
         _window.addEventListener("WME_OVER",onContainerMouseOver);
         _window.addEventListener("WME_OUT",onContainerMouseOut);
         var_4284 = _window.height;
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            if(toolbarAttachAllowed())
            {
               var_52.toolbar.extensionView.detachExtension("talent_promo");
            }
         }
      }
      
      private function onCheckProgress(param1:class_1758, param2:class_1741 = null) : void
      {
         if(param1.type == "WME_CLICK" && enabled)
         {
            var_52.tracking.trackTalentTrackOpen(promotedTalentTrack,"talentpromo");
            var_52.send(new class_3520(promotedTalentTrack));
         }
      }
      
      private function toolbarAttachAllowed() : Boolean
      {
         return var_52 != null && var_52.toolbar != null && var_52.toolbar.extensionView != null && enabled;
      }
      
      private function get enabled() : Boolean
      {
         return promotedTalentTrack != "";
      }
      
      private function get promotedTalentTrack() : String
      {
         return var_52.getProperty("talentpromo.track");
      }
      
      private function get maxLevelReached() : Boolean
      {
         return var_2493 >= var_4315;
      }
      
      private function onContainerMouseOver(param1:WindowMouseEvent) : void
      {
         _window.findChildByTag("BGCOLOR").color = 4286084205;
      }
      
      private function onContainerMouseOut(param1:WindowMouseEvent) : void
      {
         _window.findChildByTag("BGCOLOR").color = 4283781966;
      }
   }
}

