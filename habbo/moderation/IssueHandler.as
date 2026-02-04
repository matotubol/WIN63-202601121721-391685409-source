package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import flash.utils.getTimer;
   import package_122.class_2920;
   import package_122.class_3539;
   import package_18.class_2218;
   import package_18.class_3499;
   import package_79.class_3291;
   
   public class IssueHandler implements ITrackedWindow, IIssueHandler, class_31
   {
      
      private static const USELESS_REPORTS_TOPIC_ID:int = 27;
      
      private static const AUTO_TOPIC_ID:int = 28;
      
      private static const const_1093:int = 1;
      
      private static const AUTO_TRIGGERED_CATEGORY_ID:int = 3;
      
      private var _moderationManager:ModerationManager;
      
      private var var_164:IssueBundle;
      
      private var var_821:class_3291;
      
      private var _window:class_2250;
      
      private var var_4948:Vector.<class_2218>;
      
      private var var_2668:Array;
      
      private var _topicDropdown:class_2261;
      
      private var _callerUserInfo:UserInfoCtrl;
      
      private var _reportedUserInfo:UserInfoCtrl;
      
      private var _disposed:Boolean;
      
      private var var_4531:int;
      
      private var var_1783:ChatlogCtrl;
      
      private var _chatFrame:class_1812;
      
      private var var_1387:IItemListWindow;
      
      private var var_2362:int = 0;
      
      private var var_1239:int;
      
      private var var_1204:int;
      
      private var _lastWindowWidth:int;
      
      private var var_1319:int;
      
      private var var_3354:uint = getTimer();
      
      private var var_1959:class_1812;
      
      private var var_1842:ITextFieldWindow;
      
      public function IssueHandler(param1:ModerationManager, param2:IssueBundle, param3:Vector.<class_2218>, param4:int, param5:int, param6:int, param7:int)
      {
         super();
         _moderationManager = param1;
         var_164 = param2;
         var_4948 = param3;
         var_1239 = param4;
         var_1204 = param5;
         _lastWindowWidth = param6;
         var_1319 = param7;
      }
      
      public function getType() : int
      {
         return 8;
      }
      
      public function getId() : String
      {
         return "" + var_164.id;
      }
      
      public function getFrame() : class_2250
      {
         return _window;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(this._callerUserInfo != null)
         {
            this._callerUserInfo.dispose();
            this._callerUserInfo = null;
         }
         if(this._reportedUserInfo != null)
         {
            this._reportedUserInfo.dispose();
            this._reportedUserInfo = null;
         }
         if(this.var_1783 != null)
         {
            this.var_1783.dispose();
            this.var_1783 = null;
         }
         if(var_1959)
         {
            var_1959.dispose();
            var_1959 = null;
         }
         if(var_1842)
         {
            var_1842.dispose();
            var_1842 = null;
         }
         _moderationManager.removeUpdateReceiver(this);
         _moderationManager = null;
         var_164 = null;
      }
      
      public function show() : void
      {
         if(_window != null)
         {
            return;
         }
         if(_moderationManager.windowManager == null || _moderationManager.assets == null)
         {
            return;
         }
         _window = _moderationManager.getXmlWindow("issue_handler") as class_2250;
         if(_window == null)
         {
            return;
         }
         var _loc3_:IItemListWindow = _window.findChildByName("issues_item_list") as IItemListWindow;
         var_1959 = _loc3_.getListItemAt(0) as class_1812;
         _loc3_.removeListItems();
         var _loc2_:IItemListWindow = _window.findChildByName("msg_item_list") as IItemListWindow;
         var_1842 = _loc2_.getListItemAt(0) as ITextFieldWindow;
         _loc2_.removeListItems();
         var _loc7_:class_1741 = _window.findChildByTag("close");
         if(_loc7_ != null)
         {
            _loc7_.addEventListener("WME_CLICK",onClose);
         }
         _loc7_ = _window.findChildByName("issue_cont");
         if(_loc7_ != null)
         {
            _loc7_.addEventListener("WE_RELOCATED",onWindowRelocatedOrResized);
            _loc7_.addEventListener("WE_RESIZED",onWindowRelocatedOrResized);
            _moderationManager.registerUpdateReceiver(this,1000);
         }
         var_3354 = getTimer();
         setProc("close_useless",onCloseUseless);
         setProc("close_sanction",onCloseSanction);
         setProc("close_resolved",onCloseResolved);
         setProc("release",onRelease);
         _loc7_ = _window.findChildByName("move_to_player_support");
         if(_loc7_ != null)
         {
            _loc7_.disable();
         }
         _moderationManager.issueManager.requestSanctionData(var_164.id,-1);
         initializeTopicDropdown();
         var_821 = var_164.getHighestPriorityIssue();
         _callerUserInfo = new UserInfoCtrl(_window,_moderationManager,var_821,this);
         _reportedUserInfo = new UserInfoCtrl(_window,_moderationManager,var_821,this);
         _callerUserInfo.load(class_1812(_window.findChildByName("caller_user_info")),var_821.reporterUserId);
         if(var_821.categoryId == 3 && var_821.reportedCategoryId == 28)
         {
            _topicDropdown.selection = var_4531;
            _moderationManager.issueManager.requestSanctionData(var_164.id,1);
         }
         var _loc1_:class_1812 = class_1812(_window.findChildByName("reported_user_info"));
         if(var_164.reportedUserId > 0)
         {
            _reportedUserInfo.load(_loc1_,var_164.reportedUserId);
         }
         else
         {
            var _loc5_:IItemListWindow = IItemListWindow(_window.findChildByName("issue_cont"));
            var _loc6_:class_1741 = _window.findChildByName("reported_user_info_caption");
            null.removeListItem(null);
            null.removeListItem(_loc1_);
         }
         var _loc4_:class_1885 = _window.findChildByName("handle_next_checkbox") as class_1885;
         if(_loc4_ != null)
         {
            _loc4_.select();
         }
         _chatFrame = class_1812(_window.findChildByName("chat_cont"));
         var_1387 = IItemListWindow(_chatFrame.findChildByName("evidence_list"));
         var_1783 = new ChatlogCtrl(new class_3539(var_821.issueId),_moderationManager,3,var_821.issueId,var_821,_chatFrame,var_1387,true);
         var_1783.show();
         class_21.log("HARASSER: " + var_164.reportedUserId);
         updateIssueList();
         updateMessages();
      }
      
      private function sendWindowPreferences() : void
      {
         var_1239 = _window.x;
         var_1204 = _window.y;
         _lastWindowWidth = _window.width;
         var_1319 = _window.height;
         _moderationManager.issueManager.setToolPreferences(var_1239,var_1204,_lastWindowWidth,var_1319);
         _moderationManager.connection.send(new class_2920(var_1239,var_1204,_lastWindowWidth,var_1319));
      }
      
      private function windowDimensionsChanged() : Boolean
      {
         if(var_1239 != _window.x)
         {
            return true;
         }
         if(var_1204 != _window.y)
         {
            return true;
         }
         if(_lastWindowWidth != _window.width)
         {
            return true;
         }
         if(var_1319 != _window.height)
         {
            return true;
         }
         return false;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:uint = uint(getTimer());
         if(windowDimensionsChanged() && _loc2_ - var_3354 > 5000)
         {
            sendWindowPreferences();
         }
      }
      
      private function onWindowRelocatedOrResized(param1:class_1758) : void
      {
         var _loc4_:IItemListWindow = param1.window as IItemListWindow;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:IItemListWindow = _loc4_.getListItemByName("issues_item_list") as IItemListWindow;
         var _loc3_:IItemListWindow = _loc4_.getListItemByName("msg_item_list") as IItemListWindow;
         if(_loc5_ == null || _loc3_ == null)
         {
            return;
         }
         var _loc2_:int = (_loc4_.height - _loc4_.scrollableRegion.height + _loc5_.height + _loc3_.height) * 0.5;
         _loc4_.autoArrangeItems = false;
         _loc5_.height = _loc2_;
         _loc3_.height = _loc2_;
         _loc4_.autoArrangeItems = true;
      }
      
      private function updateIssueList() : void
      {
         var _loc1_:class_1812 = null;
         var _loc10_:class_1812 = null;
         var _loc2_:class_1741 = null;
         var _loc4_:* = null;
         var _loc13_:String = null;
         if(_window == null)
         {
            return;
         }
         var _loc6_:IItemListWindow = _window.findChildByName("issues_item_list") as IItemListWindow;
         if(_loc6_ == null)
         {
            return;
         }
         var _loc8_:Array = var_164.issues;
         var _loc7_:int = 0;
         var _loc12_:int = _loc6_.numListItems;
         var _loc3_:int = int(_loc8_.length);
         if(_loc12_ < _loc3_)
         {
            _loc1_ = var_1959.clone() as class_1812;
            _loc6_.addListItem(_loc1_);
            _loc7_ = 1;
            while(_loc7_ < _loc3_ - _loc12_)
            {
               _loc10_ = _loc1_.clone() as class_1812;
               if(_loc10_ == null)
               {
                  return;
               }
               _loc6_.addListItem(_loc10_);
               _loc7_++;
            }
         }
         else if(_loc12_ > _loc3_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc12_ - _loc3_)
            {
               _loc2_ = _loc6_.removeListItemAt(0);
               _loc2_.dispose();
               _loc7_++;
            }
         }
         var _loc9_:class_3291 = var_164.getHighestPriorityIssue();
         var _loc11_:int = int(_loc9_ == null ? 0 : _loc9_.issueId);
         var _loc5_:int = getTimer();
         _loc7_ = 0;
         for each(_loc4_ in _loc8_)
         {
            _loc1_ = _loc6_.getListItemAt(_loc7_) as class_1812;
            if(_loc1_ == null)
            {
               return;
            }
            _loc1_.background = _loc7_++ % 2 == 0;
            _loc1_.id = _loc4_.issueId;
            _loc1_.removeEventListener("WME_CLICK",onIssueClicked);
            _loc1_.addEventListener("WME_CLICK",onIssueClicked);
            setCaption(_loc1_.findChildByName("reporter"),_loc4_.reporterUserName);
            setCaption(_loc1_.findChildByName("type"),class_2078.getSourceName(_loc4_.categoryId));
            setCaption(_loc1_.findChildByName("category"),class_2078.getCategoryName(_loc4_.reportedCategoryId));
            setCaption(_loc1_.findChildByName("time_open"),_loc4_.getOpenTime(_loc5_));
            _loc13_ = _loc4_.issueId == _loc11_ && _loc3_ > 1 ? "Volter Bold" : "Volter";
            (_loc1_.findChildByName("category") as ITextWindow).fontFace = _loc13_;
         }
      }
      
      private function updateMessages() : void
      {
         var _loc1_:ITextFieldWindow = null;
         var _loc6_:ITextWindow = null;
         var _loc2_:class_1741 = null;
         var _loc5_:* = null;
         if(_window == null)
         {
            return;
         }
         var _loc4_:IItemListWindow = _window.findChildByName("msg_item_list") as IItemListWindow;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc8_:Array = var_164.issues;
         var _loc7_:int = 0;
         var _loc9_:int = _loc4_.numListItems;
         var _loc3_:int = int(_loc8_.length);
         if(_loc9_ < _loc3_)
         {
            _loc1_ = var_1842.clone() as ITextFieldWindow;
            _loc1_.selectable = true;
            _loc1_.editable = false;
            _loc4_.addListItem(_loc1_);
            _loc7_ = 1;
            while(_loc7_ < _loc3_ - _loc9_)
            {
               _loc6_ = _loc1_.clone() as ITextWindow;
               if(_loc6_ == null)
               {
                  return;
               }
               _loc4_.addListItem(_loc6_);
               _loc7_++;
            }
         }
         else if(_loc9_ > _loc3_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc9_ - _loc3_)
            {
               _loc2_ = _loc4_.removeListItemAt(0);
               _loc2_.dispose();
               _loc7_++;
            }
         }
         _loc7_ = 0;
         for each(_loc5_ in _loc8_)
         {
            _loc1_ = _loc4_.getListItemAt(_loc7_) as ITextFieldWindow;
            if(_loc1_ == null)
            {
               return;
            }
            _loc1_.width = _loc4_.width;
            _loc1_.background = _loc7_++ % 2 == 0;
            _loc1_.caption = _loc5_.reporterUserName + ": " + _loc5_.message;
            _loc1_.height = _loc1_.textHeight + 10;
         }
      }
      
      private function setCaption(param1:class_1741, param2:String) : void
      {
         if(param1 != null)
         {
            param1.caption = param2;
         }
      }
      
      private function initializeTopicDropdown() : void
      {
         _topicDropdown = _window.findChildByName("cfh_topics") as class_2261;
         var _loc1_:* = -1;
         var _loc6_:int = var_164.getHighestPriorityIssue().reportedCategoryId;
         if(_loc6_ == 27)
         {
            _topicDropdown.disable();
            return;
         }
         var_2668 = [];
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         for each(var _loc5_ in var_4948)
         {
            for each(var _loc4_ in _loc5_.topics)
            {
               _loc2_[_loc3_] = "${help.cfh.topic." + _loc4_.id + "}";
               var_2668[_loc3_] = _loc4_.id;
               if(_loc4_.id == 1)
               {
                  var_4531 = _loc3_;
               }
               if(_loc4_.id == _loc6_)
               {
                  _loc1_ = _loc3_;
               }
               _loc3_++;
            }
         }
         _topicDropdown.populate(_loc2_);
         if(_loc1_ >= 0)
         {
            _topicDropdown.selection = _loc1_;
         }
         _topicDropdown.addEventListener("WE_SELECTED",refreshSanctionDataForSelectedTopic);
      }
      
      private function refreshSanctionDataForSelectedTopic(param1:class_1758) : void
      {
         var _loc3_:int = _topicDropdown.selection;
         var _loc2_:int = int(var_2668[_loc3_]);
         _moderationManager.issueManager.requestSanctionData(var_164.id,_loc2_);
      }
      
      private function setProc(param1:String, param2:Function) : void
      {
         _window.findChildByName(param1).addEventListener("WME_CLICK",param2);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         if(_moderationManager != null && _moderationManager.issueManager != null && var_164 != null)
         {
            _moderationManager.issueManager.removeHandler(var_164.id);
            trackAction("closeWindow");
         }
         this.dispose();
      }
      
      private function onCloseUseless(param1:WindowMouseEvent) : void
      {
         class_21.log("Close useless clicked");
         trackAction("closeUseless");
         _moderationManager.trackGoogle("actionCountUseless",var_2362);
         _moderationManager.issueManager.closeBundle(var_164.id,1);
         checkAutoHandling();
         dispose();
      }
      
      private function onCloseResolved(param1:WindowMouseEvent) : void
      {
         class_21.log("Close resolved clicked");
         trackAction("closeResolved");
         _moderationManager.trackGoogle("actionCountResolved",var_2362);
         _moderationManager.issueManager.closeBundle(var_164.id,3);
         checkAutoHandling();
         dispose();
      }
      
      private function onCloseSanction(param1:WindowMouseEvent) : void
      {
         class_21.log("Close with default sanction clicked");
         trackAction("closeSanction");
         _moderationManager.trackGoogle("actionCountSanction",var_2362);
         var _loc3_:int = _topicDropdown.selection;
         if(_loc3_ >= 0)
         {
            var _loc2_:int = int(var_2668[_loc3_]);
         }
         if(var_164.getHighestPriorityIssue().reportedCategoryId == 28)
         {
            _moderationManager.windowManager.alert("Topic missing","You need to select the topic first.",0,null);
         }
         else
         {
            _moderationManager.issueManager.closeDefaultAction(var_164.id,-1);
            checkAutoHandling();
            dispose();
         }
      }
      
      private function onRelease(param1:WindowMouseEvent) : void
      {
         class_21.log("Release clicked");
         trackAction("release");
         _moderationManager.issueManager.releaseBundle(var_164.id);
         checkAutoHandling();
         dispose();
      }
      
      private function onIssueClicked(param1:WindowMouseEvent) : void
      {
         for each(var _loc2_ in var_164.issues)
         {
            if(_loc2_.issueId == param1.window.id)
            {
               var_821 = _loc2_;
               var _loc3_:int = _loc2_.reporterUserId;
               break;
            }
         }
      }
      
      public function updateIssuesAndMessages() : void
      {
         updateIssueList();
         updateMessages();
      }
      
      public function showDefaultSanction(param1:int, param2:String) : void
      {
         if(_window == null || _moderationManager == null || _moderationManager.issueManager == null || var_164 == null)
         {
            return;
         }
         if(param1 != var_164.reportedUserId)
         {
            return;
         }
         var _loc3_:ITextWindow = _window.findChildByName("sanction_label") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.caption = param2;
         }
      }
      
      private function checkAutoHandling() : void
      {
         if(_window == null || _moderationManager == null || _moderationManager.issueManager == null)
         {
            return;
         }
         var _loc1_:class_1885 = _window.findChildByName("handle_next_checkbox") as class_1885;
         if(_loc1_ != null && Boolean(_loc1_.isSelected))
         {
            _moderationManager.issueManager.autoPick("issue handler pick next");
         }
      }
      
      internal function get callerUserInfo() : UserInfoCtrl
      {
         return _callerUserInfo;
      }
      
      internal function get reportedUserInfo() : UserInfoCtrl
      {
         return _reportedUserInfo;
      }
      
      internal function trackAction(param1:String) : void
      {
         if(_moderationManager == null || _moderationManager.disposed)
         {
            return;
         }
         var_2362 = var_2362 + 1;
         _moderationManager.trackGoogle("issueHandler_" + param1);
      }
   }
}

