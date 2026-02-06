package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
   import com.sulake.habbo.ui.widget.furniture.mysterybox.MysteryBoxToolbarExtension;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUseProductMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.GuildFurniContextMenuInfoMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.JoinHabboGroupMessageComposer;
   import com.sulake.habbo.communication.messages.parser.room.furniture.GuildFurniContextMenuInfoMessageEventParser;
   
   public class FurnitureContextMenuWidgetHandler implements IRoomWidgetHandler
   {
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_16:FurnitureContextMenuWidget;
      
      private var var_37:IConnection;
      
      private var var_1647:IMessageEvent = null;
      
      private var var_2052:MysteryBoxToolbarExtension;
      
      public function FurnitureContextMenuWidgetHandler()
      {
         super();
         var_2052 = new MysteryBoxToolbarExtension(this);
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_2052 != null)
            {
               var_2052.dispose();
               var_2052 = null;
            }
            unsetContainer();
            if(var_37 != null && var_1647)
            {
               var_37.removeMessageEvent(var_1647);
               var_1647 = null;
            }
            var_37 = null;
            var_16 = null;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return null;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _container ? _container.roomEngine : null;
      }
      
      private function unsetContainer() : void
      {
         if(_container != null)
         {
            _container.roomEngine.events.removeEventListener("ROWRE_REQUEST_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG",onMonsterPlantSeedPlantConfirmationDialogRequested);
            _container.roomEngine.events.removeEventListener("ROWRE_REQUEST_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG",onPurchasableClothingConfirmationDialogRequested);
            _container.roomEngine.events.removeEventListener("RETWE_REQUEST_MYSTERYBOX_OPEN_DIALOG",onMysteryBoxOpenDialogRequested);
            _container.roomEngine.events.removeEventListener("RETWE_REQUEST_EFFECTBOX_OPEN_DIALOG",onEffectBoxOpenDialogRequested);
            _container.roomEngine.events.removeEventListener("RETWE_REQUEST_MYSTERYTROPHY_OPEN_DIALOG",onMysteryTrophyOpenDialogRequested);
         }
         _container = null;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         unsetContainer();
         _container = param1;
         if(param1 == null)
         {
            return;
         }
         if(_container.roomEngine != null)
         {
            _container.roomEngine.events.addEventListener("ROWRE_REQUEST_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG",onMonsterPlantSeedPlantConfirmationDialogRequested);
            _container.roomEngine.events.addEventListener("ROWRE_REQUEST_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG",onPurchasableClothingConfirmationDialogRequested);
            _container.roomEngine.events.addEventListener("RETWE_REQUEST_MYSTERYBOX_OPEN_DIALOG",onMysteryBoxOpenDialogRequested);
            _container.roomEngine.events.addEventListener("RETWE_REQUEST_EFFECTBOX_OPEN_DIALOG",onEffectBoxOpenDialogRequested);
            _container.roomEngine.events.addEventListener("RETWE_REQUEST_MYSTERYTROPHY_OPEN_DIALOG",onMysteryTrophyOpenDialogRequested);
         }
      }
      
      public function set widget(param1:FurnitureContextMenuWidget) : void
      {
         var_16 = param1;
         if(_container.config.getBoolean("mysterybox.tracker.active"))
         {
            var_2052.createWindow();
         }
      }
      
      public function set connection(param1:IConnection) : void
      {
         var_37 = param1;
         if(!var_1647)
         {
            var_1647 = new GuildFurniContextMenuInfoMessageEvent(onGuildFurniContextMenuInfo);
            var_37.addMessageEvent(var_1647);
         }
      }
      
      public function get roomSession() : IRoomSession
      {
         return _container ? _container.roomSession : null;
      }
      
      public function getFurniData(param1:IRoomObject) : class_1800
      {
         var _loc2_:class_1800 = null;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc3_ = param1.getModel().getNumber("furniture_type_id");
            _loc2_ = _container.sessionDataManager.getFloorItemData(_loc3_);
         }
         return _loc2_;
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWUPM_MONSTERPLANT_SEED"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:RoomWidgetUseProductMessage = null;
         if(!param1)
         {
            return null;
         }
         var _loc3_:* = param1.type;
         if("RWUPM_MONSTERPLANT_SEED" === _loc3_)
         {
            _loc2_ = param1 as RoomWidgetUseProductMessage;
            if(_loc2_)
            {
               _container.roomSession.plantSeed(_loc2_.roomObjectId);
            }
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RETWE_OPEN_FURNI_CONTEXT_MENU","RETWE_CLOSE_FURNI_CONTEXT_MENU"];
      }
      
      public function processEvent(param1:Event) : void
      {
         if(var_16 == null)
         {
            return;
         }
         var _loc3_:RoomEngineToWidgetEvent = param1 as RoomEngineToWidgetEvent;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:IRoomObject = getRoomObject(_loc3_.objectId);
         if(_loc2_ == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RETWE_OPEN_FURNI_CONTEXT_MENU":
               switch(_loc3_.contextMenu)
               {
                  case "FRIEND_FURNITURE":
                     var_16.showFriendFurnitureContextMenu(_loc2_);
                     break;
                  case "MONSTERPLANT_SEED":
                     if(_container.isOwnerOfFurniture(_loc2_))
                     {
                        var_16.showMonsterPlantSeedContextMenu(_loc2_,_loc3_.category);
                     }
                     break;
                  case "MYSTERY_BOX":
                     var_16.showMysteryBoxContextMenu(_loc2_);
                     break;
                  case "RANDOM_TELEPORT":
                     var_16.showRandomTeleportContextMenu(_loc2_,_loc3_.category);
                     break;
                  case "PURCHASABLE_CLOTHING":
                     var_16.showUsableFurnitureContextMenu(_loc2_,_loc3_.category);
               }
               break;
            case "RETWE_CLOSE_FURNI_CONTEXT_MENU":
               var_16.hideContextMenu(_loc2_);
         }
      }
      
      public function update() : void
      {
      }
      
      public function getObjectRectangle(param1:int) : Rectangle
      {
         return _container.roomEngine.getRoomObjectBoundingRectangle(_container.roomSession.roomId,param1,10,_container.getFirstCanvasId());
      }
      
      public function getObjectScreenLocation(param1:int) : Point
      {
         return _container.roomEngine.getRoomObjectScreenLocation(_container.roomSession.roomId,param1,10,_container.getFirstCanvasId());
      }
      
      public function sendGoToHomeRoomMessage(param1:int) : void
      {
         _container.navigator.goToPrivateRoom(param1);
      }
      
      public function sendJoinToGroupMessage(param1:int) : void
      {
         var_37.send(new JoinHabboGroupMessageComposer(param1));
      }
      
      private function getRoomObject(param1:int) : IRoomObject
      {
         if(_container == null)
         {
            return null;
         }
         return _container.roomEngine.getRoomObject(_container.roomSession.roomId,param1,10);
      }
      
      private function onGuildFurniContextMenuInfo(param1:GuildFurniContextMenuInfoMessageEvent) : void
      {
         var _loc2_:GuildFurniContextMenuInfoMessageEventParser = null;
         var _loc3_:IRoomObject = null;
         if(var_16 != null)
         {
            _loc2_ = param1.getParser();
            _loc3_ = getRoomObject(_loc2_.objectId);
            if(_loc3_ != null)
            {
               var_16.showGuildFurnitureContextMenu(_loc3_,_loc2_.guildId,_loc2_.guildName,_loc2_.guildHomeRoomId,_loc2_.userIsMember,_loc2_.guildHasReadableForum);
            }
         }
      }
      
      private function onMonsterPlantSeedPlantConfirmationDialogRequested(param1:RoomEngineObjectEvent) : void
      {
         if(var_16 != null)
         {
            var _loc3_:IRoomObject = getRoomObject(param1.objectId);
         }
      }
      
      private function onPurchasableClothingConfirmationDialogRequested(param1:RoomEngineObjectEvent) : void
      {
         if(var_16 != null)
         {
            var _loc3_:IRoomObject = getRoomObject(param1.objectId);
         }
      }
      
      private function onEffectBoxOpenDialogRequested(param1:RoomEngineObjectEvent) : void
      {
         if(var_16 != null)
         {
            var _loc3_:IRoomObject = getRoomObject(param1.objectId);
         }
      }
      
      private function onMysteryTrophyOpenDialogRequested(param1:RoomEngineObjectEvent) : void
      {
         if(var_16 != null)
         {
            var _loc3_:IRoomObject = getRoomObject(param1.objectId);
         }
      }
      
      private function onMysteryBoxOpenDialogRequested(param1:RoomEngineObjectEvent) : void
      {
         if(var_16 != null)
         {
            var _loc2_:IRoomObject = getRoomObject(param1.objectId);
         }
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function get widget() : FurnitureContextMenuWidget
      {
         return var_16;
      }
   }
}

