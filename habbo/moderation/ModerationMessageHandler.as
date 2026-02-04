package com.sulake.habbo.moderation
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.userclassification.UserClassificationData;
   import flash.utils.Dictionary;
   import package_122.class_2642;
   import package_134.class_2505;
   import package_149.class_2633;
   import package_18.class_1782;
   import package_18.class_2218;
   import package_18.class_3085;
   import package_39.class_1980;
   import package_40.class_1888;
   import package_40.class_2564;
   import package_50.class_1996;
   import package_54.class_2039;
   import package_74.*;
   import package_79.*;
   
   public class ModerationMessageHandler
   {
      
      private var _moderationManager:ModerationManager;
      
      private var _userInfoListeners:Array = [];
      
      private var _roomVisitsListeners:Array = [];
      
      private var var_2752:Array = [];
      
      private var _chatlogListeners:Array = [];
      
      private var _roomInfoListeners:Array = [];
      
      private var _roomEnterListeners:Array = [];
      
      public function ModerationMessageHandler(param1:ModerationManager)
      {
         super();
         _moderationManager = param1;
         var _loc2_:IConnection = param1.connection;
         _loc2_.addMessageEvent(new class_3302(onRoomChatlog));
         _loc2_.addMessageEvent(new class_2841(onIssueDeleted));
         _loc2_.addMessageEvent(new class_2717(onModeratorActionResult));
         _loc2_.addMessageEvent(new class_1782(onCfhTopics));
         _loc2_.addMessageEvent(new class_2039(onRoomExit));
         _loc2_.addMessageEvent(new class_3531(onRoomVisits));
         _loc2_.addMessageEvent(new class_2807(onIssuePickFailed));
         _loc2_.addMessageEvent(new class_1980(onRoomEnter));
         _loc2_.addMessageEvent(new class_2456(onCfhChatlog));
         _loc2_.addMessageEvent(new class_3085(onSanctions));
         _loc2_.addMessageEvent(new class_3077(onModeratorToolPreferences));
         _loc2_.addMessageEvent(new class_3585(onModeratorInit));
         _loc2_.addMessageEvent(new class_2691(onUserInfo));
         _loc2_.addMessageEvent(new class_2633(onRoomUserClassification));
         _loc2_.addMessageEvent(new class_2924(onUserChatlog));
         _loc2_.addMessageEvent(new class_3611(onIssueInfo));
         _loc2_.addMessageEvent(new class_2855(onRoomInfo));
      }
      
      private function onIssueInfo(param1:class_3611) : void
      {
         if(param1 == null || _moderationManager == null)
         {
            return;
         }
         var _loc2_:class_3628 = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:class_3291 = _loc2_.issueData;
         _moderationManager.issueManager.playSound(_loc3_);
         _moderationManager.issueManager.updateIssue(_loc3_);
      }
      
      private function onModeratorInit(param1:class_3585) : void
      {
         var _loc4_:* = null;
         if(param1 == null || _moderationManager == null)
         {
            return;
         }
         var _loc3_:class_3480 = param1.getParser();
         if(_loc3_ == null || _loc3_.data == null)
         {
            return;
         }
         var _loc2_:class_2259 = _loc3_.data;
         var _loc6_:Array = _loc2_.issues;
         var _loc5_:Array = _loc2_.messageTemplates;
         for each(_loc4_ in _loc6_)
         {
            _moderationManager.issueManager.updateIssue(_loc4_);
         }
         _moderationManager.issueManager.updateIssueBrowser();
         _moderationManager.initMsg = _loc2_;
         _moderationManager.startPanel.show();
      }
      
      private function onModeratorToolPreferences(param1:class_3077) : void
      {
         var _loc2_:class_2579 = null;
         if(_moderationManager && _moderationManager.issueManager)
         {
            _loc2_ = param1.getParser();
            _moderationManager.issueManager.setToolPreferences(_loc2_.windowX,_loc2_.windowY,_loc2_.windowHeight,_loc2_.windowWidth);
         }
      }
      
      private function onIssuePickFailed(param1:class_2807) : void
      {
         var alert:Boolean;
         var issues:Array;
         var retryEnabled:Boolean;
         var retryCount:int;
         var pickedAlready:Boolean;
         var event:class_2807 = param1;
         var parser:class_3435 = event.getParser();
         if(parser == null)
         {
            return;
         }
         alert = true;
         issues = parser.issues;
         retryEnabled = parser.retryEnabled;
         retryCount = parser.retryCount;
         pickedAlready = _moderationManager.issueManager.issuePickFailed(issues);
         if(pickedAlready)
         {
            if(retryEnabled)
            {
               if(retryCount < 10)
               {
                  alert = false;
                  _moderationManager.issueManager.autoPick("pick failed retry",retryEnabled,retryCount);
               }
            }
         }
         if(alert)
         {
            _moderationManager.windowManager.alert("Error","Issue picking failed",0,function(param1:class_1750, param2:class_1758):void
            {
               param1.dispose();
            });
         }
      }
      
      private function onIssueDeleted(param1:class_2841) : void
      {
         if(param1 == null || _moderationManager == null)
         {
            return;
         }
         var _loc2_:class_2725 = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         _moderationManager.issueManager.removeIssue(_loc2_.issueId);
      }
      
      private function onUserInfo(param1:class_2691) : void
      {
         var _loc3_:class_2345 = param1.getParser();
         class_21.log("GOT USER INFO: " + _loc3_.data.userId + ", " + _loc3_.data.cautionCount);
         for each(var _loc2_ in _userInfoListeners)
         {
            _loc2_.onUserInfo(_loc3_.data);
         }
      }
      
      private function onRoomInfo(param1:class_2855) : void
      {
         var _loc2_:* = null;
         var _loc3_:class_3581 = param1.getParser();
         for each(_loc2_ in _roomInfoListeners)
         {
            _loc2_.onRoomInfo(_loc3_.data);
         }
      }
      
      private function onCfhChatlog(param1:class_2456) : void
      {
         var _loc3_:class_2636 = param1.getParser();
         var _loc2_:Array = [];
         _loc2_.push(_loc3_.data.chatRecord);
         var _loc4_:Dictionary = new Dictionary();
         _loc4_[_loc3_.data.callerUserId] = 0;
         _loc4_[_loc3_.data.reportedUserId] = 1;
         onChatlog("Call For Help Evidence #" + _loc3_.data.chatRecordId,3,_loc3_.data.callId,_loc2_,_loc4_);
      }
      
      private function onRoomChatlog(param1:class_3302) : void
      {
         var _loc3_:class_3597 = param1.getParser();
         var _loc2_:Array = [];
         _loc2_.push(_loc3_.data);
         var _loc4_:Dictionary = new Dictionary();
         onChatlog("Room Chatlog: " + _loc3_.data.roomName,4,_loc3_.data.roomId,_loc2_,_loc4_);
      }
      
      private function onUserChatlog(param1:class_2924) : void
      {
         var _loc2_:class_2893 = param1.getParser();
         var _loc3_:Dictionary = new Dictionary();
         _loc3_[_loc2_.data.userId] = 0;
         onChatlog("User Chatlog: " + _loc2_.data.userName,5,_loc2_.data.userId,_loc2_.data.rooms,_loc3_);
      }
      
      private function onChatlog(param1:String, param2:int, param3:int, param4:Array, param5:Dictionary) : void
      {
         var _loc6_:Array = _chatlogListeners.concat();
         for each(var _loc7_ in _loc6_)
         {
            _loc7_.onChatlog(param1,param2,param3,param4,param5);
         }
      }
      
      private function onRoomVisits(param1:class_3531) : void
      {
         var _loc2_:* = null;
         var _loc4_:class_2730 = param1.getParser();
         var _loc3_:Array = _roomVisitsListeners.concat();
         for each(_loc2_ in _loc3_)
         {
            _loc2_.onRoomVisits(_loc4_.data);
         }
      }
      
      private function onRoomUserClassification(param1:class_2633) : void
      {
         var _loc9_:* = null;
         var _loc5_:class_2505 = (param1 as class_2633).getParser();
         var _loc10_:class_55 = _loc5_.classifiedUsernameMap;
         var _loc3_:class_55 = _loc5_.classifiedUserTypeMap;
         var _loc7_:Array = [];
         for each(var _loc8_ in _loc10_.getKeys())
         {
            _loc7_.push(new UserClassificationData(_loc8_,_loc10_[_loc8_],_loc3_[_loc8_]));
         }
         var _loc2_:UserClassificationCtrl = new UserClassificationCtrl(_moderationManager,1);
         _loc2_.show();
         var _loc4_:Array = var_2752.concat();
         for each(_loc9_ in _loc4_)
         {
            _loc9_.onUserClassification(1,_loc7_);
         }
      }
      
      private function onSanctions(param1:class_3085) : void
      {
         var _loc2_:class_2564 = param1.getParser();
         class_21.log("Got sanction data..." + [_loc2_.issueId,_loc2_.accountId,_loc2_.sanctionType]);
         _moderationManager.issueManager.updateSanctionData(_loc2_.issueId,_loc2_.accountId,_loc2_.sanctionType);
      }
      
      private function onCfhTopics(param1:class_1782) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:class_1888 = param1.getParser();
         _loc2_ = _loc3_.callForHelpCategories;
         _moderationManager.cfhTopics = _loc2_;
      }
      
      private function onRoomEnter(param1:class_1980) : void
      {
         var _loc2_:* = null;
         var _loc3_:class_1996 = param1.getParser();
         this._moderationManager.currentFlatId = _loc3_.guestRoomId;
         this._moderationManager.startPanel.guestRoomEntered(_loc3_);
         for each(_loc2_ in _roomEnterListeners)
         {
            _loc2_.onRoomChange();
         }
      }
      
      private function onRoomExit(param1:class_2039) : void
      {
         var _loc2_:* = null;
         this._moderationManager.currentFlatId = 0;
         this._moderationManager.startPanel.roomExited();
         for each(_loc2_ in _roomEnterListeners)
         {
            _loc2_.onRoomChange();
         }
      }
      
      private function onModeratorActionResult(param1:class_2717) : void
      {
         var _loc2_:class_2861 = param1.getParser();
         class_21.log("GOT MOD ACTION RESULT: " + _loc2_.userId + ", " + _loc2_.success);
         if(_loc2_.success)
         {
            _moderationManager.connection.send(new class_2642(_loc2_.userId));
         }
         else
         {
            _moderationManager.windowManager.alert("Alert","Moderation action failed. If you tried to ban a user, please check if the user is already banned.",0,onAlertClose);
         }
      }
      
      public function addUserInfoListener(param1:class_3145) : void
      {
         _userInfoListeners.push(param1);
      }
      
      public function removeUserInfoListener(param1:class_3145) : void
      {
         var _loc3_:Array = [];
         for each(var _loc2_ in _userInfoListeners)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _userInfoListeners = _loc3_;
      }
      
      public function addRoomInfoListener(param1:RoomToolCtrl) : void
      {
         _roomInfoListeners.push(param1);
      }
      
      public function removeRoomInfoListener(param1:RoomToolCtrl) : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         for each(_loc2_ in _roomInfoListeners)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _roomInfoListeners = _loc3_;
      }
      
      public function addRoomEnterListener(param1:RoomToolCtrl) : void
      {
         _roomEnterListeners.push(param1);
      }
      
      public function removeRoomEnterListener(param1:RoomToolCtrl) : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         for each(_loc2_ in _roomEnterListeners)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _roomEnterListeners = _loc3_;
      }
      
      public function addRoomVisitsListener(param1:RoomVisitsCtrl) : void
      {
         _roomVisitsListeners.push(param1);
      }
      
      public function removeRoomVisitsListener(param1:RoomVisitsCtrl) : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         for each(_loc2_ in _roomVisitsListeners)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _roomVisitsListeners = _loc3_;
      }
      
      public function addChatlogListener(param1:class_2879) : void
      {
         _chatlogListeners.push(param1);
      }
      
      public function removeChatlogListener(param1:class_2879) : void
      {
         var _loc3_:Array = [];
         for each(var _loc2_ in _chatlogListeners)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _chatlogListeners = _loc3_;
      }
      
      public function addUserClassificationListener(param1:UserClassificationCtrl) : void
      {
         var_2752.push(param1);
      }
      
      public function removeUserClassificationListener(param1:UserClassificationCtrl) : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         for each(_loc2_ in var_2752)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _roomVisitsListeners = _loc3_;
      }
      
      private function onAlertClose(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
      }
   }
}

