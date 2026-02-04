package com.sulake.habbo.toolbar.progmenu
{
   import com.sulake.habbo.toolbar.BottomBarLeft;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.toolbar.abstractsubmenu.AbstractSubMenuController;
   
   public class ProgMenuController extends AbstractSubMenuController
   {
      
      public function ProgMenuController(param1:HabboToolbar, param2:BottomBarLeft)
      {
         super(param1,param2,"prog_menu_view_xml","HTIE_ICON_PROGRESSION");
         if(param1.getBoolean("toolbar.hide.quests"))
         {
            setQuestsVisibility(false);
         }
         if(!param1.getBoolean("dailytasks.enabled"))
         {
            setDailyTasksVisibility(false);
         }
      }
      
      override protected function onSubMenuItemClick(param1:String) : void
      {
         switch(param1)
         {
            case "achievements":
               toolbar.questEngine.showAchievements();
               break;
            case "dailytasks":
               toolbar.context.createLinkEvent("dailytasks/open");
               break;
            case "quests":
               toolbar.questEngine.showQuests();
         }
      }
      
      private function setQuestsVisibility(param1:Boolean) : void
      {
         window.findChildByName("quests").visible = param1;
      }
      
      private function setDailyTasksVisibility(param1:Boolean) : void
      {
         window.findChildByName("dailytasks").visible = param1;
      }
      
      public function set unseenAchievementsCount(param1:int) : void
      {
         setUnseenItemCount("achievements",param1);
      }
      
      public function set unseenDailyTaskCount(param1:int) : void
      {
         setUnseenItemCount("dailytasks",param1);
      }
   }
}

