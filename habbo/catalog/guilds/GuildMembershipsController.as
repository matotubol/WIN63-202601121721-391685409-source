package com.sulake.habbo.catalog.guilds
{
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.GuildSelectorCatalogWidget;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetGuildMembershipsMessageComposer;
   
   public class GuildMembershipsController
   {
      
      private var _catalog:HabboCatalog;
      
      private var var_769:GuildSelectorCatalogWidget;
      
      public function GuildMembershipsController(param1:HabboCatalog)
      {
         super();
         _catalog = param1;
      }
      
      public function dispose() : void
      {
         _catalog = null;
         var_769 = null;
      }
      
      public function get catalog() : HabboCatalog
      {
         return _catalog;
      }
      
      public function registerGuildSelectorWidget(param1:GuildSelectorCatalogWidget) : void
      {
         var_769 = param1;
         _catalog.connection.send(new GetGuildMembershipsMessageComposer());
      }
      
      public function unregisterGuildSelectorWidget(param1:GuildSelectorCatalogWidget) : void
      {
         if(var_769 == param1)
         {
            var_769 = null;
         }
         else
         {
            class_21.log("ERROR: Tried to unregister a nonregistered group selector catalog widget");
         }
      }
      
      public function onGuildMembershipsMessageEvent(param1:GuildMembershipsMessageEvent) : void
      {
         var _loc2_:Array = param1.guilds.slice(0,param1.guilds.length);
         if(var_769 && !var_769.disposed)
         {
            var_769.populateAndSelectFavorite(_loc2_);
            var_769.selectFirstOffer();
         }
      }
      
      public function onGuildVisualSettingsChanged(param1:int) : void
      {
         if(var_769 != null)
         {
            _catalog.connection.send(new GetGuildMembershipsMessageComposer());
         }
      }
   }
}

