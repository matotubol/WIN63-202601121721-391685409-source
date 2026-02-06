package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.widgets.class_3087;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_3590;
   
   public class ForumsListView
   {
      
      private var var_55:GroupForumController;
      
      private var var_172:GroupForumView;
      
      private var var_121:IScrollableListWindow;
      
      private var var_3400:class_1812;
      
      private var _forums:Array;
      
      public function ForumsListView(param1:GroupForumView, param2:IScrollableListWindow, param3:Array)
      {
         super();
         var_172 = param1;
         var_55 = var_172.controller;
         var_121 = param2;
         var_3400 = var_55.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_forum_list_item_xml())) as class_1812;
         _forums = param3;
      }
      
      public function update() : void
      {
         var _loc3_:int = 0;
         var _loc2_:class_1812 = null;
         var _loc1_:class_3590 = null;
         var_121.invalidate();
         _loc3_ = 0;
         while(_loc3_ < _forums.length)
         {
            _loc1_ = _forums[_loc3_];
            _loc2_ = var_3400.clone() as class_1812;
            _loc2_.name = "forum_" + _loc1_.groupId;
            updateListItem(_loc2_,_loc1_,_loc3_);
            var_121.addListItem(_loc2_);
            _loc3_++;
         }
         updateItemWidths();
      }
      
      private function updateListItem(param1:class_1812, param2:class_3590, param3:int) : void
      {
         var _loc5_:class_1812 = param1 as class_1812;
         _loc5_.color = (param3 + 1) % 2 ? 4293852927 : 4289914618;
         var _loc6_:int = param2.unreadMessages;
         var _loc9_:class_1741 = _loc5_.findChildByName("texts_container");
         _loc9_.id = param2.groupId;
         var _loc8_:ITextWindow = _loc5_.findChildByName("header") as ITextWindow;
         _loc8_.bold = _loc6_ > 0;
         _loc8_.text = param2.name;
         _loc9_ = _loc5_.findChildByName("header_region");
         _loc9_.id = param2.groupId;
         _loc9_.removeEventListener("WME_CLICK",onOpenForum);
         _loc9_.addEventListener("WME_CLICK",onOpenForum);
         _loc9_ = _loc5_.findChildByName("details");
         _loc9_.caption = var_55.localizationManager.getLocalizationWithParams("groupforum.view.forum_details","","rating",param2.leaderboardScore,"last_author_id",param2.lastMessageAuthorId,"last_author_name",param2.lastMessageAuthorName,"update_time",var_172.getAsDaysHoursMinutes(param2.lastMessageTimeAsSecondsAgo));
         _loc9_ = _loc5_.findChildByName("unread_texts_container");
         _loc9_.id = param2.groupId;
         _loc9_ = _loc5_.findChildByName("unread_region");
         _loc9_.id = param2.groupId;
         _loc9_.removeEventListener("WME_CLICK",onOpenForum);
         _loc9_.addEventListener("WME_CLICK",onOpenForum);
         _loc8_ = _loc5_.findChildByName("messages1") as ITextWindow;
         _loc8_.bold = _loc6_ > 0;
         _loc8_.text = var_55.localizationManager.getLocalizationWithParams("groupforum.view.thread_details1","","total_messages",param2.totalMessages,"new_messages",_loc6_);
         _loc8_ = _loc5_.findChildByName("messages2") as ITextWindow;
         _loc8_.bold = _loc6_ > 0;
         _loc8_.text = var_55.localizationManager.getLocalizationWithParams("groupforum.view.thread_details2","","total_messages",param2.totalMessages,"new_messages",_loc6_);
         var _loc7_:class_2010 = class_2010(_loc5_.findChildByName("group_icon"));
         var _loc4_:class_3087 = _loc7_.widget as class_3087;
         _loc4_.badgeId = param2.icon;
         _loc4_.groupId = param2.groupId;
         _loc4_.type = "group";
      }
      
      public function updateItemWidths() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < var_121.numListItems)
         {
            var_121.getListItemAt(_loc1_).width = var_121.scrollableWindow.width - 2;
            _loc1_++;
         }
      }
      
      private function onOpenForum(param1:WindowMouseEvent) : void
      {
         var_55.openGroupForum(param1.target.id);
      }
   }
}

