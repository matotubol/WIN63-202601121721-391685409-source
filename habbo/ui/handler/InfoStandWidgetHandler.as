package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.friendlist.class_1927;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.room.object.data.class_2035;
   import com.sulake.habbo.session.IPetInfo;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.session.events.RoomSessionConfirmPetBreedingEvent;
   import com.sulake.habbo.session.events.RoomSessionConfirmPetBreedingResultEvent;
   import com.sulake.habbo.session.events.RoomSessionFavouriteGroupUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionPetBreedingEvent;
   import com.sulake.habbo.session.events.RoomSessionPetBreedingResultEvent;
   import com.sulake.habbo.session.events.RoomSessionPetCommandsUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionPetFigureUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionPetInfoUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionUserBadgesEvent;
   import com.sulake.habbo.session.events.RoomSessionUserFigureUpdateEvent;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.class_1912;
   import com.sulake.habbo.sound.class_3073;
   import com.sulake.habbo.sound.events.NowPlayingEvent;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.BreedingRarityCategoryData;
   import com.sulake.habbo.ui.widget.events.ConfirmPetBreedingPetData;
   import com.sulake.habbo.ui.widget.events.PetBreedingResultEventData;
   import com.sulake.habbo.ui.widget.events.RoomWidgetChatInputContentUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetConfirmPetBreedingEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetConfirmPetBreedingResultEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetBreedingEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetBreedingResultEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetCommandsUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetFigureUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectNameEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetSongUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.infostand.InfoStandFurniData;
   import com.sulake.habbo.ui.widget.infostand.InfoStandWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChangeMottoMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeDetailsMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeImageMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPetCommandMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPresentOpenMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomTagSearchMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.habbo.utils.class_2262;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.DropCarryItemMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.PassCarryItemToPetMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.PassCarryItemMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.users.class_1846;
   import com.sulake.habbo.communication.messages.incoming.users.RelationshipStatusInfoEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_3348;
   import com.sulake.habbo.communication.messages.incoming.room.pets.class_3889;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.SetObjectDataMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.GiveSupplementToPetMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.pets.RespectPetMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.pets.PetSelectedMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetRelationshipStatusInfoMessageComposer;
   
   public class InfoStandWidgetHandler implements IRoomWidgetHandler
   {
      
      private var var_1134:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_814:class_55 = new class_55();
      
      private var var_424:class_1912;
      
      private var var_16:InfoStandWidget;
      
      private var var_1603:IMessageEvent;
      
      private var var_1614:IMessageEvent;
      
      public function InfoStandWidgetHandler(param1:class_1912)
      {
         super();
         var_424 = param1;
         if(var_424 != null)
         {
            var_424.events.addEventListener("NPE_SONG_CHANGED",onNowPlayingChanged);
            var_424.events.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
         }
      }
      
      public function set widget(param1:InfoStandWidget) : void
      {
         var_16 = param1;
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get type() : String
      {
         return "RWE_INFOSTAND";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         if(_container != null)
         {
            if(_container.roomSessionManager != null)
            {
               _container.roomSessionManager.events.removeEventListener("RSUBE_FIGURE",onFigureUpdate);
               _container.roomSessionManager.events.removeEventListener("RSPIUE_PET_INFO",onPetInfo);
               _container.roomSessionManager.events.removeEventListener("RSPIUE_ENABLED_PET_COMMANDS",onPetCommands);
               _container.roomSessionManager.events.removeEventListener("rsfgue_favourite_group_update",onFavouriteGroupUpdated);
               _container.roomSessionManager.events.removeEventListener("RSPFUE_PET_FIGURE_UPDATE",onPetFigureUpdate);
               _container.roomSessionManager.events.removeEventListener("RSPFUE_PET_BREEDING_RESULT",onPetBreedingResult);
               _container.roomSessionManager.events.removeEventListener("RSPFUE_PET_BREEDING",onPetBreedingEvent);
               _container.roomSessionManager.events.removeEventListener("RSPFUE_CONFIRM_PET_BREEDING",onConfirmPetBreedingEvent);
               _container.roomSessionManager.events.removeEventListener("RSPFUE_CONFIRM_PET_BREEDING_RESULT",onConfirmPetBreedingResultEvent);
            }
            if(_container.connection != null)
            {
               if(var_1603 != null)
               {
                  _container.connection.removeMessageEvent(var_1603);
                  var_1603.dispose();
                  var_1603 = null;
               }
               if(var_1614 != null)
               {
                  _container.connection.removeMessageEvent(var_1614);
                  var_1614.dispose();
                  var_1614 = null;
               }
            }
         }
         _container = param1;
         if(param1 == null)
         {
            return;
         }
         if(_container.roomSessionManager != null)
         {
            _container.roomSessionManager.events.addEventListener("RSUBE_FIGURE",onFigureUpdate);
            _container.roomSessionManager.events.addEventListener("RSPIUE_PET_INFO",onPetInfo);
            _container.roomSessionManager.events.addEventListener("RSPIUE_ENABLED_PET_COMMANDS",onPetCommands);
            _container.roomSessionManager.events.addEventListener("rsfgue_favourite_group_update",onFavouriteGroupUpdated);
            _container.roomSessionManager.events.addEventListener("RSPFUE_PET_FIGURE_UPDATE",onPetFigureUpdate);
            _container.roomSessionManager.events.addEventListener("RSPFUE_PET_BREEDING_RESULT",onPetBreedingResult);
            _container.roomSessionManager.events.addEventListener("RSPFUE_PET_BREEDING",onPetBreedingEvent);
            _container.roomSessionManager.events.addEventListener("RSPFUE_CONFIRM_PET_BREEDING",onConfirmPetBreedingEvent);
            _container.roomSessionManager.events.addEventListener("RSPFUE_CONFIRM_PET_BREEDING_RESULT",onConfirmPetBreedingResultEvent);
         }
         if(_container.connection)
         {
            var_1603 = new HabboGroupDetailsMessageEvent(onGroupDetails);
            _container.connection.addMessageEvent(var_1603);
            var_1614 = new RelationshipStatusInfoEvent(onRelationshipStatusEvent);
            _container.connection.addMessageEvent(var_1614);
         }
      }
      
      private function onGroupDetails(param1:HabboGroupDetailsMessageEvent) : void
      {
         var _loc2_:class_1846 = param1.data;
         if(var_16.furniData.groupId == _loc2_.groupId)
         {
            var_16.furniView.groupBadgeId = _loc2_.badgeCode;
            var_16.furniView.groupName = _loc2_.groupName;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:BitmapData = null;
         if(var_814 != null)
         {
            _loc1_ = var_814.length - 1;
            while(_loc1_ >= 0)
            {
               _loc2_ = var_814.getWithIndex(_loc1_);
               if(_loc2_)
               {
                  _loc2_.dispose();
               }
               _loc2_ = null;
               _loc1_--;
            }
            var_814.dispose();
            var_814 = null;
         }
         if(var_424 != null)
         {
            var_424.events.removeEventListener("NPE_SONG_CHANGED",onNowPlayingChanged);
            var_424.events.removeEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
            var_424 = null;
         }
         var_1134 = true;
         container = null;
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RWROM_GET_OBJECT_INFO");
         _loc1_.push("RWROM_GET_OBJECT_NAME");
         _loc1_.push("RWUAM_SEND_FRIEND_REQUEST");
         _loc1_.push("RWUAM_RESPECT_USER");
         _loc1_.push("RWUAM_REPLENISH_RESPECT_USER");
         _loc1_.push("RWUAM_WIRED_INSPECT");
         _loc1_.push("RWUAM_WIRED_INSPECT_PET");
         _loc1_.push("RWUAM_WIRED_INSPECT_BOT");
         _loc1_.push("RWUAM_OPEN_PROFILE");
         _loc1_.push("RWUAM_WHISPER_USER");
         _loc1_.push("RWUAM_IGNORE_USER");
         _loc1_.push("RWUAM_UNIGNORE_USER");
         _loc1_.push("RWUAM_KICK_USER");
         _loc1_.push("RWUAM_BAN_USER_DAY");
         _loc1_.push("RWUAM_BAN_USER_HOUR");
         _loc1_.push("RWUAM_BAN_USER_PERM");
         _loc1_.push("RWUAM_MUTE_USER_2MIN");
         _loc1_.push("RWUAM_MUTE_USER_5MIN");
         _loc1_.push("RWUAM_MUTE_USER_10MIN");
         _loc1_.push("RWUAM_GIVE_RIGHTS");
         _loc1_.push("RWUAM_TAKE_RIGHTS");
         _loc1_.push("RWUAM_START_TRADING");
         _loc1_.push("RWUAM_OPEN_HOME_PAGE");
         _loc1_.push("RWUAM_PASS_CARRY_ITEM");
         _loc1_.push("RWUAM_GIVE_CARRY_ITEM_TO_PET");
         _loc1_.push("RWUAM_DROP_CARRY_ITEM");
         _loc1_.push("RWFAM_MOVE");
         _loc1_.push("RWFUAM_ROTATE");
         _loc1_.push("RWFAM_PICKUP");
         _loc1_.push("RWFAM_EJECT");
         _loc1_.push("RWFAM_USE");
         _loc1_.push("RWFAM_SAVE_STUFF_DATA");
         _loc1_.push("RWFAM_WIRED_INSPECT");
         _loc1_.push("RWRTSM_ROOM_TAG_SEARCH");
         _loc1_.push("RWGOI_MESSAGE_GET_BADGE_DETAILS");
         _loc1_.push("RWGOI_MESSAGE_GET_BADGE_IMAGE");
         _loc1_.push("RWUAM_REPORT");
         _loc1_.push("RWUAM_PICKUP_PET");
         _loc1_.push("RWUAM_MOUNT_PET");
         _loc1_.push("RWUAM_TOGGLE_PET_RIDING_PERMISSION");
         _loc1_.push("RWUAM_TOGGLE_PET_BREEDING_PERMISSION");
         _loc1_.push("RWUAM_DISMOUNT_PET");
         _loc1_.push("RWUAM_SADDLE_OFF");
         _loc1_.push("RWUAM_TRAIN_PET");
         _loc1_.push("RWPCM_PET_COMMAND");
         _loc1_.push("RWPCM_REQUEST_PET_COMMANDS");
         _loc1_.push(" RWUAM_RESPECT_PET");
         _loc1_.push("RWUAM_REQUEST_PET_UPDATE");
         _loc1_.push("RWVM_CHANGE_MOTTO_MESSAGE");
         _loc1_.push("RWOPEM_OPEN_USER_PROFILE");
         _loc1_.push("RWPOM_OPEN_PRESENT");
         _loc1_.push("RWUAM_GIVE_LIGHT_TO_PET");
         _loc1_.push("RWUAM_GIVE_WATER_TO_PET");
         _loc1_.push("RWUAM_TREAT_PET");
         _loc1_.push("RWUAM_REPORT_CFH_OTHER");
         _loc1_.push("RWUAM_AMBASSADOR_ALERT_USER");
         _loc1_.push("RWUAM_AMBASSADOR_KICK_USER");
         _loc1_.push("RWUAM_AMBASSADOR_MUTE_2MIN");
         _loc1_.push("RWUAM_AMBASSADOR_MUTE_10MIN");
         _loc1_.push("RWUAM_AMBASSADOR_MUTE_15MIN");
         _loc1_.push("RWUAM_AMBASSADOR_MUTE_60MIN");
         _loc1_.push("RWUAM_AMBASSADOR_MUTE_18HOUR");
         _loc1_.push("RWUAM_AMBASSADOR_MUTE_36HOUR");
         _loc1_.push("RWUAM_AMBASSADOR_MUTE_72HOUR");
         _loc1_.push("RWUAM_AMBASSADOR_UNMUTE");
         return _loc1_;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:class_2146 = null;
         var _loc8_:String = null;
         _loc8_ = null;
         if(param1 == null)
         {
            return null;
         }
         if(_container == null)
         {
            return null;
         }
         var _loc22_:int = 0;
         var _loc15_:RoomWidgetUserActionMessage = param1 as RoomWidgetUserActionMessage;
         if(_loc15_ != null)
         {
            _loc22_ = _loc15_.userId;
            if(param1.type == "RWUAM_REQUEST_PET_UPDATE" || param1.type == " RWUAM_RESPECT_PET" || param1.type == "RWUAM_PICKUP_PET" || param1.type == "RWUAM_WIRED_INSPECT_PET" || param1.type == "RWUAM_MOUNT_PET" || param1.type == "RWUAM_TOGGLE_PET_RIDING_PERMISSION" || param1.type == "RWUAM_TOGGLE_PET_BREEDING_PERMISSION" || param1.type == "RWUAM_DISMOUNT_PET" || param1.type == "RWUAM_SADDLE_OFF" || param1.type == "RWUAM_GIVE_CARRY_ITEM_TO_PET" || param1.type == "RWUAM_GIVE_WATER_TO_PET" || param1.type == "RWUAM_GIVE_LIGHT_TO_PET" || param1.type == "RWUAM_TREAT_PET")
            {
               _loc2_ = _container.roomSession.userDataManager.getPetUserData(_loc22_);
            }
            else
            {
               while(true)
               {
                  if(param1.type == "RWUAM_WIRED_INSPECT_BOT")
                  {
                     _loc2_ = _container.roomSession.userDataManager.getRentableBotUserData(_loc22_);
                  }
                  else
                  {
                     _loc2_ = _container.roomSession.userDataManager.getUserData(_loc22_);
                  }
               }
               §§goto(addr013e);
            }
            if(_loc2_ == null)
            {
               return null;
            }
         }
         addr013e:
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc27_:RoomWidgetFurniActionMessage = param1 as RoomWidgetFurniActionMessage;
         if(_loc27_ != null)
         {
            _loc19_ = _loc27_.furniId;
            _loc20_ = _loc27_.furniCategory;
         }
         switch(param1.type)
         {
            case "RWROM_GET_OBJECT_INFO":
               return handleGetObjectInfoMessage(param1 as RoomWidgetRoomObjectMessage);
            case "RWROM_GET_OBJECT_NAME":
               return handleGetObjectNameMessage(param1 as RoomWidgetRoomObjectMessage);
            case "RWUAM_SEND_FRIEND_REQUEST":
               _container.friendList.askForAFriend(_loc22_,_loc2_.name);
               break;
            case "RWUAM_RESPECT_USER":
               _container.sessionDataManager.giveRespect(_loc22_);
               break;
            case "RWUAM_REPLENISH_RESPECT_USER":
               var _loc23_:int = _container.catalog.getPurse().getActivityPointsForType(0);
               var _loc18_:int = container.config.getInteger("respect.replenish_cost_duckets",50);
               container.windowManager.confirm("${respect.replenish.title}",_container.localization.getLocalizationWithParams("respect.replenish.desc","","amount",0),0,onRespectReplenishClicked);
               break;
            case "RWUAM_WIRED_INSPECT":
            case "RWUAM_WIRED_INSPECT_BOT":
            case "RWUAM_WIRED_INSPECT_PET":
               _loc8_ = "wiredmenu/open/inspection/1/" + _loc2_.roomObjectId;
               (_container.roomEngine as class_17).context.createLinkEvent(_loc8_);
               break;
            case "RWUAM_OPEN_PROFILE":
               _container.connection.send(new GetExtendedProfileMessageComposer(_loc2_.webID));
               break;
            case " RWUAM_RESPECT_PET":
               _container.sessionDataManager.givePetRespect(_loc22_);
               break;
            case "RWUAM_WHISPER_USER":
               var _loc6_:RoomWidgetChatInputContentUpdateEvent = new RoomWidgetChatInputContentUpdateEvent("whisper",_loc2_.name);
               _container.events.dispatchEvent(null);
               break;
            case "RWUAM_IGNORE_USER":
               _container.sessionDataManager.ignoreUser(_loc2_.webID);
               break;
            case "RWUAM_UNIGNORE_USER":
               _container.sessionDataManager.unignoreUser(_loc2_.webID);
               break;
            case "RWUAM_KICK_USER":
               _container.roomSession.kickUser(_loc2_.webID);
               break;
            case "RWUAM_BAN_USER_DAY":
            case "RWUAM_BAN_USER_HOUR":
            case "RWUAM_BAN_USER_PERM":
               _container.roomSession.banUserWithDuration(_loc2_.webID,param1.type);
               break;
            case "RWUAM_MUTE_USER_2MIN":
               _container.roomSession.muteUser(_loc2_.webID,2);
               break;
            case "RWUAM_MUTE_USER_5MIN":
               _container.roomSession.muteUser(_loc2_.webID,5);
               break;
            case "RWUAM_MUTE_USER_10MIN":
               _container.roomSession.muteUser(_loc2_.webID,10);
               break;
            case "RWUAM_GIVE_RIGHTS":
               _container.roomSession.assignRights(_loc2_.webID);
               break;
            case "RWUAM_TAKE_RIGHTS":
               _container.roomSession.removeRights(_loc2_.webID);
               break;
            case "RWUAM_START_TRADING":
               var _loc3_:class_2146 = _container.roomSession.userDataManager.getUserData(_loc15_.userId);
               _container.inventory.setupTrading(null.roomObjectId,null.name);
               break;
            case "RWUAM_OPEN_HOME_PAGE":
               _container.sessionDataManager.openHabboHomePage(_loc2_.webID,_loc2_.name);
               break;
            case "RWUAM_PICKUP_PET":
               _container.roomSession.pickUpPet(_loc22_);
               break;
            case "RWUAM_MOUNT_PET":
               _container.roomSession.mountPet(_loc22_);
               break;
            case "RWUAM_TOGGLE_PET_RIDING_PERMISSION":
               _container.roomSession.togglePetRidingPermission(_loc22_);
               break;
            case "RWUAM_TOGGLE_PET_BREEDING_PERMISSION":
               _container.roomSession.togglePetBreedingPermission(_loc22_);
               break;
            case "RWUAM_DISMOUNT_PET":
               _container.roomSession.dismountPet(_loc22_);
               break;
            case "RWUAM_SADDLE_OFF":
               _container.roomSession.removeSaddleFromPet(_loc22_);
               break;
            case "RWUAM_PASS_CARRY_ITEM":
               _container.connection.send(new PassCarryItemMessageComposer(_loc22_));
               break;
            case "RWUAM_GIVE_CARRY_ITEM_TO_PET":
               _container.connection.send(new PassCarryItemToPetMessageComposer(_loc22_));
               break;
            case "RWUAM_GIVE_WATER_TO_PET":
               _container.connection.send(new GiveSupplementToPetMessageComposer(_loc22_,0));
               break;
            case "RWUAM_GIVE_LIGHT_TO_PET":
               _container.connection.send(new GiveSupplementToPetMessageComposer(_loc22_,1));
               break;
            case "RWUAM_TREAT_PET":
               _container.connection.send(new RespectPetMessageComposer(_loc22_));
               break;
            case "RWUAM_DROP_CARRY_ITEM":
               _container.connection.send(new DropCarryItemMessageComposer());
               break;
            case "RWFUAM_ROTATE":
               _container.roomEngine.modifyRoomObject(_loc19_,_loc20_,"OBJECT_ROTATE_POSITIVE");
               break;
            case "RWFAM_MOVE":
               _container.roomEngine.modifyRoomObject(_loc19_,_loc20_,"OBJECT_MOVE");
               break;
            case "RWFAM_PICKUP":
               pickupObjectWithConfirmation(_loc19_,_loc20_);
               break;
            case "RWFAM_EJECT":
               _container.roomEngine.modifyRoomObject(_loc19_,_loc20_,"OBJECT_EJECT");
               break;
            case "RWFAM_USE":
               _container.roomEngine.useRoomObjectInActiveRoom(_loc19_,_loc20_);
               break;
            case "RWFAM_WIRED_INSPECT":
               _loc8_ = "wiredmenu/open/inspection/0/";
               if(_loc20_ == 10)
               {
                  _loc8_ += String(_loc19_);
               }
               else
               {
                  if(_loc20_ != 20)
                  {
                     break;
                  }
                  _loc8_ += String(-_loc19_);
               }
               (_container.roomEngine as class_17).context.createLinkEvent(_loc8_);
               break;
            case "RWFAM_SAVE_STUFF_DATA":
               var _loc7_:String = _loc27_.objectData;
               if(_loc7_ != null)
               {
                  var _loc25_:class_55 = new class_55();
                  var _loc4_:Array = null.split("\t");
                  if(_loc4_ != null)
                  {
                     for each(var _loc14_ in null)
                     {
                        var _loc5_:Array = _loc14_.split("=",2);
                        if(_loc5_ != null && null.length == 2)
                        {
                           var _loc13_:String = null[0];
                           var _loc12_:String = null[1];
                           null.add(null,null);
                        }
                     }
                  }
                  _container.roomEngine.modifyRoomObjectDataWithMap(_loc19_,_loc20_,"OBJECT_SAVE_STUFF_DATA",null);
                  if(!null.disposed)
                  {
                     null.dispose();
                  }
               }
               break;
            case "RWUAM_REQUEST_PET_UPDATE":
               if(_container.roomSession != null && _container.roomSession.userDataManager != null)
               {
                  _container.roomSession.userDataManager.requestPetInfo(_loc22_);
               }
               break;
            case "RWRTSM_ROOM_TAG_SEARCH":
               var _loc28_:RoomWidgetRoomTagSearchMessage = param1 as RoomWidgetRoomTagSearchMessage;
               if(_loc28_ == null)
               {
                  return null;
               }
               _container.navigator.performTagSearch(null.tag);
               break;
            case "RWGOI_MESSAGE_GET_BADGE_DETAILS":
               var _loc21_:RoomWidgetGetBadgeDetailsMessage = param1 as RoomWidgetGetBadgeDetailsMessage;
               if(_loc21_ == null)
               {
                  return null;
               }
               _container.habboGroupsManager.showGroupBadgeInfo(null.own,null.groupId);
               break;
            case "RWGOI_MESSAGE_GET_BADGE_IMAGE":
               var _loc16_:RoomWidgetGetBadgeImageMessage = param1 as RoomWidgetGetBadgeImageMessage;
               if(_loc16_ == null)
               {
                  return null;
               }
               if(var_16 != null)
               {
                  var_16.refreshBadge(null.badgeId);
               }
               break;
            case "RWUAM_REPORT":
               if(!(_container == null || _container.habboHelp == null))
               {
                  if(_loc2_ != null)
                  {
                     _container.habboHelp.reportUser(_loc22_,-1,null);
                  }
               }
               break;
            case "RWUAM_REPORT_CFH_OTHER":
               _container.habboHelp.reportUser(_loc22_,124,null);
               break;
            case "RWPCM_REQUEST_PET_COMMANDS":
               var _loc24_:RoomWidgetPetCommandMessage = param1 as RoomWidgetPetCommandMessage;
               _container.roomSession.requestPetCommands(null.petId);
               break;
            case "RWPCM_PET_COMMAND":
               var _loc9_:RoomWidgetPetCommandMessage = param1 as RoomWidgetPetCommandMessage;
               _container.roomSession.sendChatMessage(null.value);
               break;
            case "RWVM_CHANGE_MOTTO_MESSAGE":
               var _loc26_:RoomWidgetChangeMottoMessage = param1 as RoomWidgetChangeMottoMessage;
               _container.roomSession.sendChangeMottoMessage(null.motto);
               break;
            case "RWOPEM_OPEN_USER_PROFILE":
               var _loc17_:RoomWidgetOpenProfileMessage = param1 as RoomWidgetOpenProfileMessage;
               if(_container.habboTracking)
               {
                  _container.habboTracking.trackGoogle("extendedProfile",null.trackingLocation);
               }
               _container.connection.send(new GetExtendedProfileMessageComposer(null.userId));
               break;
            case "RWPOM_OPEN_PRESENT":
               var _loc10_:RoomWidgetPresentOpenMessage = param1 as RoomWidgetPresentOpenMessage;
               if(_loc10_ != null && var_16 != null)
               {
                  var _loc11_:InfoStandFurniData = var_16.furniData;
                  if(_loc11_ != null && null.id == null.objectId)
                  {
                     if(var_16.isFurniViewVisible())
                     {
                        var_16.close();
                     }
                  }
               }
               break;
            case "RWUAM_AMBASSADOR_ALERT_USER":
               _container.roomSession.ambassadorAlert(_loc2_.webID);
               break;
            case "RWUAM_AMBASSADOR_KICK_USER":
               _container.roomSession.kickUser(_loc2_.webID);
               break;
            case "RWUAM_AMBASSADOR_MUTE_2MIN":
               _container.roomSession.muteUser(_loc2_.webID,2);
               break;
            case "RWUAM_AMBASSADOR_MUTE_10MIN":
               _container.roomSession.muteUser(_loc2_.webID,10);
               break;
            case "RWUAM_AMBASSADOR_MUTE_15MIN":
               _container.roomSession.muteUser(_loc2_.webID,15);
               break;
            case "RWUAM_AMBASSADOR_MUTE_60MIN":
               _container.roomSession.muteUser(_loc2_.webID,60);
               break;
            case "RWUAM_AMBASSADOR_MUTE_18HOUR":
               _container.roomSession.muteUser(_loc2_.webID,1080);
               break;
            case "RWUAM_AMBASSADOR_MUTE_36HOUR":
               _container.roomSession.muteUser(_loc2_.webID,2160);
               break;
            case "RWUAM_AMBASSADOR_MUTE_72HOUR":
               _container.roomSession.muteUser(_loc2_.webID,4320);
               break;
            case "RWUAM_AMBASSADOR_UNMUTE":
               _container.roomSession.unmuteUser(_loc2_.webID);
         }
         return null;
      }
      
      private function onRespectReplenishClicked(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            _container.sessionDataManager.replenishRespect();
         }
      }
      
      private function pickupObjectWithConfirmation(param1:int, param2:int) : void
      {
         var furniId:int = param1;
         var furniCategory:int = param2;
         if(_container != null)
         {
            if(class_2262.isBuilderClubId(furniId) && _container.catalog.buildersClubEnabled)
            {
               if(var_16.furniData.availableForBuildersClub)
               {
                  _container.roomEngine.modifyRoomObject(furniId,furniCategory,"OBJECT_PICKUP");
               }
               else
               {
                  _container.windowManager.confirm("${generic.alert.title}","${room.confirm.not_in_warehouse}",0,function(param1:class_2001, param2:class_1758):void
                  {
                     param1.dispose();
                     if(param2.type == "WE_OK")
                     {
                        _container.roomEngine.modifyRoomObject(furniId,furniCategory,"OBJECT_PICKUP");
                     }
                  });
               }
            }
            else
            {
               _container.roomEngine.modifyRoomObject(furniId,furniCategory,"OBJECT_PICKUP");
            }
         }
      }
      
      private function handleGetObjectNameMessage(param1:RoomWidgetRoomObjectMessage) : RoomWidgetUpdateEvent
      {
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:IRoomObject = null;
         var _loc4_:String = null;
         var _loc12_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = _container.roomSession.roomId;
         var _loc5_:String = null;
         switch(param1.category)
         {
            case 10:
            case 20:
               if(_container.events == null || _container.roomEngine == null)
               {
                  return null;
               }
               _loc3_ = _container.roomEngine.getRoomObject(_loc11_,param1.id,param1.category);
               _loc4_ = _loc3_.getType();
               if(_loc4_.indexOf("poster") == 0)
               {
                  _loc12_ = int(_loc4_.replace("poster",""));
                  _loc5_ = "${poster_" + _loc12_ + "_name}";
                  _loc6_ = _loc3_.getId();
                  _loc9_ = -1;
                  break;
               }
               _loc10_ = _loc3_.getModel().getNumber("furniture_type_id");
               if(param1.category == 10)
               {
                  var _loc7_:class_1800 = _container.sessionDataManager.getFloorItemData(_loc10_);
               }
               else if(param1.category == 20)
               {
                  _loc7_ = _container.sessionDataManager.getWallItemData(_loc10_);
               }
               return null;
            case 100:
               if(_container.roomSession == null || _container.sessionDataManager == null || _container.events == null || _container.roomEngine == null || _container.friendList == null)
               {
                  return null;
               }
               var _loc2_:class_2146 = _container.roomSession.userDataManager.getUserDataByIndex(param1.id);
               return null;
         }
         if(_loc5_ != null)
         {
            _container.events.dispatchEvent(new RoomWidgetRoomObjectNameEvent(_loc9_,param1.category,_loc5_,0,_loc6_));
         }
         return null;
      }
      
      private function handleGetObjectInfoMessage(param1:RoomWidgetRoomObjectMessage) : RoomWidgetUpdateEvent
      {
         var _loc3_:int = _container.roomSession.roomId;
         switch(param1.category)
         {
            case 10:
            case 20:
               handleGetFurniInfoMessage(param1,_loc3_);
               break;
            case 100:
               if(_container.roomSession == null || _container.sessionDataManager == null || _container.events == null || _container.roomEngine == null || _container.friendList == null)
               {
                  return null;
               }
               var _loc2_:class_2146 = _container.roomSession.userDataManager.getUserDataByIndex(param1.id);
               return null;
         }
         return null;
      }
      
      private function handleGetPetInfoMessage(param1:int) : void
      {
         var _loc2_:Boolean = container.config.getBoolean("petSelect.enabled");
         if(_loc2_)
         {
            _container.connection.send(new PetSelectedMessageComposer(param1));
         }
         _container.roomSession.userDataManager.requestPetInfo(param1);
      }
      
      private function handleGetBotInfoMessage(param1:int, param2:int, param3:int, param4:class_2146) : void
      {
         var _loc6_:RoomWidgetUserInfoUpdateEvent = new RoomWidgetUserInfoUpdateEvent("RWUIUE_BOT");
         _loc6_.name = param4.name;
         _loc6_.motto = param4.custom;
         _loc6_.webID = param4.webID;
         _loc6_.userRoomId = param2;
         _loc6_.userType = param4.type;
         var _loc8_:IRoomObject = _container.roomEngine.getRoomObject(param1,param2,param3);
         if(_loc8_ != null)
         {
            _loc6_.carryItem = _loc8_.getModel().getNumber("figure_carry_object");
         }
         _loc6_.amIOwner = _container.roomSession.isRoomOwner;
         _loc6_.isGuildRoom = _container.roomSession.isGuildRoom;
         _loc6_.myRoomControllerLevel = _container.roomSession.roomControllerLevel;
         _loc6_.amIAnyRoomController = _container.sessionDataManager.isAnyRoomController;
         _loc6_.canBeKicked = _container.roomSession.isRoomOwner;
         var _loc5_:Array = [];
         _loc5_.push("BOT");
         _loc6_.badges = _loc5_;
         _loc6_.figure = param4.figure;
         _container.events.dispatchEvent(_loc6_);
      }
      
      private function handleGetRentableBotInfoMessage(param1:int, param2:int, param3:int, param4:class_2146) : void
      {
         var _loc6_:RoomWidgetRentableBotInfoUpdateEvent = new RoomWidgetRentableBotInfoUpdateEvent();
         _loc6_.name = param4.name;
         _loc6_.motto = param4.custom;
         _loc6_.webID = param4.webID;
         _loc6_.userRoomId = param2;
         _loc6_.ownerId = param4.ownerId;
         _loc6_.ownerName = param4.ownerName;
         _loc6_.botSkills = param4.botSkills;
         var _loc7_:IRoomObject = _container.roomEngine.getRoomObject(param1,param2,param3);
         if(_loc7_ != null)
         {
            _loc6_.carryItem = _loc7_.getModel().getNumber("figure_carry_object");
         }
         _loc6_.amIOwner = _container.roomSession.isRoomOwner;
         _loc6_.myRoomControllerLevel = _container.roomSession.roomControllerLevel;
         _loc6_.amIAnyRoomController = _container.sessionDataManager.isAnyRoomController;
         var _loc5_:Array = [];
         _loc5_.push("BOT");
         _loc6_.badges = _loc5_;
         _loc6_.figure = param4.figure;
         _container.events.dispatchEvent(_loc6_);
      }
      
      private function handleGetUserInfoMessage(param1:int, param2:int, param3:int, param4:class_2146) : void
      {
         var _loc7_:String = null;
         var _loc5_:RoomWidgetUserInfoUpdateEvent = null;
         var _loc6_:class_1927 = null;
         var _loc10_:Number = NaN;
         var _loc11_:* = false;
         var _loc12_:int = 0;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         _loc7_ = "RWUIUE_OWN_USER";
         if(param4.webID != _container.sessionDataManager.userId)
         {
            _loc7_ = "RWUIUE_PEER";
         }
         _loc5_ = new RoomWidgetUserInfoUpdateEvent(_loc7_);
         _loc5_.isSpectatorMode = _container.roomSession.isSpectatorMode;
         _loc5_.name = param4.name;
         _loc5_.motto = param4.custom;
         if(isActivityDisplayEnabled)
         {
            _loc5_.achievementScore = param4.achievementScore;
         }
         _loc5_.webID = param4.webID;
         _loc5_.userRoomId = param2;
         _loc5_.userType = 1;
         var _loc13_:IRoomObject = _container.roomEngine.getRoomObject(param1,param2,param3);
         if(_loc13_ != null)
         {
            _loc5_.carryItem = _loc13_.getModel().getNumber("figure_carry_object");
         }
         if(_loc7_ == "RWUIUE_OWN_USER")
         {
            _loc5_.realName = _container.sessionDataManager.realName;
            _loc5_.allowNameChange = _container.sessionDataManager.nameChangeAllowed;
         }
         _loc5_.amIOwner = _container.roomSession.isRoomOwner;
         _loc5_.isGuildRoom = _container.roomSession.isGuildRoom;
         _loc5_.myRoomControllerLevel = _container.roomSession.roomControllerLevel;
         _loc5_.amIAnyRoomController = _container.sessionDataManager.isAnyRoomController;
         _loc5_.amIAnAmbassador = _container.sessionDataManager.isAmbassador;
         if(_loc7_ == "RWUIUE_PEER")
         {
            _loc5_.isBlocked = _container.sessionDataManager.isBlocked(param4.webID);
            _loc5_.canBeAskedAsFriend = _container.friendList.canBeAskedForAFriend(param4.webID);
            _loc6_ = _container.friendList.getFriend(param4.webID);
            if(_loc6_ != null)
            {
               _loc5_.realName = _loc6_.realName;
               _loc5_.isFriend = true;
            }
            if(_loc13_ != null)
            {
               _loc10_ = _loc13_.getModel().getNumber("figure_flat_control");
               if(!isNaN(_loc10_))
               {
                  _loc5_.targetRoomControllerLevel = _loc10_;
               }
               _loc5_.canBeMuted = determineCanBeMuted(_loc5_);
               _loc5_.canBeKicked = determineCanBeKicked(_loc5_);
               _loc5_.canBeBanned = determineCanBeBanned(_loc5_);
               class_21.log("Set moderation levels to " + _loc5_.name + "Muted: " + _loc5_.canBeMuted + ", Kicked: " + _loc5_.canBeKicked + ", Banned: " + _loc5_.canBeBanned);
            }
            _loc5_.isIgnored = _container.sessionDataManager.isIgnored(param4.webID);
            _loc5_.respectLeft = _container.sessionDataManager.respectLeft;
            _loc5_.respectReplenishesLeft = _container.sessionDataManager.respectReplenishesLeft;
            _loc11_ = !_container.sessionDataManager.systemShutDown;
            _loc12_ = _container.roomSession.tradeMode;
            if(!_loc11_)
            {
               _loc5_.canTrade = false;
            }
            else
            {
               switch(_loc12_ - 1)
               {
                  case 0:
                     _loc8_ = _loc5_.myRoomControllerLevel != 0 && _loc5_.myRoomControllerLevel != 2;
                     _loc9_ = _loc5_.targetRoomControllerLevel != 0 && _loc5_.targetRoomControllerLevel != 2;
                     _loc5_.canTrade = _loc8_ || _loc9_;
                     break;
                  case 1:
                     _loc5_.canTrade = true;
                     break;
                  default:
                     _loc5_.canTrade = false;
               }
            }
            _loc5_.canTradeReason = 0;
            if(!_loc11_)
            {
               _loc5_.canTradeReason = 2;
            }
            if(_loc12_ != 2)
            {
               _loc5_.canTradeReason = 3;
            }
         }
         _loc5_.groupId = int(param4.groupID);
         _loc5_.groupBadgeId = _container.sessionDataManager.getGroupBadgeId(int(param4.groupID));
         _loc5_.groupName = param4.groupName;
         _loc5_.badges = _container.roomSession.userDataManager.getUserBadges(param4.webID);
         _loc5_.figure = param4.figure;
         _container.events.dispatchEvent(_loc5_);
         _container.habboGroupsManager.updateVisibleExtendedProfile(param4.webID);
         _container.connection.send(new GetRelationshipStatusInfoMessageComposer(param4.webID));
      }
      
      private function determineCanBeMuted(param1:RoomWidgetUserInfoUpdateEvent) : Boolean
      {
         var userInfo:RoomWidgetUserInfoUpdateEvent = param1;
         var settingsFunction:Function = function(param1:RoomWidgetUserInfoUpdateEvent, param2:class_3348):Boolean
         {
            return checkUserWithRightsModerationLevel(param1,param2.whoCanMute);
         };
         return determineModerationLevel(userInfo,settingsFunction);
      }
      
      private function determineCanBeKicked(param1:RoomWidgetUserInfoUpdateEvent) : Boolean
      {
         var userInfo:RoomWidgetUserInfoUpdateEvent = param1;
         var settingsFunction:Function = function(param1:RoomWidgetUserInfoUpdateEvent, param2:class_3348):Boolean
         {
            if(param2.whoCanKick == 2)
            {
               return true;
            }
            return checkUserWithRightsModerationLevel(param1,param2.whoCanKick);
         };
         return determineModerationLevel(userInfo,settingsFunction);
      }
      
      private function determineCanBeBanned(param1:RoomWidgetUserInfoUpdateEvent) : Boolean
      {
         var userInfo:RoomWidgetUserInfoUpdateEvent = param1;
         var settingsFunction:Function = function(param1:RoomWidgetUserInfoUpdateEvent, param2:class_3348):Boolean
         {
            return checkUserWithRightsModerationLevel(param1,param2.whoCanBan);
         };
         return determineModerationLevel(userInfo,settingsFunction);
      }
      
      private function checkUserWithRightsModerationLevel(param1:RoomWidgetUserInfoUpdateEvent, param2:int) : Boolean
      {
         var _loc3_:Boolean = param1.myRoomControllerLevel == 1 || param1.myRoomControllerLevel >= 4;
         var _loc4_:Boolean = param1.isGuildRoom && param1.myRoomControllerLevel >= 3;
         switch(param2 - 1)
         {
            case 0:
               return _loc3_;
            case 3:
               return _loc4_;
            case 4:
               return _loc3_ || _loc4_;
            default:
               return param1.myRoomControllerLevel >= 4;
         }
      }
      
      private function determineModerationLevel(param1:RoomWidgetUserInfoUpdateEvent, param2:Function) : Boolean
      {
         if(!_container.roomSession.isPrivateRoom)
         {
            return false;
         }
         var _loc3_:class_3348 = _container.roomSession.roomModerationSettings;
         if(_loc3_ != null)
         {
            var _loc4_:Boolean = param2(param1,_loc3_);
         }
         return false;
      }
      
      private function handleGetFurniInfoMessage(param1:RoomWidgetRoomObjectMessage, param2:int) : void
      {
         var _loc8_:int = 0;
         var _loc15_:int = 0;
         var _loc12_:class_1800 = null;
         var _loc17_:int = 0;
         var _loc4_:String = null;
         var _loc22_:String = null;
         var _loc7_:String = null;
         var _loc5_:class_3073 = null;
         var _loc19_:String = null;
         var _loc18_:ISongInfo = null;
         if(_container.events == null || _container.roomEngine == null)
         {
            return;
         }
         if(param1.id < 0)
         {
            return;
         }
         var _loc20_:RoomWidgetFurniInfoUpdateEvent = new RoomWidgetFurniInfoUpdateEvent("RWFIUE_FURNI");
         _loc20_.id = param1.id;
         _loc20_.category = param1.category;
         var _loc9_:IRoomObject = _container.roomEngine.getRoomObject(param2,param1.id,param1.category);
         if(!_loc9_)
         {
            return;
         }
         var _loc14_:IRoomObjectModel = _loc9_.getModel();
         if(_loc14_.getString("RWEIEP_INFOSTAND_EXTRA_PARAM") != null)
         {
            _loc20_.extraParam = _loc14_.getString("RWEIEP_INFOSTAND_EXTRA_PARAM");
         }
         var _loc16_:int = _loc14_.getNumber("furniture_data_format");
         var _loc10_:IStuffData = class_2035.getStuffDataWrapperForType(_loc16_);
         _loc10_.initializeFromRoomObjectModel(_loc14_);
         _loc20_.stuffData = _loc10_;
         var _loc11_:String = _loc9_.getType();
         if(_loc11_.indexOf("poster") == 0)
         {
            _loc8_ = int(_loc11_.replace("poster",""));
            _loc20_.name = "${poster_" + _loc8_ + "_name}";
            _loc20_.description = "${poster_" + _loc8_ + "_desc}";
         }
         else
         {
            _loc15_ = _loc14_.getNumber("furniture_type_id");
            if(param1.category == 10)
            {
               _loc12_ = _container.sessionDataManager.getFloorItemData(_loc15_);
            }
            else if(param1.category == 20)
            {
               _loc12_ = _container.sessionDataManager.getWallItemData(_loc15_);
            }
            if(_loc12_ != null)
            {
               _loc20_.name = _loc12_.localizedName;
               _loc20_.isNft = _loc12_.className.indexOf("nft_") == 0;
               _loc20_.description = _loc12_.description;
               _loc20_.purchaseOfferId = _loc12_.purchaseOfferId;
               _loc20_.bcOfferId = _loc12_.bcOfferId;
               _loc20_.purchaseCouldBeUsedForBuyout = _loc12_.purchaseCouldBeUsedForBuyout;
               _loc20_.rentOfferId = _loc12_.rentOfferId;
               _loc20_.rentCouldBeUsedForBuyout = _loc12_.rentCouldBeUsedForBuyout;
               _loc20_.availableForBuildersClub = _loc12_.availableForBuildersClub;
               _loc20_.classId = _loc15_;
            }
         }
         if(_container.userDefinedRoomEvents != null)
         {
            if(param1.category == 10)
            {
               _container.userDefinedRoomEvents.stuffSelected(_loc9_.getId());
            }
            else if(param1.category == 20)
            {
               _container.userDefinedRoomEvents.stuffSelected(-_loc9_.getId());
            }
         }
         if(_loc11_.indexOf("post_it") > -1)
         {
            _loc20_.isStickie = true;
         }
         var _loc3_:int = _loc14_.getNumber("furniture_expiry_time");
         var _loc21_:int = _loc14_.getNumber("furniture_expirty_timestamp");
         _loc20_.expiration = _loc3_ < 0 ? _loc3_ : Math.max(0,_loc3_ - (getTimer() - _loc21_) / 1000);
         var _loc13_:class_2198 = _container.roomEngine.getRoomObjectImage(param2,param1.id,param1.category,new Vector3d(180),64,null);
         if(_loc13_.data == null || _loc13_.data.width > 140 || _loc13_.data.height > 200)
         {
            _loc13_ = _container.roomEngine.getRoomObjectImage(param2,param1.id,param1.category,new Vector3d(180),1,null);
         }
         _loc20_.image = _loc13_.data;
         _loc20_.isWallItem = param1.category == 20;
         _loc20_.isRoomOwner = _container.roomSession.isRoomOwner;
         _loc20_.roomControllerLevel = _container.roomSession.roomControllerLevel;
         _loc20_.isAnyRoomController = _container.sessionDataManager.isAnyRoomController;
         _loc20_.ownerId = _loc14_.getNumber("furniture_owner_id");
         _loc20_.ownerName = _loc14_.getString("furniture_owner_name");
         _loc20_.usagePolicy = _loc14_.getNumber("furniture_usage_policy");
         var _loc6_:int = _loc14_.getNumber("furniture_guild_customized_guild_id");
         if(_loc6_ != 0)
         {
            _loc20_.groupId = _loc6_;
            container.connection.send(new GetHabboGroupDetailsMessageComposer(_loc6_,false));
         }
         if(_container.isOwnerOfFurniture(_loc9_))
         {
            _loc20_.isOwner = true;
         }
         _container.events.dispatchEvent(_loc20_);
         if(_loc20_.extraParam != null && _loc20_.extraParam.length > 0)
         {
            _loc17_ = -1;
            _loc4_ = "";
            _loc22_ = "";
            _loc7_ = "";
            if(_loc20_.extraParam == "RWEIEP_JUKEBOX")
            {
               _loc5_ = var_424.getRoomItemPlaylist();
               if(_loc5_ != null)
               {
                  _loc17_ = _loc5_.nowPlayingSongId;
                  _loc7_ = "RWSUE_PLAYING_CHANGED";
               }
            }
            else if(_loc20_.extraParam.indexOf("RWEIEP_SONGDISK") == 0)
            {
               _loc19_ = _loc20_.extraParam.substr("RWEIEP_SONGDISK".length);
               _loc17_ = parseInt(_loc19_);
               _loc7_ = "RWSUE_DATA_RECEIVED";
            }
            if(_loc17_ != -1)
            {
               _loc18_ = var_424.getSongInfo(_loc17_);
               if(_loc18_ != null)
               {
                  _loc4_ = _loc18_.name;
                  _loc22_ = _loc18_.creator;
               }
               _container.events.dispatchEvent(new RoomWidgetSongUpdateEvent(_loc7_,_loc17_,_loc4_,_loc22_));
            }
         }
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RSUBE_BADGES"];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc2_:RoomSessionUserBadgesEvent = null;
         var _loc3_:* = param1.type;
         if("RSUBE_BADGES" === _loc3_)
         {
            _loc2_ = param1 as RoomSessionUserBadgesEvent;
            if(_loc2_ != null && var_16 != null)
            {
               var_16.refreshBadges(_loc2_.userId,_loc2_.badges);
            }
         }
      }
      
      private function onFigureUpdate(param1:RoomSessionUserFigureUpdateEvent) : void
      {
         if(_container == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(param1.userId < 0)
         {
            return;
         }
         var _loc2_:class_2146 = _container.roomSession.userDataManager.getUserDataByIndex(param1.userId);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc5_:int = _loc2_.webID;
         var _loc4_:* = _loc5_ == _container.sessionDataManager.userId;
         var_16.updateUserData(_loc5_,param1.figure,param1.achievementScore,param1.customInfo,_loc4_);
      }
      
      private function onPetInfo(param1:RoomSessionPetInfoUpdateEvent) : void
      {
         var _loc4_:* = false;
         var _loc6_:RoomWidgetPetInfoUpdateEvent = null;
         var _loc12_:IRoomSession = null;
         var _loc5_:IPetInfo = param1.petInfo;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc10_:class_2146 = _container.roomSession.userDataManager.getPetUserData(_loc5_.petId);
         if(_loc10_ == null)
         {
            return;
         }
         var _loc2_:String = _loc10_.figure;
         var _loc8_:int = getPetType(_loc2_);
         var _loc9_:int = getPetRace(_loc2_);
         if(_loc8_ == 16)
         {
            if(_loc5_.level >= _loc5_.adultLevel)
            {
               var _loc7_:String = "std";
            }
            else
            {
               _loc7_ = "grw" + _loc5_.level;
            }
         }
         var _loc3_:String = _loc2_ + "";
         var _loc11_:BitmapData = var_814.getValue(_loc3_) as BitmapData;
         if(_loc11_ == null)
         {
            _loc11_ = getPetImage(_loc2_,null);
            var_814.add(_loc3_,_loc11_);
         }
         if(_container != null && _container.events != null)
         {
            _loc4_ = _loc5_.ownerId == _container.sessionDataManager.userId;
            _loc6_ = new RoomWidgetPetInfoUpdateEvent(_loc8_,_loc9_,_loc10_.name,_loc5_.petId,_loc11_,_loc4_,_loc5_.ownerId,_loc5_.ownerName,_loc10_.roomObjectId,_loc5_.breedId);
            _loc6_.level = _loc5_.level;
            _loc6_.levelMax = _loc5_.levelMax;
            _loc6_.experience = _loc5_.experience;
            _loc6_.experienceMax = _loc5_.experienceMax;
            _loc6_.energy = _loc5_.energy;
            _loc6_.energyMax = _loc5_.energyMax;
            _loc6_.nutrition = _loc5_.nutrition;
            _loc6_.nutritionMax = _loc5_.nutritionMax;
            _loc6_.petRespect = _loc5_.respect;
            _loc6_.petRespectLeft = _container.sessionDataManager.petRespectLeft;
            _loc6_.age = _loc5_.age;
            _loc6_.hasFreeSaddle = _loc5_.hasFreeSaddle;
            _loc6_.isRiding = _loc5_.isRiding;
            _loc6_.canBreed = _loc5_.canBreed;
            _loc6_.canHarvest = _loc5_.canHarvest;
            _loc6_.canRevive = _loc5_.canRevive;
            _loc6_.rarityLevel = _loc5_.rarityLevel;
            _loc6_.skillTresholds = _loc5_.skillTresholds;
            _loc6_.canRemovePet = false;
            _loc6_.accessRights = _loc5_.accessRights;
            _loc6_.maxWellBeingSeconds = _loc5_.maxWellBeingSeconds;
            _loc6_.remainingWellBeingSeconds = _loc5_.remainingWellBeingSeconds;
            _loc6_.remainingGrowingSeconds = _loc5_.remainingGrowingSeconds;
            _loc6_.hasBreedingPermission = _loc5_.hasBreedingPermission;
            _loc12_ = _container.roomSession;
            if(_loc4_)
            {
               _loc6_.canRemovePet = true;
            }
            else if(_loc12_.isRoomOwner || _container.sessionDataManager.isAnyRoomController || _loc12_.roomControllerLevel >= 1)
            {
               _loc6_.canRemovePet = true;
            }
            _container.events.dispatchEvent(_loc6_);
         }
      }
      
      private function onPetFigureUpdate(param1:RoomSessionPetFigureUpdateEvent) : void
      {
         var _loc3_:RoomWidgetPetFigureUpdateEvent = null;
         var _loc2_:String = param1.figure;
         var _loc4_:BitmapData = var_814.getValue(_loc2_) as BitmapData;
         if(_loc4_ == null)
         {
            _loc4_ = getPetImage(_loc2_);
            var_814.add(_loc2_,_loc4_);
         }
         if(_container != null && _container.events != null)
         {
            _loc3_ = new RoomWidgetPetFigureUpdateEvent(param1.petId,_loc4_);
            _container.events.dispatchEvent(_loc3_);
         }
      }
      
      private function onPetBreedingResult(param1:RoomSessionPetBreedingResultEvent) : void
      {
         var _loc3_:PetBreedingResultEventData = null;
         var _loc4_:PetBreedingResultEventData = null;
         var _loc2_:RoomWidgetPetBreedingResultEvent = null;
         if(_container != null && _container.events != null)
         {
            _loc3_ = new PetBreedingResultEventData();
            _loc3_.stuffId = param1.resultData.stuffId;
            _loc3_.classId = param1.resultData.classId;
            _loc3_.productCode = param1.resultData.productCode;
            _loc3_.userId = param1.resultData.userId;
            _loc3_.userName = param1.resultData.userName;
            _loc3_.rarityLevel = param1.resultData.rarityLevel;
            _loc3_.hasMutation = param1.resultData.hasMutation;
            _loc4_ = new PetBreedingResultEventData();
            _loc4_.stuffId = param1.otherResultData.stuffId;
            _loc4_.classId = param1.otherResultData.classId;
            _loc4_.productCode = param1.otherResultData.productCode;
            _loc4_.userId = param1.otherResultData.userId;
            _loc4_.userName = param1.otherResultData.userName;
            _loc4_.rarityLevel = param1.otherResultData.rarityLevel;
            _loc4_.hasMutation = param1.otherResultData.hasMutation;
            _loc2_ = new RoomWidgetPetBreedingResultEvent(_loc3_,_loc4_);
            _container.events.dispatchEvent(_loc2_);
         }
      }
      
      private function onPetBreedingEvent(param1:RoomSessionPetBreedingEvent) : void
      {
         var _loc2_:RoomWidgetPetBreedingEvent = null;
         if(_container != null && _container.events != null)
         {
            _loc2_ = new RoomWidgetPetBreedingEvent();
            _loc2_.state = param1.state;
            _loc2_.ownPetId = param1.ownPetId;
            _loc2_.otherPetId = param1.otherPetId;
            _container.events.dispatchEvent(_loc2_);
         }
      }
      
      private function onConfirmPetBreedingEvent(param1:RoomSessionConfirmPetBreedingEvent) : void
      {
         var _loc4_:ConfirmPetBreedingPetData = null;
         var _loc3_:ConfirmPetBreedingPetData = null;
         var _loc6_:Array = null;
         var _loc5_:BreedingRarityCategoryData = null;
         var _loc7_:RoomWidgetConfirmPetBreedingEvent = null;
         if(_container != null && _container.events != null)
         {
            _loc4_ = new ConfirmPetBreedingPetData();
            _loc4_.webId = param1.pet1.webId;
            _loc4_.name = param1.pet1.name;
            _loc4_.level = param1.pet1.level;
            _loc4_.figure = param1.pet1.figure;
            _loc4_.owner = param1.pet1.owner;
            _loc3_ = new ConfirmPetBreedingPetData();
            _loc3_.webId = param1.pet2.webId;
            _loc3_.name = param1.pet2.name;
            _loc3_.level = param1.pet2.level;
            _loc3_.figure = param1.pet2.figure;
            _loc3_.owner = param1.pet2.owner;
            _loc6_ = [];
            for each(var _loc2_ in param1.rarityCategories)
            {
               _loc5_ = new BreedingRarityCategoryData();
               _loc5_.chance = _loc2_.chance;
               _loc5_.breeds = _loc2_.breeds.concat();
               _loc6_.push(_loc5_);
            }
            _loc7_ = new RoomWidgetConfirmPetBreedingEvent(param1.nestId,_loc4_,_loc3_,_loc6_,param1.resultPetTypeId);
            _container.events.dispatchEvent(_loc7_);
         }
      }
      
      private function onConfirmPetBreedingResultEvent(param1:RoomSessionConfirmPetBreedingResultEvent) : void
      {
         var _loc2_:RoomWidgetConfirmPetBreedingResultEvent = null;
         if(_container != null && _container.events != null)
         {
            _loc2_ = new RoomWidgetConfirmPetBreedingResultEvent(param1.breedingNestStuffId,param1.result);
            _container.events.dispatchEvent(_loc2_);
         }
      }
      
      private function onPetCommands(param1:RoomSessionPetCommandsUpdateEvent) : void
      {
         var _loc2_:RoomWidgetPetCommandsUpdateEvent = null;
         if(_container != null && _container.events != null)
         {
            _loc2_ = new RoomWidgetPetCommandsUpdateEvent(param1.petId,param1.allCommands,param1.enabledCommands);
            _container.events.dispatchEvent(_loc2_);
         }
      }
      
      private function onFavouriteGroupUpdated(param1:RoomSessionFavouriteGroupUpdateEvent) : void
      {
         if(var_16)
         {
            var_16.favouriteGroupUpdated(param1.roomIndex,param1.habboGroupId,param1.status,param1.habboGroupName);
         }
      }
      
      public function update() : void
      {
      }
      
      private function getPetImage(param1:String, param2:String = null) : BitmapData
      {
         var _loc4_:BitmapData = null;
         var _loc3_:PetFigureData = new PetFigureData(param1);
         var _loc6_:class_2198 = _container.roomEngine.getPetImage(_loc3_.typeId,_loc3_.paletteId,_loc3_.color,new Vector3d(90),64,null,true,0,_loc3_.customParts,param2);
         if(_loc6_ != null)
         {
            _loc4_ = _loc6_.data;
         }
         if(_loc4_ == null)
         {
            _loc4_ = new BitmapData(30,30,false,4289374890);
         }
         return _loc4_;
      }
      
      private function getPetType(param1:String) : int
      {
         return getSpaceSeparatedInteger(param1,0);
      }
      
      private function getPetRace(param1:String) : int
      {
         return getSpaceSeparatedInteger(param1,1);
      }
      
      private function getPetColor(param1:String) : int
      {
         var _loc2_:Array = param1.split(" ");
         if(_loc2_.length > 2)
         {
            return parseInt(_loc2_[2],16);
         }
         return 16777215;
      }
      
      private function getSpaceSeparatedInteger(param1:String, param2:int) : int
      {
         var _loc3_:Array = null;
         if(param1 != null)
         {
            _loc3_ = param1.split(" ");
            if(_loc3_.length > param2)
            {
               return int(_loc3_[param2]);
            }
         }
         return -1;
      }
      
      private function onNowPlayingChanged(param1:NowPlayingEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         var _loc5_:String = null;
         var _loc4_:ISongInfo = null;
         if(var_424 != null)
         {
            _loc3_ = param1.id;
            _loc2_ = "";
            _loc5_ = "";
            if(_loc3_ != -1)
            {
               _loc4_ = var_424.getSongInfo(_loc3_);
               if(_loc4_ != null)
               {
                  _loc2_ = _loc4_.name;
                  _loc5_ = _loc4_.creator;
               }
            }
            _container.events.dispatchEvent(new RoomWidgetSongUpdateEvent("RWSUE_PLAYING_CHANGED",_loc3_,_loc2_,_loc5_));
         }
      }
      
      private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent) : void
      {
         if(var_424 != null)
         {
            var _loc2_:ISongInfo = var_424.getSongInfo(param1.id);
         }
      }
      
      private function onRelationshipStatusEvent(param1:RelationshipStatusInfoEvent) : void
      {
         if(var_16 && var_16.mainWindow.visible)
         {
            var_16.setRelationshipStatus(param1.userId,param1.relationshipStatusMap);
         }
      }
      
      public function get isActivityDisplayEnabled() : Boolean
      {
         return _container != null && _container.config && _container.config.getBoolean("activity.point.display.enabled");
      }
      
      public function setObjectData(param1:class_55) : void
      {
         if(_container.sessionDataManager.hasSecurity(5))
         {
            _container.connection.send(new SetObjectDataMessageComposer(var_16.furniData.id,param1));
         }
      }
   }
}

