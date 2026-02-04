package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.class_2143;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.friendlist.domain.FriendRequest;
   import com.sulake.habbo.friendlist.events.FriendRequestEvent;
   import com.sulake.habbo.utils.class_2323;
   import package_28.class_2365;
   import package_28.class_3432;
   import package_9.class_1879;
   
   public class class_3396 implements ITabView, class_1747
   {
      
      private static const NO_REQS_INFO:String = "no_reqs_info";
      
      private var _friendList:HabboFriendList;
      
      private var var_121:IItemListWindow;
      
      private var var_3421:class_2143;
      
      private var var_3715:class_2143;
      
      public function class_3396()
      {
         super();
      }
      
      public function init(param1:HabboFriendList) : void
      {
         _friendList = param1;
      }
      
      public function getEntryCount() : int
      {
         return _friendList.friendRequests.getCountOfOpenRequests();
      }
      
      public function fillFooter(param1:class_1812) : void
      {
         var_3421 = class_2143(param1.findChildByName("accept_all_but"));
         var_3715 = class_2143(param1.findChildByName("reject_all_but"));
         var_3715.procedure = onDismissAllButtonClick;
         var_3421.procedure = onAcceptAllButtonClick;
         refreshButtons();
      }
      
      public function fillList(param1:IItemListWindow) : void
      {
         var_121 = param1;
         for each(var _loc2_ in _friendList.friendRequests.requests)
         {
            getRequestEntry(_loc2_);
            refreshRequestEntry(_loc2_);
            param1.addListItem(_loc2_.view);
         }
         _friendList.friendRequests.refreshShading();
      }
      
      public function tabClicked(param1:int) : void
      {
         if(var_121 == null)
         {
            return;
         }
         _friendList.friendRequests.clearAndUpdateView(true);
      }
      
      public function refreshShading(param1:FriendRequest, param2:Boolean) : void
      {
         if(var_121 == null)
         {
            return;
         }
         param1.view.color = _friendList.laf.getRowShadingColor(2,param2);
         setButtonBg(param1.view,"reject");
         setButtonBg(param1.view,"accept");
      }
      
      public function refreshRequestEntry(param1:FriendRequest) : void
      {
         if(var_121 == null)
         {
            return;
         }
         var _loc3_:class_1812 = param1.view;
         Util.hideChildren(_loc3_);
         var _loc2_:class_1741 = _loc3_.findChildByName("bg_region");
         _loc2_.visible = true;
         _loc2_.procedure = onEntry;
         _loc2_.id = param1.requesterUserId;
         _loc3_.findChildByName("user_info_region").visible = true;
         class_2323.setUserInfoState(false,_loc3_);
         _friendList.refreshText(_loc3_,"requester_name_text",true,param1.requesterName);
         if(param1.state == 1)
         {
            _friendList.refreshIcon(_loc3_,"accept",true,onAcceptButtonClick,param1.requestId);
            _friendList.refreshIcon(_loc3_,"reject",true,onDeclineButtonClick,param1.requestId);
         }
         else if(param1.state == 2)
         {
            _friendList.refreshText(_loc3_,"info_text",true,"${friendlist.request.accepted}");
         }
         else if(param1.state == 3)
         {
            _friendList.refreshText(_loc3_,"info_text",true,"${friendlist.request.declined}");
         }
         else if(param1.state == 4)
         {
            _friendList.refreshText(_loc3_,"info_text",true,"${friendlist.request.failed}");
         }
      }
      
      private function setButtonBg(param1:class_1812, param2:String) : void
      {
         var _loc3_:class_1741 = param1.findChildByName(param2);
         if(_loc3_ != null)
         {
            _loc3_.color = param1.color;
         }
      }
      
      public function addRequest(param1:FriendRequest) : void
      {
         if(var_121 == null)
         {
            return;
         }
         getRequestEntry(param1);
         refreshRequestEntry(param1);
         var_121.addListItem(param1.view);
         _friendList.friendRequests.refreshShading();
         refreshButtons();
      }
      
      public function removeRequest(param1:FriendRequest) : void
      {
         if(var_121 == null)
         {
            return;
         }
         var_121.removeListItem(param1.view);
         refreshButtons();
      }
      
      private function getRequestEntry(param1:FriendRequest) : void
      {
         var _loc2_:class_1812 = class_1812(_friendList.getXmlWindow("friend_request_entry"));
         param1.view = _loc2_;
      }
      
      private function onAcceptButtonClick(param1:class_1758, param2:class_1741) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.accept}");
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:int = param2.id;
         class_21.log("accept clicked: " + _loc3_);
         acceptRequest(_loc3_);
      }
      
      public function acceptRequest(param1:int) : void
      {
         var _loc3_:FriendRequest = _friendList.friendRequests.getRequest(param1);
         if(!_loc3_)
         {
            return;
         }
         _loc3_.state = 2;
         if(_friendList.categories.getFriendCount(false) >= _friendList.friendRequests.limit)
         {
            _friendList.showLimitReachedAlert();
            return;
         }
         var _loc2_:class_3432 = new class_3432();
         _loc2_.addAcceptedRequest(_loc3_.requestId);
         _friendList.send(_loc2_);
         refreshRequestEntry(_loc3_);
         refresh();
         if(_friendList && _friendList.events)
         {
            _friendList.events.dispatchEvent(new FriendRequestEvent("FRE_ACCEPTED",param1));
         }
      }
      
      public function acceptAllRequests() : void
      {
         if(_friendList.categories.getFriendCount(false) + _friendList.friendRequests.requests.length > _friendList.friendRequests.limit)
         {
            _friendList.showLimitReachedAlert();
            return;
         }
         var _loc1_:class_3432 = new class_3432();
         for each(var _loc2_ in _friendList.friendRequests.requests)
         {
            if(_loc2_.state != 2 && _loc2_.state != 3)
            {
               _loc1_.addAcceptedRequest(_loc2_.requestId);
               _loc2_.state = 2;
               refreshRequestEntry(_loc2_);
               if(_friendList && _friendList.events)
               {
                  _friendList.events.dispatchEvent(new FriendRequestEvent("FRE_ACCEPTED",_loc2_.requestId));
               }
            }
         }
         _friendList.send(_loc1_);
         refresh();
      }
      
      private function onDeclineButtonClick(param1:class_1758, param2:class_1741) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.decline}");
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:int = param2.id;
         class_21.log("decline clicked: " + _loc3_);
         declineRequest(_loc3_);
      }
      
      public function declineRequest(param1:int) : void
      {
         var _loc3_:FriendRequest = _friendList.friendRequests.getRequest(param1);
         if(!_loc3_)
         {
            return;
         }
         _loc3_.state = 3;
         var _loc2_:class_2365 = new class_2365();
         _loc2_.addDeclinedRequest(param1);
         _friendList.send(_loc2_);
         refreshRequestEntry(_loc3_);
         refresh();
         if(_friendList && _friendList.events)
         {
            _friendList.events.dispatchEvent(new FriendRequestEvent("FRE_DECLINED",param1));
         }
      }
      
      public function declineAllRequests() : void
      {
         var _loc1_:class_2365 = new class_2365();
         _friendList.send(_loc1_);
         for each(var _loc2_ in _friendList.friendRequests.requests)
         {
            if(_loc2_.state != 2 && _loc2_.state != 3)
            {
               _loc2_.state = 3;
               refreshRequestEntry(_loc2_);
               if(_friendList && _friendList.events)
               {
                  _friendList.events.dispatchEvent(new FriendRequestEvent("FRE_DECLINED",_loc2_.requestId));
               }
            }
         }
         refresh();
      }
      
      private function onEntry(param1:class_1758, param2:class_1741) : void
      {
         _friendList.view.showInfo(param1,"${infostand.profile.link.tooltip}");
         class_2323.onEntry(param1,param2);
         if(param1.type == "WME_CLICK")
         {
            _friendList.trackGoogle("extendedProfile","friendList_friendRequests");
            _friendList.send(new class_1879(param2.id));
         }
      }
      
      private function onDismissAllButtonClick(param1:class_1758, param2:class_1741) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.declineall}");
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         class_21.log("Dismiss all clicked");
         declineAllRequests();
      }
      
      private function onAcceptAllButtonClick(param1:class_1758, param2:class_1741) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.acceptall}");
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         class_21.log("Accept all clicked");
         acceptAllRequests();
      }
      
      private function refresh() : void
      {
         refreshButtons();
      }
      
      private function refreshButtons() : void
      {
         var _loc1_:* = _friendList.friendRequests.getCountOfOpenRequests() > 0;
         setEnabled(var_3421,_loc1_);
         setEnabled(var_3715,_loc1_);
      }
      
      private function setEnabled(param1:class_2143, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         if(param2)
         {
            param1.enable();
         }
         else
         {
            param1.disable();
         }
      }
   }
}

