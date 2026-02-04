package com.sulake.habbo.friendbar.view.tabs
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.components.class_2872;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.friendbar.data.FriendRequest;
   import flash.display.BitmapData;
   
   public class FriendRequestsTab extends Tab
   {
      
      protected static const REQUESTS_WINDOW_RESOURCE:String = "friend_requests_tab_xml";
      
      protected static const ICON:String = "icon";
      
      protected static const LABEL:String = "label";
      
      protected static const HEADER:String = "header";
      
      protected static const CANVAS:String = "canvas";
      
      protected static const BUBBLE:String = "bubble";
      
      protected static const REQUEST_LIST:String = "request_entity_list";
      
      protected static const NAME:String = "name";
      
      protected static const COUNTER:String = "badge_counter";
      
      protected static const REGION_PROFILE:String = "region_profile";
      
      protected static const REGION_PROFILE_NAME:String = "region_profile_name";
      
      protected static const const_344:String = "button_accept_all";
      
      protected static const const_540:String = "click_area_discard_all";
      
      protected static const const_598:String = "button_close";
      
      protected static const BUTTON_ACCEPT:String = "button_accept";
      
      protected static const const_431:String = "click_area_discard";
      
      protected static const const_1043:String = "text_discard";
      
      private static var var_3396:FriendRequestsTab;
      
      private static const DEFAULT_COLOR:uint = 4294625561;
      
      private static const const_145:uint = 4294957414;
      
      private static const const_634:uint = 4289431312;
      
      private static const const_1095:uint = 4290616362;
      
      private static const REGION_REJECT_COLOR_EXPOSED:uint = 16770666;
      
      private static const REGION_REJECT_COLOR_NORMAL:uint = 16777215;
      
      private var var_436:Array;
      
      private var var_3308:Boolean = false;
      
      private var _entity:class_1812;
      
      public function FriendRequestsTab()
      {
         super();
         _window = allocateRequestsTabWindow();
      }
      
      public static function allocate(param1:Array) : FriendRequestsTab
      {
         var _loc2_:FriendRequestsTab = var_3396 ? var_3396 : new FriendRequestsTab();
         _loc2_.var_123 = false;
         _loc2_.var_436 = param1;
         _loc2_._window.findChildByName("badge_counter").caption = String(param1.length);
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         if(_window)
         {
            releaseRequestsTabWindow(_window);
            _window = null;
         }
         if(_entity)
         {
            _entity.dispose();
            _entity = null;
         }
         super.dispose();
      }
      
      override public function recycle() : void
      {
         var _loc1_:class_2872 = null;
         var _loc2_:IItemListWindow = null;
         if(!disposed)
         {
            if(!var_123)
            {
               if(_window)
               {
                  _loc1_ = _window.findChildByName("bubble") as class_2872;
                  if(_loc1_)
                  {
                     _loc2_ = _loc1_.content.getChildByName("request_entity_list") as IItemListWindow;
                     if(_loc2_)
                     {
                        while(_loc2_.numListItems > 0)
                        {
                           _loc2_.removeListItemAt(0).dispose();
                        }
                     }
                  }
               }
               var_3308 = false;
               var_436 = null;
               var_123 = true;
               var_3396 = this;
            }
         }
      }
      
      override public function select(param1:Boolean) : void
      {
         var _loc3_:class_2872 = null;
         var _loc7_:IItemListWindow = null;
         var _loc8_:class_1812 = null;
         var _loc2_:FriendRequest = null;
         var _loc5_:class_2251 = null;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:BitmapData = null;
         if(!selected)
         {
            if(_window)
            {
               _loc3_ = _window.findChildByName("bubble") as class_2872;
               if(_loc3_)
               {
                  _loc3_.visible = true;
                  if(!var_3308)
                  {
                     _loc7_ = _loc3_.content.getChildByName("request_entity_list") as IItemListWindow;
                     if(_loc7_)
                     {
                        _loc9_ = 0;
                        _loc6_ = 0;
                        while(_loc6_ < var_436.length)
                        {
                           _loc8_ = _entity.clone() as class_1812;
                           _loc8_.color = _loc6_ % 2 == 0 ? 4289431312 : 4290616362;
                           _loc2_ = var_436[_loc6_];
                           _loc8_.id = _loc2_.id;
                           _loc8_.findChildByName("name").caption = _loc2_.name;
                           _loc5_ = _loc8_.findChildByName("canvas") as class_2251;
                           _loc4_ = VIEW.getAvatarFaceBitmap(_loc2_.figure);
                           if(_loc4_)
                           {
                              _loc5_.disposesBitmap = false;
                              _loc5_.bitmap = _loc4_;
                              _loc5_.width = _loc4_.width;
                              _loc5_.height = _loc4_.height;
                              _loc5_.disposesBitmap = true;
                           }
                           _loc7_.addListItem(_loc8_);
                           _loc9_ += _loc8_.height + _loc7_.spacing;
                           _loc6_++;
                        }
                        _loc7_.height = _loc9_;
                     }
                  }
                  var_3308 = true;
               }
            }
            super.select(param1);
         }
      }
      
      override public function deselect(param1:Boolean) : void
      {
         var _loc2_:class_1741 = null;
         if(selected)
         {
            if(_window)
            {
               _loc2_ = _window.findChildByName("bubble");
               if(_loc2_)
               {
                  _loc2_.visible = false;
               }
            }
            super.deselect(param1);
         }
      }
      
      override protected function expose() : void
      {
         super.expose();
         _window.color = exposed ? 4294957414 : 4294625561;
         ITextWindow(_window.findChildByTag("label")).underline = exposed;
      }
      
      override protected function conceal() : void
      {
         super.conceal();
         _window.color = exposed ? 4294957414 : 4294625561;
         ITextWindow(_window.findChildByTag("label")).underline = exposed;
      }
      
      private function allocateRequestsTabWindow() : class_1812
      {
         var _loc8_:BitmapDataAsset = null;
         var _loc1_:class_1812 = WINDOWING.buildFromXML(ASSETS.getAssetByName("friend_requests_tab_xml").content as XML) as class_1812;
         var _loc7_:class_2251 = class_2251(_loc1_.findChildByName("canvas"));
         var _loc6_:IRegionWindow = IRegionWindow(_loc1_.findChildByName("header"));
         var _loc5_:IRegionWindow = IRegionWindow(_loc1_.findChildByName("region_profile"));
         var _loc2_:IRegionWindow = IRegionWindow(_loc1_.findChildByName("region_profile_name"));
         var _loc4_:class_2872 = _loc1_.findChildByName("bubble") as class_2872;
         _loc1_.x = 0;
         _loc1_.y = 0;
         _loc1_.width = WIDTH;
         _loc1_.height = HEIGHT;
         _loc1_.addEventListener("WME_CLICK",onMouseClick);
         _loc1_.addEventListener("WME_OVER",onMouseOver);
         _loc1_.addEventListener("WME_OUT",onMouseOut);
         _loc6_.addEventListener("WME_CLICK",onMouseClick);
         _loc6_.addEventListener("WME_OVER",onMouseOver);
         _loc6_.addEventListener("WME_OUT",onMouseOut);
         _loc5_.toolTipCaption = var_439.getLocalization("infostand.profile.link.tooltip","");
         _loc5_.toolTipDelay = 100;
         _loc2_.toolTipCaption = var_439.getLocalization("infostand.profile.link.tooltip","");
         _loc2_.toolTipDelay = 100;
         _loc7_.disposesBitmap = true;
         _loc4_.visible = false;
         _loc4_.y = -(_loc4_.height - (_loc4_.height - _loc4_.margins.bottom)) - 1;
         _loc4_.procedure = bubbleEventProc;
         _loc8_ = ASSETS.getAssetByName("add_friends_icon_png") as BitmapDataAsset;
         var _loc3_:class_2251 = _loc1_.findChildByName("icon") as class_2251;
         _loc3_.disposesBitmap = false;
         _loc3_.bitmap = _loc8_.content as BitmapData;
         var _loc9_:IItemListWindow = _loc4_.content.getChildByName("request_entity_list") as IItemListWindow;
         _entity = _loc9_.removeListItemAt(0) as class_1812;
         return _loc1_;
      }
      
      private function releaseRequestsTabWindow(param1:class_1812) : void
      {
         var _loc2_:IRegionWindow = null;
         var _loc3_:class_2251 = null;
         if(param1 && !param1.disposed)
         {
            param1.procedure = null;
            param1.removeEventListener("WME_CLICK",onMouseClick);
            param1.removeEventListener("WME_OVER",onMouseOver);
            param1.removeEventListener("WME_OUT",onMouseOut);
            _loc2_ = IRegionWindow(param1.findChildByName("header"));
            _loc2_.removeEventListener("WME_CLICK",onMouseClick);
            _loc2_.removeEventListener("WME_OVER",onMouseOver);
            _loc2_.removeEventListener("WME_OUT",onMouseOut);
            param1.width = WIDTH;
            param1.height = HEIGHT;
            param1.color = 4294625561;
            _loc3_ = class_2251(param1.findChildByName("canvas"));
            if(_loc3_)
            {
               _loc3_.bitmap = null;
            }
            ITextWindow(param1.findChildByTag("label")).underline = false;
         }
      }
      
      private function bubbleEventProc(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "button_close":
                  if(selected)
                  {
                     VIEW.deSelect(true);
                  }
                  break;
               case "button_accept_all":
                  DATA.acceptAllFriendRequests();
                  break;
               case "click_area_discard_all":
                  DATA.declineAllFriendRequests();
                  break;
               case "button_accept":
                  DATA.acceptFriendRequest(param2.parent.id);
                  break;
               case "click_area_discard":
                  DATA.declineFriendRequest(param2.parent.id);
                  break;
               case "region_profile":
                  TRACKING.trackGoogle("extendedProfile","friendBar_multipleFriendRequestsAvatar");
                  DATA.showProfile(param2.parent.id);
                  break;
               case "region_profile_name":
                  TRACKING.trackGoogle("extendedProfile","friendBar_multipleFriendRequestsName");
                  DATA.showProfile(param2.parent.id);
            }
         }
         else if(param1.type == "WME_OVER")
         {
            if(param2.name == "click_area_discard")
            {
               ITextWindow(class_1812(param2).getChildByName("text_discard")).textColor = 16770666;
            }
            if(param2.name == "region_profile_name")
            {
               ITextWindow(class_1812(param2).getChildByName("name")).underline = true;
            }
         }
         else if(param1.type == "WME_OUT")
         {
            if(param2.name == "click_area_discard")
            {
               ITextWindow(class_1812(param2).getChildByName("text_discard")).textColor = 16777215;
            }
            if(param2.name == "region_profile_name")
            {
               ITextWindow(class_1812(param2).getChildByName("name")).underline = false;
            }
         }
      }
      
      public function avatarImageReady(param1:FriendRequest, param2:BitmapData) : void
      {
         var _loc6_:IItemListWindow = null;
         var _loc7_:class_1812 = null;
         var _loc5_:int = 0;
         var _loc3_:class_2251 = null;
         if(disposed)
         {
            return;
         }
         var _loc4_:class_2872 = _window.findChildByName("bubble") as class_2872;
         if(_loc4_)
         {
            _loc6_ = _loc4_.content.getChildByName("request_entity_list") as IItemListWindow;
            if(_loc6_)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc6_.numListItems)
               {
                  _loc7_ = _loc6_.getListItemAt(_loc5_) as class_1812;
                  if(_loc7_.id == param1.id)
                  {
                     _loc3_ = _loc7_.findChildByName("canvas") as class_2251;
                     _loc3_.disposesBitmap = true;
                     _loc3_.bitmap = param2;
                     _loc3_.width = param2.width;
                     _loc3_.height = param2.height;
                     return;
                  }
                  _loc5_++;
               }
            }
         }
      }
   }
}

