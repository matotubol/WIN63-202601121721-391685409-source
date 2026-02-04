package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.friendlist.class_258;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.session.events.RoomSessionNestBreedingSuccessEvent;
   import com.sulake.habbo.session.events.RoomSessionPetLevelUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionPetStatusUpdateEvent;
   import com.sulake.habbo.session.events.UserNameUpdateEvent;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.avatarinfo.AvatarInfoWidget;
   import com.sulake.habbo.ui.widget.events.RoomWidgetAvatarInfoEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetLevelUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetStatusUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.events.UseProductItem;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetInventoryUpdatedMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUseProductMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   import package_100.class_2515;
   import package_119.class_2662;
   
   public class AvatarInfoWidgetHandler implements IRoomWidgetHandler
   {
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_16:AvatarInfoWidget;
      
      private var var_1272:IMessageEvent;
      
      private var var_1214:IMessageEvent;
      
      public function AvatarInfoWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set widget(param1:AvatarInfoWidget) : void
      {
         var_16 = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_1214 && _container.connection)
            {
               _container.connection.removeMessageEvent(var_1214);
            }
            container = null;
            var_16 = null;
            if(var_1272 != null)
            {
               var_1272.dispose();
               var_1272 = null;
            }
            var_1214 = null;
            _disposed = true;
         }
      }
      
      public function get type() : String
      {
         return "RWE_AVATAR_INFO";
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _container ? _container.roomEngine : null;
      }
      
      public function get roomSession() : IRoomSession
      {
         return _container ? _container.roomSession : null;
      }
      
      public function get friendList() : class_258
      {
         return _container ? _container.friendList : null;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         if(_container && _container.toolbar && _container.toolbar.events)
         {
            _container.toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK",onToolbarClicked);
         }
         if(_container && _container.sessionDataManager && _container.sessionDataManager.events)
         {
            _container.sessionDataManager.events.removeEventListener("unue_name_updated",onUserNameUpdate);
         }
         if(_container && _container.roomSessionManager && _container.roomSessionManager.events)
         {
            _container.roomSessionManager.events.removeEventListener("RSPFUE_PET_STATUS_UPDATE",onPetStatusUpdate);
            _container.roomSessionManager.events.removeEventListener("RSPLUE_PET_LEVEL_UPDATE",onPetLevelUpdate);
            _container.roomSessionManager.events.removeEventListener("RSPFUE_NEST_BREEDING_SUCCESS",onNestBreedingSuccessEvent);
         }
         if(_container && _container.connection)
         {
            _container.connection.removeMessageEvent(var_1272);
         }
         if(_container && _container.connection && var_1214)
         {
            _container.connection.removeMessageEvent(var_1214);
         }
         _container = param1;
         if(param1 == null)
         {
            return;
         }
         if(var_1272 == null)
         {
            var_1272 = new class_2662(onFurniListUpdated);
         }
         if(!var_1214 && _container.connection)
         {
            var_1214 = new class_2515(onCustomUserNotificationMessage);
            _container.connection.addMessageEvent(var_1214);
         }
         if(_container && _container.toolbar && _container.toolbar.events)
         {
            _container.toolbar.events.addEventListener("HTE_TOOLBAR_CLICK",onToolbarClicked);
         }
         if(_container && _container.sessionDataManager && _container.sessionDataManager.events)
         {
            _container.sessionDataManager.events.addEventListener("unue_name_updated",onUserNameUpdate);
         }
         if(_container && _container.roomSessionManager && _container.roomSessionManager.events)
         {
            _container.roomSessionManager.events.addEventListener("RSPFUE_PET_STATUS_UPDATE",onPetStatusUpdate);
            _container.roomSessionManager.events.addEventListener("RSPFUE_NEST_BREEDING_SUCCESS",onNestBreedingSuccessEvent);
            _container.roomSessionManager.events.addEventListener("RSPLUE_PET_LEVEL_UPDATE",onPetLevelUpdate);
         }
         if(_container && _container.connection)
         {
            _container.connection.addMessageEvent(var_1272);
         }
      }
      
      private function onFurniListUpdated(param1:IMessageEvent) : void
      {
         if(_container != null)
         {
            if(_container.events != null)
            {
               _container.events.dispatchEvent(new RoomWidgetInventoryUpdatedMessage("RWIUM_INVENTORY_UPDATED"));
            }
         }
      }
      
      private function onToolbarClicked(param1:HabboToolbarEvent) : void
      {
         if(param1.iconId == "HTIE_ICON_MEMENU")
         {
            if(container.config.getBoolean("simple.memenu.enabled"))
            {
               var_16.selectOwnAvatar();
            }
            else
            {
               dispatchOwnAvatarInfo();
            }
         }
      }
      
      private function onUserNameUpdate(param1:UserNameUpdateEvent) : void
      {
         var_16.close();
      }
      
      private function onPetStatusUpdate(param1:RoomSessionPetStatusUpdateEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc7_:class_2146 = null;
         var _loc5_:RoomWidgetPetStatusUpdateEvent = null;
         if(_container != null && _container.events != null)
         {
            _loc4_ = param1.canBreed;
            _loc2_ = param1.canHarvest;
            _loc6_ = param1.canRevive;
            _loc3_ = param1.hasBreedingPermission;
            _loc7_ = findPetWithWebId(param1.petId);
            if(_loc7_ == null)
            {
               class_21.log("Could not find pet with the id: " + param1.petId + " given by petStatusUpdate");
               return;
            }
            _loc5_ = new RoomWidgetPetStatusUpdateEvent(_loc7_.roomObjectId,_loc4_,_loc2_,_loc6_,_loc3_);
            _container.events.dispatchEvent(_loc5_);
         }
      }
      
      private function onPetLevelUpdate(param1:RoomSessionPetLevelUpdateEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:class_2146 = null;
         var _loc2_:RoomWidgetPetLevelUpdateEvent = null;
         if(_container != null && _container.events != null)
         {
            _loc3_ = param1.level;
            _loc4_ = findPetWithWebId(param1.petId);
            _loc2_ = new RoomWidgetPetLevelUpdateEvent(_loc4_.roomObjectId,_loc3_);
            _container.events.dispatchEvent(_loc2_);
         }
      }
      
      private function dispatchOwnAvatarInfo() : void
      {
         var _loc4_:int = _container.sessionDataManager.userId;
         var _loc3_:String = _container.sessionDataManager.userName;
         var _loc2_:Boolean = _container.sessionDataManager.nameChangeAllowed;
         var _loc1_:class_2146 = _container.roomSession.userDataManager.getUserData(_loc4_);
         if(_loc1_)
         {
            _container.events.dispatchEvent(new RoomWidgetAvatarInfoEvent(_loc4_,_loc3_,_loc1_.type,_loc1_.roomObjectId,_loc2_));
         }
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RWROM_GET_OWN_CHARACTER_INFO");
         _loc1_.push("RWUAM_START_NAME_CHANGE");
         _loc1_.push("RWUAM_REQUEST_PET_UPDATE");
         _loc1_.push("RWUPM_PET_PRODUCT");
         _loc1_.push("RWUAM_REQUEST_BREED_PET");
         _loc1_.push("RWUAM_HARVEST_PET");
         _loc1_.push("RWUAM_REVIVE_PET");
         _loc1_.push("RWUAM_COMPOST_PLANT");
         return _loc1_;
      }
      
      public function getProcessedEvents() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("rsudue_user_data_updated");
         _loc1_.push("RSDE_DANCE");
         _loc1_.push("ROSM_USE_PRODUCT_FROM_INVENTORY");
         _loc1_.push("ROSM_USE_PRODUCT_FROM_ROOM");
         return _loc1_;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var userId:int;
         var userData:class_2146;
         var userAction:RoomWidgetUserActionMessage;
         var useProductMessage:RoomWidgetUseProductMessage;
         var localization:class_27;
         var message:RoomWidgetMessage = param1;
         if(!message)
         {
            return null;
         }
         userId = 0;
         userAction = message as RoomWidgetUserActionMessage;
         if(userAction != null)
         {
            userId = userAction.userId;
         }
         switch(message.type)
         {
            case "RWROM_GET_OWN_CHARACTER_INFO":
               dispatchOwnAvatarInfo();
               break;
            case "RWUAM_START_NAME_CHANGE":
               _container.habboHelp.startNameChange();
               break;
            case "RWUAM_REQUEST_PET_UPDATE":
               var_16.handlePetInfo = false;
               break;
            case "RWUPM_PET_PRODUCT":
               useProductMessage = message as RoomWidgetUseProductMessage;
               if(useProductMessage)
               {
                  _container.roomSession.useProductForPet(useProductMessage.roomObjectId,useProductMessage.petId);
               }
               break;
            case "RWUAM_HARVEST_PET":
               _container.roomSession.harvestPet(userId);
               break;
            case "RWUAM_COMPOST_PLANT":
               localization = var_16.catalog.localization;
               var_16.windowManager.confirm(localization.getLocalization("monsterplant.confirm.title.compost"),localization.getLocalization("monsterplant.confirm.desc.compost"),0,(function():*
               {
                  var onCompostConfirmed:Function;
                  return onCompostConfirmed = function(param1:class_2001, param2:class_1758):void
                  {
                     param1.dispose();
                     if(param2.type == "WE_OK")
                     {
                        _container.roomSession.compostPlant(userId);
                     }
                  };
               })());
               break;
            case "RWUAM_REQUEST_BREED_PET":
               requestBreedMenu(userId);
               break;
            case "RWUAM_REVIVE_PET":
            case "RWIUM_INVENTORY_UPDATED":
         }
         return null;
      }
      
      public function processEvent(param1:Event) : void
      {
         /*
          * Decompilatie fout
          * Code kan worden geobfusceerd
          * Tip: U kunt proberen de optie 'Code deobfusceren' in te schakelen in Instellingen
          * Fout type: ArrayIndexOutOfBoundsException (Index 8 out of bounds for length 8)
          */
         throw new flash.errors.IllegalOperationError("Niet gedecompileerd vanwege een fout");
      }
      
      private function requestBreedMenu(param1:int) : void
      {
         class_21.log("Show breed menu. finally: " + param1);
         if(_container == null || _container.roomSession == null || _container.roomEngine == null)
         {
            return;
         }
         if(_container.roomSession.userDataManager == null)
         {
            return;
         }
         var _loc5_:int = _container.roomSession.roomId;
         var _loc3_:int = _container.sessionDataManager.userId;
         var _loc6_:class_2146 = _container.roomSession.userDataManager.getUserDataByType(param1,2);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc2_:Array = _loc6_.figure.split(" ");
         var _loc4_:int = int(_loc2_.length > 0 ? _loc2_[0] : -1);
         activateBreedMenuForPets(_loc5_,param1,_loc4_,_loc6_.roomObjectId,_loc3_);
      }
      
      public function update() : void
      {
      }
      
      private function onNestBreedingSuccessEvent(param1:RoomSessionNestBreedingSuccessEvent) : void
      {
         if(_container != null && _container.events != null)
         {
            var_16.showNestBreedingSuccess(param1.petId,param1.rarityCategory);
         }
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
      
      private function handleUseProductMenuRequestInventoryItem(param1:int, param2:int) : void
      {
         if(_container == null || _container.roomSession == null || _container.roomEngine == null)
         {
            return;
         }
         if(_container.roomSession.userDataManager == null)
         {
            return;
         }
         var _loc6_:int = _container.roomSession.roomId;
         var _loc3_:int = _container.sessionDataManager.userId;
         var _loc5_:class_1800 = _container.sessionDataManager.getFloorItemData(param2);
         if(!_loc5_)
         {
            return;
         }
         var _loc4_:Array = _loc5_.customParams.split(" ");
         if((int(_loc4_.length > 0 ? parseInt(_loc4_[0]) : -1)) == -1)
         {
            return;
         }
         activateUseProductMenuForPets(_loc6_,param2,-1,_loc5_.category,_loc3_,param1);
      }
      
      private function handleUseProductMenuRequestRoomObject(param1:int) : void
      {
         if(_container == null || _container.roomSession == null || _container.roomEngine == null)
         {
            return;
         }
         if(_container.roomSession.userDataManager == null)
         {
            return;
         }
         var _loc6_:int = _container.roomSession.roomId;
         var _loc7_:IRoomObject = _container.roomEngine.getRoomObject(_loc6_,param1,10);
         var _loc2_:Boolean = _container.isOwnerOfFurniture(_loc7_);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = _container.getFurnitureOwnerId(_loc7_);
         var _loc5_:class_1800 = getFurniData(_loc7_);
         var _loc4_:Array = _loc5_.customParams.split(" ");
         if((int(_loc4_.length > 0 ? parseInt(_loc4_[0]) : -1)) == -1)
         {
            return;
         }
         activateUseProductMenuForPets(_loc6_,param1,-1,_loc5_.category,_loc3_);
      }
      
      private function activateUseProductMenuForPets(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int = -1) : void
      {
         var _loc12_:IRoomObject = null;
         var _loc10_:int = 0;
         var _loc15_:class_2146 = null;
         var _loc9_:Boolean = false;
         var _loc11_:Array = null;
         var _loc7_:int = 0;
         var _loc13_:Array = [];
         var _loc8_:int = _container.roomEngine.getRoomObjectCount(param1,100);
         _loc10_ = 0;
         for(; _loc10_ < _loc8_; _loc10_++)
         {
            _loc12_ = _container.roomEngine.getRoomObjectWithIndex(param1,_loc10_,100);
            _loc15_ = _container.roomSession.userDataManager.getUserDataByIndex(_loc12_.getId());
            _loc9_ = false;
            if(!(_loc15_ == null || _loc15_.type != 2))
            {
               if(_loc15_.ownerId == param5)
               {
                  if(_loc15_.hasSaddle && param4 == 16)
                  {
                     _loc9_ = true;
                  }
                  _loc11_ = _loc15_.figure.split(" ");
                  _loc7_ = int(_loc11_.length > 0 ? _loc11_[0] : -1);
                  if(_loc7_ == param3)
                  {
                     if(param4 == 20)
                     {
                        if(!_loc15_.canRevive)
                        {
                           continue;
                        }
                     }
                     if(param4 == 21)
                     {
                        if(_loc15_.petLevel < 7 || _loc15_.canRevive || _loc15_.canBreed)
                        {
                           continue;
                        }
                     }
                     if(param4 == 22)
                     {
                        if(_loc15_.petLevel >= 7 || _loc15_.canRevive)
                        {
                           continue;
                        }
                     }
                     _loc13_.push(new UseProductItem(_loc15_.roomObjectId,100,_loc15_.name,param2,_loc12_.getId(),param6,_loc9_));
                  }
               }
            }
         }
         var_16.showUseProductMenuForItems(_loc13_);
      }
      
      private function activateBreedMenuForPets(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         var _loc10_:IRoomObject = null;
         var _loc8_:int = 0;
         var _loc13_:class_2146 = null;
         var _loc12_:class_2146 = null;
         var _loc9_:Array = null;
         var _loc6_:int = 0;
         var _loc11_:Array = [];
         var _loc7_:int = _container.roomEngine.getRoomObjectCount(param1,100);
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc10_ = _container.roomEngine.getRoomObjectWithIndex(param1,_loc8_,100);
            _loc13_ = _container.roomSession.userDataManager.getUserDataByIndex(_loc10_.getId());
            if(!(_loc13_ == null || _loc13_.type != 2))
            {
               if(_loc13_.canBreed)
               {
                  if(!(!_loc13_.hasBreedingPermission && _loc13_.ownerId != param5))
                  {
                     _loc12_ = _container.roomSession.userDataManager.getUserData(_loc13_.ownerId);
                     if(_loc12_ != null)
                     {
                        _loc9_ = _loc13_.figure.split(" ");
                        _loc6_ = int(_loc9_.length > 0 ? _loc9_[0] : -1);
                        if(_loc6_ == param3 && _loc13_.roomObjectId != param4)
                        {
                           _loc11_.push(new UseProductItem(_loc13_.roomObjectId,100,_loc13_.name,param4,_loc10_.getId()));
                        }
                     }
                  }
               }
            }
            _loc8_++;
         }
         var_16.showBreedPetMenuForItems(_loc11_);
      }
      
      private function findPetWithWebId(param1:int) : class_2146
      {
         var _loc4_:int = 0;
         var _loc2_:IRoomObject = null;
         var _loc6_:class_2146 = null;
         var _loc5_:int = _container.roomSession.roomId;
         var _loc3_:int = _container.roomEngine.getRoomObjectCount(_loc5_,100);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _container.roomEngine.getRoomObjectWithIndex(_loc5_,_loc4_,100);
            _loc6_ = _container.roomSession.userDataManager.getUserDataByIndex(_loc2_.getId());
            if(!(_loc6_ == null || _loc6_.type != 2))
            {
               if(_loc6_.webID == param1)
               {
                  return _loc6_;
               }
            }
            _loc4_++;
         }
         return null;
      }
      
      public function onCustomUserNotificationMessage(param1:class_2515) : void
      {
         var _loc2_:int = param1.getParser().code;
         switch(_loc2_ - 4)
         {
            case 0:
            case 1:
               _container.sessionDataManager.giveRespectFailed();
         }
      }
   }
}

