package com.sulake.habbo.navigator
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.window.widgets.class_3087;
   import package_42.class_1945;
   import package_9.class_1796;
   
   public class GuildInfoCtrl implements class_13
   {
      
      private static const GUILD_INFO_NAME:String = "guild_info";
      
      private var _navigator:class_42;
      
      private var _groupId:int;
      
      public function GuildInfoCtrl(param1:class_42)
      {
         super();
         _navigator = param1;
      }
      
      public function dispose() : void
      {
         _navigator = null;
      }
      
      public function get disposed() : Boolean
      {
         return _navigator == null;
      }
      
      public function refresh(param1:class_1812, param2:class_1945, param3:Boolean = false) : void
      {
         var _loc5_:class_1812 = class_1812(param1.findChildByName("guild_info"));
         if(_loc5_ == null)
         {
            _loc5_ = class_1812(_navigator.getXmlWindow("guild_info"));
            _loc5_.name = "guild_info";
            param1.addChild(_loc5_);
            _loc5_.addEventListener("WME_CLICK",onGuildInfo);
         }
         if(param2 == null || param2.habboGroupId < 1)
         {
            _loc5_.visible = false;
            return;
         }
         _loc5_.visible = true;
         _navigator.registerParameter("navigator.guildbase","groupName",param2.groupName);
         _loc5_.findChildByName("guild_base_txt").caption = _navigator.getText("navigator.guildbase");
         var _loc4_:class_3087 = class_2010(param1.findChildByName("guild_badge")).widget as class_3087;
         _loc4_.badgeId = param2.groupBadgeCode;
         _loc4_.groupId = param2.habboGroupId;
         _groupId = param2.habboGroupId;
      }
      
      private function onGuildInfo(param1:class_1758) : void
      {
         _navigator.send(new class_1796(_groupId,true));
      }
   }
}

