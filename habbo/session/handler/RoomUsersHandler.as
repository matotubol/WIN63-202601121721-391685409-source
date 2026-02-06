package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.PetInfo;
   import com.sulake.habbo.session.UserData;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.session.events.RoomSessionConfirmPetBreedingEvent;
   import com.sulake.habbo.session.events.RoomSessionConfirmPetBreedingResultEvent;
   import com.sulake.habbo.session.events.RoomSessionDanceEvent;
   import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
   import com.sulake.habbo.session.events.RoomSessionErrorMessageEvent;
   import com.sulake.habbo.session.events.RoomSessionFavouriteGroupUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionFriendRequestEvent;
   import com.sulake.habbo.session.events.RoomSessionNestBreedingSuccessEvent;
   import com.sulake.habbo.session.events.RoomSessionPetBreedingEvent;
   import com.sulake.habbo.session.events.RoomSessionPetBreedingResultEvent;
   import com.sulake.habbo.session.events.RoomSessionPetCommandsUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionPetFigureUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionPetInfoUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionPetLevelUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionPetStatusUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionUserBadgesEvent;
   import com.sulake.habbo.session.events.RoomSessionUserDataUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionUserFigureUpdateEvent;
   import com.sulake.room.utils.RoomShakingEffect;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.ConfirmBreedingResultEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.ConfirmBreedingRequestEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetBreedingEventParser;
   import com.sulake.habbo.communication.messages.parser.friendlist.NewFriendRequestEventParser;
   import com.sulake.habbo.communication.messages.incoming.room.bots.BotErrorEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.NewFriendRequestEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.class_2254;
   import com.sulake.habbo.communication.messages.incoming.users.UserNameChangedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboUserBadgesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.BlockUserUpdateMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.pets.PetCommandsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.pets.PetLevelUpdateEvent;
   import com.sulake.habbo.communication.messages.incoming.room.pets.PetFigureUpdateEvent;
   import com.sulake.habbo.communication.messages.incoming.room.pets.PetInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.pets.PetBreedingResultEvent;
   import com.sulake.habbo.communication.messages.incoming.room.pets.PetStatusUpdateEvent;
   import com.sulake.habbo.communication.messages.incoming.room.pets.PetPlacingErrorEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_1916;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UsersMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.FavoriteMembershipUpdateMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserRemoveMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.DoorbellMessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.UsersMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.UserRemoveMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.FavoriteMembershipUpdateMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.users.UserNameChangedMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.room.action.DanceMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.ConfirmBreedingResultEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetBreedingEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.NestBreedingSuccessEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.ConfirmBreedingRequestEvent;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetBreedingResultEventParser;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetInfoMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetFigureUpdateEventParser;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetStatusUpdateEventParser;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetLevelUpdateEventParser;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetCommandsMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.room.action.DanceMessageEventParser;
   
   public class RoomUsersHandler extends BaseHandler
   {
      
      public function RoomUsersHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
         param1.addMessageEvent(new UsersMessageEvent(onUsers));
         param1.addMessageEvent(new UserRemoveMessageEvent(onUserRemove));
         param1.addMessageEvent(new HabboUserBadgesMessageEvent(onUserBadges));
         param1.addMessageEvent(new DoorbellMessageEvent(onDoorbell));
         param1.addMessageEvent(new UserChangeMessageEvent(onUserChange));
         param1.addMessageEvent(new UserNameChangedMessageEvent(onUserNameChange));
         param1.addMessageEvent(new PetInfoMessageEvent(onPetInfo));
         param1.addMessageEvent(new PetCommandsMessageEvent(onEnabledPetCommands));
         param1.addMessageEvent(new PetPlacingErrorEvent(onPetPlacingError));
         param1.addMessageEvent(new PetFigureUpdateEvent(onPetFigureUpdate));
         param1.addMessageEvent(new PetBreedingResultEvent(onPetBreedingResult));
         param1.addMessageEvent(new PetBreedingEvent(onPetBreedingEvent));
         param1.addMessageEvent(new PetStatusUpdateEvent(onPetStatusUpdate));
         param1.addMessageEvent(new PetLevelUpdateEvent(onPetLevelUpdate));
         param1.addMessageEvent(new ConfirmBreedingRequestEvent(onConfirmPetBreeding));
         param1.addMessageEvent(new ConfirmBreedingResultEvent(onConfirmPetBreedingResult));
         param1.addMessageEvent(new NestBreedingSuccessEvent(onNestBreedingSuccess));
         param1.addMessageEvent(new BotErrorEvent(onBotError));
         param1.addMessageEvent(new NewFriendRequestEvent(onFriendRequest));
         param1.addMessageEvent(new DanceMessageEvent(onDance));
         param1.addMessageEvent(new FavoriteMembershipUpdateMessageEvent(onFavoriteMembershipUpdate));
         param1.addMessageEvent(new BlockUserUpdateMessageEvent(onBlockUserUpdate));
      }
      
      private function onFavoriteMembershipUpdate(param1:IMessageEvent) : void
      {
         var _loc5_:RoomSessionFavouriteGroupUpdateEvent = null;
         var _loc3_:FavoriteMembershipUpdateMessageEventParser = FavoriteMembershipUpdateMessageEvent(param1).getParser();
         var _loc4_:IRoomSession = listener.getSession(var_56);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:class_2146 = _loc4_.userDataManager.getUserDataByIndex(_loc3_.roomIndex);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.groupID = "" + _loc3_.habboGroupId;
         _loc2_.groupName = _loc3_.habboGroupName;
         if(listener && listener.events)
         {
            _loc5_ = new RoomSessionFavouriteGroupUpdateEvent(_loc4_,_loc3_.roomIndex,_loc3_.habboGroupId,_loc3_.status,_loc3_.habboGroupName);
            listener.events.dispatchEvent(_loc5_);
         }
      }
      
      private function onUsers(param1:IMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc8_:class_1916 = null;
         var _loc2_:UserData = null;
         var _loc9_:UsersMessageEvent = param1 as UsersMessageEvent;
         if(_loc9_ == null)
         {
            return;
         }
         var _loc3_:UsersMessageEventParser = _loc9_.getParser();
         var _loc5_:IRoomSession = listener.getSession(var_56);
         if(_loc5_ == null)
         {
            return;
         }
         var _loc6_:Boolean = false;
         var _loc7_:Vector.<class_2146> = new Vector.<class_2146>(0);
         _loc4_ = 0;
         while(_loc4_ < _loc3_.getUserCount())
         {
            _loc8_ = _loc3_.getUser(_loc4_);
            _loc2_ = new UserData(_loc8_.roomIndex);
            _loc2_.name = _loc8_.name;
            _loc2_.custom = _loc8_.custom;
            _loc2_.achievementScore = _loc8_.achievementScore;
            _loc2_.figure = _loc8_.figure;
            _loc2_.type = _loc8_.userType;
            _loc2_.webID = _loc8_.webID;
            _loc2_.groupID = _loc8_.groupID;
            _loc2_.groupName = _loc8_.groupName;
            _loc2_.groupStatus = _loc8_.groupStatus;
            _loc2_.sex = _loc8_.sex;
            _loc2_.ownerId = _loc8_.ownerId;
            _loc2_.ownerName = _loc8_.ownerName;
            _loc2_.rarityLevel = _loc8_.rarityLevel;
            _loc2_.hasSaddle = _loc8_.hasSaddle;
            _loc2_.isRiding = _loc8_.isRiding;
            _loc2_.canBreed = _loc8_.canBreed;
            _loc2_.canHarvest = _loc8_.canHarvest;
            _loc2_.canRevive = _loc8_.canRevive;
            _loc2_.hasBreedingPermission = _loc8_.hasBreedingPermission;
            _loc2_.petLevel = _loc8_.petLevel;
            _loc2_.botSkills = _loc8_.botSkills;
            _loc2_.isModerator = _loc8_.isModerator;
            if(_loc8_.userType == 4 && _loc8_.ownerId == -1 && _loc8_.name == "Macklebee")
            {
               _loc6_ = true;
            }
            if(_loc5_.userDataManager.getUserData(_loc8_.roomIndex) == null)
            {
               _loc7_.push(_loc2_);
            }
            _loc5_.userDataManager.setUserData(_loc2_);
            _loc4_++;
         }
         if(_loc6_)
         {
            RoomShakingEffect.init(250,5000);
            RoomShakingEffect.turnVisualizationOn();
         }
         listener.events.dispatchEvent(new RoomSessionUserDataUpdateEvent(_loc5_,_loc7_));
      }
      
      private function onBlockUserUpdate(param1:BlockUserUpdateMessageEvent) : void
      {
         var _loc3_:IRoomSession = listener.getSession(var_56);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_2146 = _loc3_.userDataManager.getUserData(param1.userId);
         if(_loc2_ != null)
         {
            _loc3_.userDataManager.markAsBlocked(_loc2_.roomObjectId,param1.result == 1);
         }
      }
      
      private function onUserRemove(param1:IMessageEvent) : void
      {
         var _loc4_:UserRemoveMessageEvent = param1 as UserRemoveMessageEvent;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(var_56);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:int = (_loc4_.getParser() as UserRemoveMessageEventParser).id;
         _loc3_.userDataManager.removeUserDataByRoomIndex(_loc2_);
      }
      
      private function onUserBadges(param1:IMessageEvent) : void
      {
         var _loc2_:HabboUserBadgesMessageEvent = param1 as HabboUserBadgesMessageEvent;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(var_56);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.userDataManager.setUserBadges(_loc2_.userId,_loc2_.badges);
         listener.events.dispatchEvent(new RoomSessionUserBadgesEvent(_loc3_,_loc2_.userId,_loc2_.badges));
      }
      
      private function onDoorbell(param1:IMessageEvent) : void
      {
         var _loc2_:DoorbellMessageEvent = param1 as DoorbellMessageEvent;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.userName == "")
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(var_56);
         if(_loc3_ == null)
         {
            return;
         }
         listener.events.dispatchEvent(new RoomSessionDoorbellEvent("RSDE_DOORBELL",_loc3_,_loc2_.userName));
      }
      
      private function onUserChange(param1:IMessageEvent) : void
      {
         var _loc3_:UserChangeMessageEvent = param1 as UserChangeMessageEvent;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:IRoomSession = listener.getSession(var_56);
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc3_.id >= 0)
         {
            _loc2_.userDataManager.updateFigure(_loc3_.id,_loc3_.figure,_loc3_.sex,false,false);
            _loc2_.userDataManager.updateCustom(_loc3_.id,_loc3_.customInfo);
            _loc2_.userDataManager.updateAchievementScore(_loc3_.id,_loc3_.achievementScore);
            listener.events.dispatchEvent(new RoomSessionUserFigureUpdateEvent(_loc2_,_loc3_.id,_loc3_.figure,_loc3_.sex,_loc3_.customInfo,_loc3_.achievementScore));
         }
      }
      
      private function onUserNameChange(param1:IMessageEvent) : void
      {
         var _loc2_:UserNameChangedMessageEvent = param1 as UserNameChangedMessageEvent;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:UserNameChangedMessageEventParser = _loc2_.getParser();
         var _loc4_:IRoomSession = listener.getSession(var_56);
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.userDataManager.updateNameByIndex(_loc3_.id,_loc3_.newName);
      }
      
      private function onPetInfo(param1:IMessageEvent) : void
      {
         var _loc5_:IRoomSession = listener.getSession(var_56);
         if(_loc5_ == null)
         {
            return;
         }
         var _loc3_:PetInfoMessageEvent = param1 as PetInfoMessageEvent;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:PetInfoMessageEventParser = _loc3_.getParser();
         var _loc4_:PetInfo = new PetInfo();
         _loc4_.petId = _loc2_.petId;
         _loc4_.level = _loc2_.level;
         _loc4_.levelMax = _loc2_.maxLevel;
         _loc4_.experience = _loc2_.experience;
         _loc4_.experienceMax = _loc2_.experienceRequiredToLevel;
         _loc4_.energy = _loc2_.energy;
         _loc4_.energyMax = _loc2_.maxEnergy;
         _loc4_.nutrition = _loc2_.nutrition;
         _loc4_.nutritionMax = _loc2_.maxNutrition;
         _loc4_.ownerId = _loc2_.ownerId;
         _loc4_.ownerName = _loc2_.ownerName;
         _loc4_.respect = _loc2_.respect;
         _loc4_.age = _loc2_.age;
         _loc4_.breedId = _loc2_.breedId;
         _loc4_.hasFreeSaddle = _loc2_.hasFreeSaddle;
         _loc4_.isRiding = _loc2_.isRiding;
         _loc4_.canBreed = _loc2_.canBreed;
         _loc4_.canHarvest = _loc2_.canHarvest;
         _loc4_.rarityLevel = _loc2_.rarityLevel;
         _loc4_.canRevive = _loc2_.canRevive;
         _loc4_.skillTresholds = _loc2_.skillTresholds;
         _loc4_.accessRights = _loc2_.accessRights;
         _loc4_.maxWellBeingSeconds = _loc2_.maxWellBeingSeconds;
         _loc4_.remainingWellBeingSeconds = _loc2_.remainingWellBeingSeconds;
         _loc4_.remainingGrowingSeconds = _loc2_.remainingGrowingSeconds;
         _loc4_.hasBreedingPermission = _loc2_.hasBreedingPermission;
         listener.events.dispatchEvent(new RoomSessionPetInfoUpdateEvent(_loc5_,_loc4_));
      }
      
      private function onPetFigureUpdate(param1:IMessageEvent) : void
      {
         var _loc7_:PetFigureUpdateEvent = param1 as PetFigureUpdateEvent;
         if(_loc7_ == null)
         {
            return;
         }
         var _loc5_:PetFigureUpdateEventParser = _loc7_.getParser();
         var _loc6_:IRoomSession = listener.getSession(var_56);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc8_:String = _loc5_.figureData.figureString;
         var _loc9_:int = _loc5_.roomIndex;
         var _loc3_:int = _loc5_.petId;
         var _loc2_:Boolean = _loc5_.hasSaddle;
         var _loc4_:Boolean = _loc5_.isRiding;
         _loc6_.userDataManager.updateFigure(_loc9_,_loc8_,"",_loc2_,_loc4_);
         listener.events.dispatchEvent(new RoomSessionPetFigureUpdateEvent(_loc6_,_loc3_,_loc8_));
      }
      
      private function onPetBreedingResult(param1:IMessageEvent) : void
      {
         var _loc2_:PetBreedingResultEvent = param1 as PetBreedingResultEvent;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:PetBreedingResultEventParser = _loc2_.getParser();
         var _loc4_:IRoomSession = listener.getSession(var_56);
         if(_loc4_ == null)
         {
            return;
         }
         listener.events.dispatchEvent(new RoomSessionPetBreedingResultEvent(_loc4_,_loc3_.resultData,_loc3_.otherResultData));
      }
      
      private function onConfirmPetBreeding(param1:ConfirmBreedingRequestEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:ConfirmBreedingRequestEventParser = param1.parser as ConfirmBreedingRequestEventParser;
         var _loc3_:IRoomSession = listener.getSession(var_56);
         if(_loc3_ == null)
         {
            return;
         }
         listener.events.dispatchEvent(new RoomSessionConfirmPetBreedingEvent(_loc3_,_loc2_.nestId,_loc2_.pet1,_loc2_.pet2,_loc2_.rarityCategories,_loc2_.resultPetType));
      }
      
      private function onConfirmPetBreedingResult(param1:ConfirmBreedingResultEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:ConfirmBreedingResultEventParser = param1.parser as ConfirmBreedingResultEventParser;
         var _loc3_:IRoomSession = listener.getSession(var_56);
         if(_loc3_ == null)
         {
            return;
         }
         listener.events.dispatchEvent(new RoomSessionConfirmPetBreedingResultEvent(_loc3_,_loc2_.breedingNestStuffId,_loc2_.result));
      }
      
      private function onNestBreedingSuccess(param1:NestBreedingSuccessEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:IRoomSession = listener.getSession(var_56);
         if(_loc2_ == null)
         {
            return;
         }
         listener.events.dispatchEvent(new RoomSessionNestBreedingSuccessEvent(_loc2_,param1.getParser().petId,param1.getParser().rarityCategory));
      }
      
      private function onPetBreedingEvent(param1:IMessageEvent) : void
      {
         var _loc4_:PetBreedingEvent = param1 as PetBreedingEvent;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:PetBreedingEventParser = _loc4_.getParser();
         var _loc3_:IRoomSession = listener.getSession(var_56);
         if(_loc3_ == null)
         {
            return;
         }
         listener.events.dispatchEvent(new RoomSessionPetBreedingEvent(_loc3_,_loc2_.state,_loc2_.ownPetId,_loc2_.otherPetId));
      }
      
      private function onPetStatusUpdate(param1:IMessageEvent) : void
      {
         var _loc8_:PetStatusUpdateEvent = param1 as PetStatusUpdateEvent;
         if(_loc8_ == null)
         {
            return;
         }
         var _loc4_:PetStatusUpdateEventParser = _loc8_.getParser();
         var _loc5_:IRoomSession = listener.getSession(var_56);
         if(_loc5_ == null)
         {
            return;
         }
         var _loc9_:int = _loc4_.roomIndex;
         var _loc2_:int = _loc4_.petId;
         var _loc3_:Boolean = _loc4_.canHarvest;
         var _loc10_:Boolean = _loc4_.canRevive;
         var _loc7_:Boolean = _loc4_.canBreed;
         var _loc6_:Boolean = _loc4_.hasBreedingPermission;
         _loc5_.userDataManager.updatePetBreedingStatus(_loc9_,_loc7_,_loc3_,_loc10_,_loc6_);
         listener.events.dispatchEvent(new RoomSessionPetStatusUpdateEvent(_loc5_,_loc2_,_loc7_,_loc3_,_loc10_,_loc6_));
      }
      
      private function onPetLevelUpdate(param1:IMessageEvent) : void
      {
         var _loc2_:PetLevelUpdateEvent = param1 as PetLevelUpdateEvent;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:PetLevelUpdateEventParser = _loc2_.getParser();
         var _loc6_:IRoomSession = listener.getSession(var_56);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc7_:int = _loc4_.roomIndex;
         var _loc3_:int = _loc4_.petId;
         var _loc5_:int = _loc4_.level;
         _loc6_.userDataManager.updatePetLevel(_loc7_,_loc5_);
         listener.events.dispatchEvent(new RoomSessionPetLevelUpdateEvent(_loc6_,_loc3_,_loc5_));
      }
      
      private function onEnabledPetCommands(param1:IMessageEvent) : void
      {
         var _loc4_:IRoomSession = listener.getSession(var_56);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:PetCommandsMessageEvent = param1 as PetCommandsMessageEvent;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:PetCommandsMessageEventParser = _loc2_.getParser();
         if(_loc3_ != null)
         {
            listener.events.dispatchEvent(new RoomSessionPetCommandsUpdateEvent(_loc4_,_loc3_.petId,_loc3_.allCommands,_loc3_.enabledCommands));
         }
      }
      
      private function onPetPlacingError(param1:PetPlacingErrorEvent) : void
      {
         var _loc3_:String = null;
         if(param1 == null || param1.getParser() == null)
         {
            return;
         }
         var _loc2_:IRoomSession = listener.getSession(var_56);
         if(_loc2_ == null)
         {
            return;
         }
         switch(param1.getParser().errorCode)
         {
            case 0:
               _loc3_ = "RSEME_PETS_FORBIDDEN_IN_HOTEL";
               break;
            case 1:
               _loc3_ = "RSEME_PETS_FORBIDDEN_IN_FLAT";
               break;
            case 2:
               _loc3_ = "RSEME_MAX_PETS";
               break;
            case 3:
               _loc3_ = "RSEME_NO_FREE_TILES_FOR_PET";
               break;
            case 4:
               _loc3_ = "RSEME_SELECTED_TILE_NOT_FREE_FOR_PET";
               break;
            case 5:
               _loc3_ = "RSEME_MAX_NUMBER_OF_OWN_PETS";
         }
         if(_loc3_ != null)
         {
            listener.events.dispatchEvent(new RoomSessionErrorMessageEvent(_loc3_,_loc2_));
         }
      }
      
      private function onBotError(param1:BotErrorEvent) : void
      {
         var _loc3_:String = null;
         if(param1 == null || param1.getParser() == null)
         {
            return;
         }
         var _loc2_:IRoomSession = listener.getSession(var_56);
         if(_loc2_ == null)
         {
            return;
         }
         switch(param1.getParser().errorCode)
         {
            case 0:
               _loc3_ = "RSEME_BOTS_FORBIDDEN_IN_HOTEL";
               break;
            case 1:
               _loc3_ = "RSEME_BOTS_FORBIDDEN_IN_FLAT";
               break;
            case 2:
               _loc3_ = "RSEME_BOT_LIMIT_REACHED";
               break;
            case 3:
               _loc3_ = "RSEME_SELECTED_TILE_NOT_FREE_FOR_BOT";
               break;
            case 4:
               _loc3_ = "RSEME_BOT_NAME_NOT_ACCEPTED";
         }
         if(_loc3_ != null)
         {
            listener.events.dispatchEvent(new RoomSessionErrorMessageEvent(_loc3_,_loc2_));
         }
      }
      
      private function onFriendRequest(param1:NewFriendRequestEvent) : void
      {
         if(!param1 || !listener || !listener.events)
         {
            return;
         }
         var _loc2_:NewFriendRequestEventParser = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
         var _loc4_:IRoomSession = listener.getSession(var_56);
         if(!_loc4_)
         {
            return;
         }
         var _loc3_:class_2254 = _loc2_.req;
         if(!_loc3_)
         {
            return;
         }
         listener.events.dispatchEvent(new RoomSessionFriendRequestEvent(_loc4_,_loc3_.requestId,_loc3_.requestId,_loc3_.requesterName));
      }
      
      private function onDance(param1:DanceMessageEvent) : void
      {
         var _loc2_:DanceMessageEventParser = param1.getParser();
         var _loc3_:IRoomSession = listener.getSession(var_56);
         listener.events.dispatchEvent(new RoomSessionDanceEvent(_loc3_,_loc2_.userId,_loc2_.danceStyle));
      }
   }
}

