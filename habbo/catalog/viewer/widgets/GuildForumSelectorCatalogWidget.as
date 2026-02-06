package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.catalog.guilds.GuildMembershipsController;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetShowWarningTextEvent;
   import com.sulake.habbo.communication.messages.incoming.users.class_3489;
   
   public class GuildForumSelectorCatalogWidget extends GuildSelectorCatalogWidget
   {
      
      public function GuildForumSelectorCatalogWidget(param1:class_1812, param2:GuildMembershipsController)
      {
         super(param1,param2);
      }
      
      override protected function filterGroupMemberships(param1:Array) : Array
      {
         var _loc2_:Array = [];
         var _loc4_:int = var_1365.catalog.sessionDataManager.userId;
         var _loc3_:Boolean = var_1365.catalog.sessionDataManager.hasSecurity(4);
         for each(var _loc5_ in param1)
         {
            if(!(!_loc5_.hasForum && _loc5_.ownerId != _loc4_ && !_loc3_))
            {
               _loc2_.push(_loc5_);
            }
         }
         return _loc2_;
      }
      
      override protected function selectGroup(param1:class_3489) : void
      {
         super.selectGroup(param1);
         events.dispatchEvent(new CatalogWidgetShowWarningTextEvent(param1.hasForum ? "${catalog.alert.group_has_forum}" : ""));
      }
   }
}

