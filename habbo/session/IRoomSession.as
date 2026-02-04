package com.sulake.habbo.session
{
   import package_32.class_3348;
   
   public interface IRoomSession
   {
      
      function get roomId() : int;
      
      function get roomResources() : String;
      
      function get state() : String;
      
      function start() : Boolean;
      
      function sendChatMessage(param1:String, param2:int = 0) : void;
      
      function sendChangeMottoMessage(param1:String) : void;
      
      function sendShoutMessage(param1:String, param2:int = 0) : void;
      
      function sendWhisperMessage(param1:String, param2:String, param3:int = 0) : void;
      
      function sendChatTypingMessage(param1:Boolean) : void;
      
      function sendAvatarExpressionMessage(param1:int) : void;
      
      function sendSignMessage(param1:int) : void;
      
      function sendDanceMessage(param1:int) : void;
      
      function sendChangePostureMessage(param1:int) : void;
      
      function sendCreditFurniRedeemMessage(param1:int) : void;
      
      function sendPresentOpenMessage(param1:int) : void;
      
      function sendOpenPetPackageMessage(param1:int, param2:String) : void;
      
      function sendRoomDimmerGetPresetsMessage(param1:int) : void;
      
      function sendRoomDimmerSavePresetMessage(param1:int, param2:int, param3:uint, param4:int, param5:Boolean, param6:int) : void;
      
      function sendRoomDimmerChangeStateMessage(param1:int) : void;
      
      function sendConversionPoint(param1:String, param2:String, param3:String, param4:String = null, param5:int = 0) : void;
      
      function sendPollStartMessage(param1:int) : void;
      
      function sendPollRejectMessage(param1:int) : void;
      
      function sendPollAnswerMessage(param1:int, param2:int, param3:Array) : void;
      
      function sendPeerUsersClassificationMessage(param1:String) : void;
      
      function sendRoomUsersClassificationMessage(param1:String) : void;
      
      function sendVisitFlatMessage(param1:int) : void;
      
      function sendVisitUserMessage(param1:String) : void;
      
      function ambassadorAlert(param1:int) : void;
      
      function kickUser(param1:int) : void;
      
      function banUserWithDuration(param1:int, param2:String) : void;
      
      function muteUser(param1:int, param2:int) : void;
      
      function unmuteUser(param1:int) : void;
      
      function assignRights(param1:int) : void;
      
      function removeRights(param1:int) : void;
      
      function letUserIn(param1:String, param2:Boolean) : void;
      
      function pickUpPet(param1:int) : void;
      
      function mountPet(param1:int) : void;
      
      function togglePetRidingPermission(param1:int) : void;
      
      function dismountPet(param1:int) : void;
      
      function removeSaddleFromPet(param1:int) : void;
      
      function requestPetCommands(param1:int) : void;
      
      function useProductForPet(param1:int, param2:int) : void;
      
      function plantSeed(param1:int) : void;
      
      function quit() : void;
      
      function changeQueue(param1:int) : void;
      
      function sendUpdateClothingChangeFurniture(param1:int, param2:String, param3:String) : void;
      
      function receivedChatWithTrackingId(param1:int) : void;
      
      function get ownUserRoomId() : int;
      
      function set ownUserRoomId(param1:int) : void;
      
      function get isRoomOwner() : Boolean;
      
      function set isRoomOwner(param1:Boolean) : void;
      
      function set roomControllerLevel(param1:int) : void;
      
      function get roomControllerLevel() : int;
      
      function get isGuildRoom() : Boolean;
      
      function set isGuildRoom(param1:Boolean) : void;
      
      function get isNoobRoom() : Boolean;
      
      function set doorMode(param1:int) : void;
      
      function get tradeMode() : int;
      
      function get isPrivateRoom() : Boolean;
      
      function set tradeMode(param1:int) : void;
      
      function get userDataManager() : class_2309;
      
      function get isSpectatorMode() : Boolean;
      
      function set isSpectatorMode(param1:Boolean) : void;
      
      function get arePetsAllowed() : Boolean;
      
      function set arePetsAllowed(param1:Boolean) : void;
      
      function get areBotsAllowed() : Boolean;
      
      function get isUserDecorating() : Boolean;
      
      function set isUserDecorating(param1:Boolean) : void;
      
      function get isGameSession() : Boolean;
      
      function get roomModerationSettings() : class_3348;
      
      function set roomModerationSettings(param1:class_3348) : void;
      
      function get playTestMode() : Boolean;
      
      function set playTestMode(param1:Boolean) : void;
      
      function get isNuxNotComplete() : Boolean;
      
      function set isNuxNotComplete(param1:Boolean) : void;
      
      function harvestPet(param1:int) : void;
      
      function togglePetBreedingPermission(param1:int) : void;
      
      function compostPlant(param1:int) : void;
      
      function sendScriptProceed() : void;
      
      function trackEventLogOncePerSession(param1:String, param2:String, param3:String) : void;
   }
}

