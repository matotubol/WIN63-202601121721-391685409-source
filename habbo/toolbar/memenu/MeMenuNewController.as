package com.sulake.habbo.toolbar.memenu
{
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.navigator.class_41;
   import com.sulake.habbo.toolbar.BottomBarLeft;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.toolbar.abstractsubmenu.AbstractSubMenuController;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   
   public class MeMenuNewController extends AbstractSubMenuController
   {
      
      public static const USE_GUIDE_TOOL:String = "USE_GUIDE_TOOL";
      
      private var var_2938:MeMenuNewIconLoader;
      
      private var var_482:MeMenuSettingsMenuView;
      
      public function MeMenuNewController(param1:HabboToolbar, param2:BottomBarLeft)
      {
         super(param1,param2,"me_menu_new_view_xml","HTIE_ICON_MEMENU");
         if(!param1.getBoolean("guides.enabled"))
         {
            setGuideToolVisibility(false);
         }
         if(!param1.getBoolean("classic.collectibles.hub.enabled") || !param1.getBoolean("collectibles.hub.enabled"))
         {
            setCollectiblesVisibility(false);
         }
         setMinimailVisibility(false);
         var_2938 = new MeMenuNewIconLoader(param1);
      }
      
      override protected function onSubMenuItemClick(param1:String) : void
      {
         switch(param1)
         {
            case "profile":
               toolbar.connection.send(new GetExtendedProfileMessageComposer(toolbar.sessionDataManager.userId));
               break;
            case "minimail":
               HabboWebTools.openMinimail("#mail/inbox/");
               break;
            case "rooms":
               var _loc2_:class_41 = toolbar.navigator;
               break;
            case "talents":
               var _loc3_:String = toolbar.sessionDataManager.currentTalentTrack;
               toolbar.connection.send(new GetTalentTrackMessageComposer(null));
               break;
            case "achievements":
               toolbar.questEngine.showAchievements();
               break;
            case "guide":
               toolbar.toggleWindowVisibility("GUIDE");
               break;
            case "clothes":
               toolbar.context.createLinkEvent("avatareditor/open");
               break;
            case "forums":
               toolbar.context.createLinkEvent("groupforum/list/my");
               break;
            case "collectibles":
               toolbar.context.createLinkEvent("collectibles/open");
               break;
            case "settings":
         }
      }
      
      override protected function onToolbarClick(param1:HabboToolbarEvent) : void
      {
         super.onToolbarClick(param1);
         if(param1.iconId != "HTIE_ICON_MEMENU")
         {
            if(var_482 != null)
            {
               var_482.dispose();
               var_482 = null;
            }
         }
      }
      
      private function setGuideToolVisibility(param1:Boolean) : void
      {
         var _loc2_:class_1741 = window.findChildByName("guide");
         _loc2_.visible = param1;
         window.height = param1 ? _loc2_.bottom + 5 : window.findChildByName("profile").bottom + 5;
      }
      
      private function setCollectiblesVisibility(param1:Boolean) : void
      {
         window.findChildByName("collectibles").visible = param1;
      }
      
      private function setMinimailVisibility(param1:Boolean) : void
      {
         window.findChildByName("minimail").visible = param1;
      }
      
      override public function toggleVisibility() : void
      {
         var _loc1_:Boolean = false;
         super.toggleVisibility();
         if(var_482 != null)
         {
            var_482.dispose();
            var_482 = null;
         }
         if(window.visible)
         {
            if(!toolbar.getBoolean("talent.track.enabled"))
            {
               window.findChildByName("talents").visible = false;
            }
            if(toolbar.getBoolean("guides.enabled"))
            {
               _loc1_ = toolbar.sessionDataManager.isPerkAllowed("USE_GUIDE_TOOL");
               setGuideToolVisibility(_loc1_);
            }
         }
         reposition();
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_482 != null)
         {
            var_482.dispose();
            var_482 = null;
         }
         var_2938.dispose();
         var_2938 = null;
         super.dispose();
      }
      
      public function set unseenMinimailsCount(param1:int) : void
      {
         setUnseenItemCount("minimail",param1);
      }
      
      public function set unseenForumsCount(param1:int) : void
      {
         setUnseenItemCount("forums",param1);
      }
   }
}

