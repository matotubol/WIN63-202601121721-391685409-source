package com.sulake.habbo.session
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.tracking.class_53;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.outgoing.poll.PollAnswerComposer;
   import com.sulake.habbo.communication.messages.outgoing.poll.PollStartComposer;
   import com.sulake.habbo.communication.messages.outgoing.poll.PollRejectComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.SignMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.DanceMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.ChangeMottoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.ChangePostureMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.AvatarExpressionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.nux.NewUserExperienceScriptProceedComposer;
   import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2GameChatMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.MuteUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.LetUserInMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.AmbassadorAlertMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.UnmuteUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveRightsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.AssignRightsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.BanUserWithDurationMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.KickUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userclassification.RoomUsersClassificationMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userclassification.PeerUsersClassificationMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.VisitUserMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_3348;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.HarvestPetMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.RemovePetFromFlatMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.CompostPlantMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.TogglePetBreedingPermissionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.SetClothingChangeDataMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.RemoveSaddleFromPetMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.GetPetCommandsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.TogglePetRidingPermissionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.MountPetMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.ChatMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.ShoutMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.CancelTypingMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.WhisperMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.StartTypingMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.pets.CustomizePetWithFurniComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.session.OpenFlatConnectionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.session.ChangeQueueMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.session.QuitMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.OpenPetPackageMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerChangeStateMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerGetPresetsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.PresentOpenMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerSavePresetMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.CreditFurniRedeemMessageComposer;
   
   public class RoomSession implements IRoomSession
   {
      
      private const CHAT_LAG_WARNING_LIMIT:int = 2500;
      
      private var var_37:IConnection;
      
      private var var_1951:int = 0;
      
      private var var_2861:String = "";
      
      private var var_4338:Boolean = false;
      
      private var var_3944:String = "";
      
      private var var_974:IMessageComposer = null;
      
      private var var_61:String = "RSE_CREATED";
      
      private var var_1480:UserDataManager;
      
      private var var_4279:int = -1;
      
      private var var_2507:Boolean = false;
      
      private var var_1873:int = 0;
      
      private var var_2234:Boolean = false;
      
      private var var_2859:int = 0;
      
      private var _isGuildRoom:Boolean = false;
      
      private var var_2810:Boolean = false;
      
      private var var_4964:Boolean = false;
      
      private var var_4157:int;
      
      private var var_1729:class_55 = new class_55();
      
      private var var_3197:int = 0;
      
      private var _habboTracking:class_53 = null;
      
      private var var_5079:Boolean = false;
      
      private var var_3723:Boolean = false;
      
      private var var_4748:Boolean = false;
      
      private var var_2624:class_3348 = null;
      
      public function RoomSession()
      {
         super();
         var_1480 = new UserDataManager();
      }
      
      public function set connection(param1:IConnection) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_37 = param1;
         if(var_1480 != null)
         {
            var_1480.connection = param1;
         }
      }
      
      public function dispose() : void
      {
         var_37 = null;
         if(var_1480 != null)
         {
            var_1480.dispose();
            var_1480 = null;
         }
         if(var_1729 != null)
         {
            var_1729.dispose();
            var_1729 = null;
         }
         if(var_974)
         {
            var_974.dispose();
            var_974 = null;
         }
         if(var_2624 != null)
         {
            var_2624 = null;
         }
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function set roomId(param1:int) : void
      {
         var_1951 = param1;
      }
      
      public function get roomPassword() : String
      {
         return var_2861;
      }
      
      public function set roomPassword(param1:String) : void
      {
         var_2861 = param1;
      }
      
      public function get roomResources() : String
      {
         return var_3944;
      }
      
      public function set roomResources(param1:String) : void
      {
         var_3944 = param1;
      }
      
      public function get openConnectionComposer() : IMessageComposer
      {
         return var_974;
      }
      
      public function set openConnectionComposer(param1:IMessageComposer) : void
      {
         var_974 = param1;
      }
      
      public function get state() : String
      {
         return var_61;
      }
      
      public function get habboTracking() : class_53
      {
         return _habboTracking;
      }
      
      public function set habboTracking(param1:class_53) : void
      {
         _habboTracking = param1;
      }
      
      public function get isGameSession() : Boolean
      {
         return var_3723;
      }
      
      public function set isGameSession(param1:Boolean) : void
      {
         var_3723 = param1;
      }
      
      public function get roomModerationSettings() : class_3348
      {
         return var_2624;
      }
      
      public function set roomModerationSettings(param1:class_3348) : void
      {
         var_2624 = param1;
      }
      
      public function get playTestMode() : Boolean
      {
         return var_2234;
      }
      
      public function set playTestMode(param1:Boolean) : void
      {
         var_2234 = param1;
      }
      
      public function trackEventLogOncePerSession(param1:String, param2:String, param3:String) : void
      {
         _habboTracking.trackEventLogOncePerSession(param1,param2,param3);
      }
      
      public function start() : Boolean
      {
         if(var_61 == "RSE_CREATED" && var_37 != null)
         {
            var_61 = "RSE_STARTED";
            if(!var_4338)
            {
               if(var_974)
               {
                  return sendPredefinedOpenConnection();
               }
               return sendOpenFlatConnectionMessage();
            }
            return true;
         }
         return false;
      }
      
      public function reset(param1:int) : void
      {
         if(param1 != var_1951)
         {
            var_1951 = param1;
            var_2507 = false;
            var_1873 = 0;
            var_2859 = 0;
            var_2810 = false;
         }
      }
      
      private function sendOpenFlatConnectionMessage() : Boolean
      {
         if(var_37 == null)
         {
            return false;
         }
         var_37.send(new OpenFlatConnectionMessageComposer(var_1951,var_2861));
         return true;
      }
      
      private function sendPredefinedOpenConnection() : Boolean
      {
         if(var_37 == null)
         {
            return false;
         }
         var_37.send(var_974);
         var_974 = null;
         return true;
      }
      
      public function sendChatMessage(param1:String, param2:int = 0) : void
      {
         if(var_3723)
         {
            var_37.send(new Game2GameChatMessageComposer(param1));
         }
         else
         {
            param1 = param1.replace(/&#[0-9]+;/g,"");
            var_37.send(new ChatMessageComposer(param1,param2,var_3197));
            var_1729.add(var_3197,getTimer());
            var_3197 = var_3197 + 1;
         }
      }
      
      public function sendChangeMottoMessage(param1:String) : void
      {
         var_37.send(new ChangeMottoMessageComposer(param1));
      }
      
      public function receivedChatWithTrackingId(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Object = var_1729.remove(param1);
         if(_loc2_ != null)
         {
            _loc3_ = getTimer();
            if(_loc3_ - int(_loc2_) > 2500)
            {
               if(_habboTracking != null)
               {
                  _habboTracking.chatLagDetected(_loc3_);
               }
            }
         }
      }
      
      public function sendShoutMessage(param1:String, param2:int = 0) : void
      {
         var_37.send(new ShoutMessageComposer(param1,param2));
      }
      
      public function sendWhisperMessage(param1:String, param2:String, param3:int = 0) : void
      {
         var_37.send(new WhisperMessageComposer(param1,param2,param3));
      }
      
      public function sendChatTypingMessage(param1:Boolean) : void
      {
         if(param1)
         {
            var_37.send(new StartTypingMessageComposer());
         }
         else
         {
            var_37.send(new CancelTypingMessageComposer());
         }
      }
      
      public function sendAvatarExpressionMessage(param1:int) : void
      {
         var_37.send(new AvatarExpressionMessageComposer(param1));
      }
      
      public function sendSignMessage(param1:int) : void
      {
         if(param1 >= 0 && param1 <= 17)
         {
            var_37.send(new SignMessageComposer(param1));
         }
      }
      
      public function sendDanceMessage(param1:int) : void
      {
         var_37.send(new DanceMessageComposer(param1));
      }
      
      public function sendChangePostureMessage(param1:int) : void
      {
         var_37.send(new ChangePostureMessageComposer(param1));
      }
      
      public function sendCreditFurniRedeemMessage(param1:int) : void
      {
         var_37.send(new CreditFurniRedeemMessageComposer(param1));
      }
      
      public function sendPresentOpenMessage(param1:int) : void
      {
         var_37.send(new PresentOpenMessageComposer(param1));
      }
      
      public function sendOpenPetPackageMessage(param1:int, param2:String) : void
      {
         var_37.send(new OpenPetPackageMessageComposer(param1,param2));
      }
      
      public function sendRoomDimmerGetPresetsMessage(param1:int) : void
      {
         var_37.send(new RoomDimmerGetPresetsMessageComposer(param1));
      }
      
      public function sendRoomDimmerSavePresetMessage(param1:int, param2:int, param3:uint, param4:int, param5:Boolean, param6:int) : void
      {
         var _loc7_:String = "000000" + param3.toString(16).toUpperCase();
         var _loc8_:String = "#" + _loc7_.substr(_loc7_.length - 6);
         var_37.send(new RoomDimmerSavePresetMessageComposer(param1,param2,_loc8_,param4,param5,param6));
      }
      
      public function sendRoomDimmerChangeStateMessage(param1:int) : void
      {
         var_37.send(new RoomDimmerChangeStateMessageComposer(param1));
      }
      
      public function sendConversionPoint(param1:String, param2:String, param3:String, param4:String = null, param5:int = 0) : void
      {
         var_37.send(new EventLogMessageComposer(param1,param2,param3,param4,param5));
      }
      
      public function sendPollStartMessage(param1:int) : void
      {
         var_37.send(new PollStartComposer(param1));
      }
      
      public function sendPollRejectMessage(param1:int) : void
      {
         var_37.send(new PollRejectComposer(param1));
      }
      
      public function sendPollAnswerMessage(param1:int, param2:int, param3:Array) : void
      {
         var_37.send(new PollAnswerComposer(param1,param2,param3));
      }
      
      public function sendPeerUsersClassificationMessage(param1:String) : void
      {
         var_37.send(new PeerUsersClassificationMessageComposer(param1));
      }
      
      public function sendRoomUsersClassificationMessage(param1:String) : void
      {
         var_37.send(new RoomUsersClassificationMessageComposer(param1));
      }
      
      public function sendVisitFlatMessage(param1:int) : void
      {
         var_37.send(new OpenFlatConnectionMessageComposer(param1));
      }
      
      public function sendVisitUserMessage(param1:String) : void
      {
         var_37.send(new VisitUserMessageComposer(param1));
      }
      
      public function ambassadorAlert(param1:int) : void
      {
         var_37.send(new AmbassadorAlertMessageComposer(param1));
      }
      
      public function kickUser(param1:int) : void
      {
         var_37.send(new KickUserMessageComposer(param1));
      }
      
      public function banUserWithDuration(param1:int, param2:String) : void
      {
         var_37.send(new BanUserWithDurationMessageComposer(param1,param2,roomId));
      }
      
      public function muteUser(param1:int, param2:int) : void
      {
         var_37.send(new MuteUserMessageComposer(param1,param2,roomId));
      }
      
      public function unmuteUser(param1:int) : void
      {
         var_37.send(new UnmuteUserMessageComposer(param1,roomId));
      }
      
      public function assignRights(param1:int) : void
      {
         var_37.send(new AssignRightsMessageComposer(param1));
      }
      
      public function removeRights(param1:int) : void
      {
         var _loc3_:Array = [];
         _loc3_.push(param1);
         var _loc2_:RemoveRightsMessageComposer = new RemoveRightsMessageComposer(_loc3_);
         var_37.send(_loc2_);
      }
      
      public function letUserIn(param1:String, param2:Boolean) : void
      {
         var_37.send(new LetUserInMessageComposer(param1,param2));
      }
      
      public function pickUpPet(param1:int) : void
      {
         var_37.send(new RemovePetFromFlatMessageComposer(param1));
      }
      
      public function mountPet(param1:int) : void
      {
         var_37.send(new MountPetMessageComposer(param1,true));
      }
      
      public function togglePetRidingPermission(param1:int) : void
      {
         var_37.send(new TogglePetRidingPermissionMessageComposer(param1));
      }
      
      public function togglePetBreedingPermission(param1:int) : void
      {
         var_37.send(new TogglePetBreedingPermissionMessageComposer(param1));
      }
      
      public function dismountPet(param1:int) : void
      {
         var_37.send(new MountPetMessageComposer(param1,false));
      }
      
      public function removeSaddleFromPet(param1:int) : void
      {
         var_37.send(new RemoveSaddleFromPetMessageComposer(param1));
      }
      
      public function harvestPet(param1:int) : void
      {
         var_37.send(new HarvestPetMessageComposer(param1));
      }
      
      public function compostPlant(param1:int) : void
      {
         var_37.send(new CompostPlantMessageComposer(param1));
      }
      
      public function requestPetCommands(param1:int) : void
      {
         var_37.send(new GetPetCommandsMessageComposer(param1));
      }
      
      public function useProductForPet(param1:int, param2:int) : void
      {
         var_37.send(new CustomizePetWithFurniComposer(param1,param2));
      }
      
      public function plantSeed(param1:int) : void
      {
         var_37.send(new UseFurnitureMessageComposer(param1));
      }
      
      public function sendScriptProceed() : void
      {
         var_37.send(new NewUserExperienceScriptProceedComposer());
      }
      
      public function quit() : void
      {
         if(var_37 != null)
         {
            var_37.send(new QuitMessageComposer());
         }
      }
      
      public function changeQueue(param1:int) : void
      {
         if(var_37 == null)
         {
            return;
         }
         var_37.send(new ChangeQueueMessageComposer(param1));
      }
      
      public function sendUpdateClothingChangeFurniture(param1:int, param2:String, param3:String) : void
      {
         if(var_37 == null)
         {
            return;
         }
         var _loc4_:SetClothingChangeDataMessageComposer = new SetClothingChangeDataMessageComposer(param1,param2,param3);
         var_37.send(_loc4_);
         _loc4_.dispose();
         _loc4_ = null;
      }
      
      public function get userDataManager() : class_2309
      {
         return var_1480 as class_2309;
      }
      
      public function get ownUserRoomId() : int
      {
         return var_4279;
      }
      
      public function set ownUserRoomId(param1:int) : void
      {
         var_4279 = param1;
      }
      
      public function set isRoomOwner(param1:Boolean) : void
      {
         var_2507 = param1;
      }
      
      public function get isRoomOwner() : Boolean
      {
         return var_2507;
      }
      
      public function set roomControllerLevel(param1:int) : void
      {
         if(param1 >= 0 && param1 <= 5)
         {
            var_1873 = param1;
         }
         else
         {
            class_21.log("Invalid roomControllerLevel " + param1 + ", setting to ROOM_CONTROL_LEVEL_NONE instead");
            var_1873 = 0;
         }
      }
      
      public function get roomControllerLevel() : int
      {
         if(var_2234)
         {
            return 0;
         }
         return var_1873;
      }
      
      public function get tradeMode() : int
      {
         return var_2859;
      }
      
      public function get isPrivateRoom() : Boolean
      {
         return true;
      }
      
      public function set tradeMode(param1:int) : void
      {
         var_2859 = param1;
      }
      
      public function get isGuildRoom() : Boolean
      {
         return _isGuildRoom;
      }
      
      public function set isGuildRoom(param1:Boolean) : void
      {
         _isGuildRoom = param1;
      }
      
      public function get isNoobRoom() : Boolean
      {
         return var_4157 == 4;
      }
      
      public function set doorMode(param1:int) : void
      {
         var_4157 = param1;
      }
      
      public function get isSpectatorMode() : Boolean
      {
         return var_2810;
      }
      
      public function set isSpectatorMode(param1:Boolean) : void
      {
         var_2810 = param1;
      }
      
      public function get arePetsAllowed() : Boolean
      {
         return var_4964;
      }
      
      public function set arePetsAllowed(param1:Boolean) : void
      {
         var_4964 = param1;
      }
      
      public function get areBotsAllowed() : Boolean
      {
         return var_2507;
      }
      
      public function get isUserDecorating() : Boolean
      {
         return var_5079;
      }
      
      public function set isUserDecorating(param1:Boolean) : void
      {
         var_5079 = param1;
      }
      
      public function get isNuxNotComplete() : Boolean
      {
         return var_4748;
      }
      
      public function set isNuxNotComplete(param1:Boolean) : void
      {
         var_4748 = param1;
      }
      
      public function set skipOpc(param1:Boolean) : void
      {
         var_4338 = param1;
      }
   }
}

