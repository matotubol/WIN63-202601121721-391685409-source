package com.sulake.habbo.session
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.tracking.class_53;
   import flash.utils.getTimer;
   import package_102.class_2357;
   import package_102.class_2550;
   import package_102.class_3178;
   import package_107.class_2935;
   import package_107.class_3129;
   import package_107.class_3154;
   import package_107.class_3399;
   import package_107.class_3560;
   import package_112.class_3244;
   import package_115.Game2GameChatMessageComposer;
   import package_125.class_2453;
   import package_125.class_2604;
   import package_125.class_2816;
   import package_125.class_2867;
   import package_125.class_2895;
   import package_125.class_2951;
   import package_125.class_3036;
   import package_125.class_3546;
   import package_150.class_2652;
   import package_150.class_3421;
   import package_28.class_3357;
   import package_32.class_3348;
   import package_55.class_2325;
   import package_55.class_2333;
   import package_55.class_2399;
   import package_55.class_2722;
   import package_55.class_2851;
   import package_55.class_2854;
   import package_55.class_2945;
   import package_55.class_3438;
   import package_55.class_3536;
   import package_55.class_3554;
   import package_59.class_2064;
   import package_59.class_3264;
   import package_59.class_3287;
   import package_59.class_3301;
   import package_59.class_3488;
   import package_66.class_3276;
   import package_71.class_2196;
   import package_72.class_2203;
   import package_72.class_2346;
   import package_72.class_2589;
   import package_94.class_2667;
   import package_94.class_2921;
   import package_94.class_3047;
   import package_94.class_3197;
   import package_94.class_3222;
   import package_94.class_3571;
   
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
         var_37.send(new class_2203(var_1951,var_2861));
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
            var_37.send(new class_2064(param1,param2,var_3197));
            var_1729.add(var_3197,getTimer());
            var_3197 = var_3197 + 1;
         }
      }
      
      public function sendChangeMottoMessage(param1:String) : void
      {
         var_37.send(new class_3154(param1));
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
         var_37.send(new class_3264(param1,param2));
      }
      
      public function sendWhisperMessage(param1:String, param2:String, param3:int = 0) : void
      {
         var_37.send(new class_3301(param1,param2,param3));
      }
      
      public function sendChatTypingMessage(param1:Boolean) : void
      {
         if(param1)
         {
            var_37.send(new class_3488());
         }
         else
         {
            var_37.send(new class_3287());
         }
      }
      
      public function sendAvatarExpressionMessage(param1:int) : void
      {
         var_37.send(new class_3560(param1));
      }
      
      public function sendSignMessage(param1:int) : void
      {
         if(param1 >= 0 && param1 <= 17)
         {
            var_37.send(new class_2935(param1));
         }
      }
      
      public function sendDanceMessage(param1:int) : void
      {
         var_37.send(new class_3129(param1));
      }
      
      public function sendChangePostureMessage(param1:int) : void
      {
         var_37.send(new class_3399(param1));
      }
      
      public function sendCreditFurniRedeemMessage(param1:int) : void
      {
         var_37.send(new class_3571(param1));
      }
      
      public function sendPresentOpenMessage(param1:int) : void
      {
         var_37.send(new class_3197(param1));
      }
      
      public function sendOpenPetPackageMessage(param1:int, param2:String) : void
      {
         var_37.send(new class_2667(param1,param2));
      }
      
      public function sendRoomDimmerGetPresetsMessage(param1:int) : void
      {
         var_37.send(new class_3047(param1));
      }
      
      public function sendRoomDimmerSavePresetMessage(param1:int, param2:int, param3:uint, param4:int, param5:Boolean, param6:int) : void
      {
         var _loc7_:String = "000000" + param3.toString(16).toUpperCase();
         var _loc8_:String = "#" + _loc7_.substr(_loc7_.length - 6);
         var_37.send(new class_3222(param1,param2,_loc8_,param4,param5,param6));
      }
      
      public function sendRoomDimmerChangeStateMessage(param1:int) : void
      {
         var_37.send(new class_2921(param1));
      }
      
      public function sendConversionPoint(param1:String, param2:String, param3:String, param4:String = null, param5:int = 0) : void
      {
         var_37.send(new class_2196(param1,param2,param3,param4,param5));
      }
      
      public function sendPollStartMessage(param1:int) : void
      {
         var_37.send(new class_2550(param1));
      }
      
      public function sendPollRejectMessage(param1:int) : void
      {
         var_37.send(new class_3178(param1));
      }
      
      public function sendPollAnswerMessage(param1:int, param2:int, param3:Array) : void
      {
         var_37.send(new class_2357(param1,param2,param3));
      }
      
      public function sendPeerUsersClassificationMessage(param1:String) : void
      {
         var_37.send(new class_3421(param1));
      }
      
      public function sendRoomUsersClassificationMessage(param1:String) : void
      {
         var_37.send(new class_2652(param1));
      }
      
      public function sendVisitFlatMessage(param1:int) : void
      {
         var_37.send(new class_2203(param1));
      }
      
      public function sendVisitUserMessage(param1:String) : void
      {
         var_37.send(new class_3357(param1));
      }
      
      public function ambassadorAlert(param1:int) : void
      {
         var_37.send(new class_2816(param1));
      }
      
      public function kickUser(param1:int) : void
      {
         var_37.send(new class_3546(param1));
      }
      
      public function banUserWithDuration(param1:int, param2:String) : void
      {
         var_37.send(new class_3036(param1,param2,roomId));
      }
      
      public function muteUser(param1:int, param2:int) : void
      {
         var_37.send(new class_2453(param1,param2,roomId));
      }
      
      public function unmuteUser(param1:int) : void
      {
         var_37.send(new class_2867(param1,roomId));
      }
      
      public function assignRights(param1:int) : void
      {
         var_37.send(new class_2951(param1));
      }
      
      public function removeRights(param1:int) : void
      {
         var _loc3_:Array = [];
         _loc3_.push(param1);
         var _loc2_:class_2895 = new class_2895(_loc3_);
         var_37.send(_loc2_);
      }
      
      public function letUserIn(param1:String, param2:Boolean) : void
      {
         var_37.send(new class_2604(param1,param2));
      }
      
      public function pickUpPet(param1:int) : void
      {
         var_37.send(new class_2333(param1));
      }
      
      public function mountPet(param1:int) : void
      {
         var_37.send(new class_3554(param1,true));
      }
      
      public function togglePetRidingPermission(param1:int) : void
      {
         var_37.send(new class_3536(param1));
      }
      
      public function togglePetBreedingPermission(param1:int) : void
      {
         var_37.send(new class_2722(param1));
      }
      
      public function dismountPet(param1:int) : void
      {
         var_37.send(new class_3554(param1,false));
      }
      
      public function removeSaddleFromPet(param1:int) : void
      {
         var_37.send(new class_2854(param1));
      }
      
      public function harvestPet(param1:int) : void
      {
         var_37.send(new class_2325(param1));
      }
      
      public function compostPlant(param1:int) : void
      {
         var_37.send(new class_2399(param1));
      }
      
      public function requestPetCommands(param1:int) : void
      {
         var_37.send(new class_3438(param1));
      }
      
      public function useProductForPet(param1:int, param2:int) : void
      {
         var_37.send(new class_3276(param1,param2));
      }
      
      public function plantSeed(param1:int) : void
      {
         var_37.send(new class_2945(param1));
      }
      
      public function sendScriptProceed() : void
      {
         var_37.send(new class_3244());
      }
      
      public function quit() : void
      {
         if(var_37 != null)
         {
            var_37.send(new class_2589());
         }
      }
      
      public function changeQueue(param1:int) : void
      {
         if(var_37 == null)
         {
            return;
         }
         var_37.send(new class_2346(param1));
      }
      
      public function sendUpdateClothingChangeFurniture(param1:int, param2:String, param3:String) : void
      {
         if(var_37 == null)
         {
            return;
         }
         var _loc4_:class_2851 = new class_2851(param1,param2,param3);
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

