package com.sulake.habbo.toolbar.memenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.navigator.class_41;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.toolbar.ToolbarView;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   
   public class MeMenuController implements class_13
   {
      
      public static const USE_GUIDE_TOOL:String = "USE_GUIDE_TOOL";
      
      private var _toolbar:HabboToolbar;
      
      private var var_140:ToolbarView;
      
      private var _window:class_1812;
      
      private var var_2938:MeMenuIconLoader;
      
      private var var_4749:Boolean;
      
      private var var_482:MeMenuSettingsMenuView;
      
      private var _unseenItemCounters:class_55;
      
      public function MeMenuController(param1:HabboToolbar, param2:ToolbarView)
      {
         super();
         _unseenItemCounters = new class_55();
         _toolbar = param1;
         var_140 = param2;
         _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK",onToolbarClick);
         var _loc3_:XmlAsset = _toolbar.assets.getAssetByName("me_menu_view_xml") as XmlAsset;
         _window = _toolbar.windowManager.buildFromXML(_loc3_.content as XML,2) as class_1812;
         var_2938 = new MeMenuIconLoader(_toolbar);
         _window.visible = false;
         _window.procedure = windowProcedure;
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         var _loc5_:IRegionWindow = null;
         var _loc3_:IStaticBitmapWrapperWindow = null;
         var _loc4_:class_41 = null;
         var _loc6_:String = null;
         if(param2 is IRegionWindow)
         {
            _loc5_ = param2 as IRegionWindow;
            switch(param1.type)
            {
               case "WME_OVER":
                  _loc3_ = _loc5_.findChildByName(param2.name + "_icon") as IStaticBitmapWrapperWindow;
                  if(_loc3_ != null)
                  {
                     _loc3_.assetUri = "toolbar_memenu_" + param2.name + "_color";
                  }
                  break;
               case "WME_OUT":
                  _loc3_ = _loc5_.findChildByName(param2.name + "_icon") as IStaticBitmapWrapperWindow;
                  if(_loc3_ != null)
                  {
                     _loc3_.assetUri = "toolbar_memenu_" + param2.name + "_white";
                  }
                  break;
               case "WME_CLICK":
                  _window.visible = false;
                  switch(param2.name)
                  {
                     case "profile":
                        _toolbar.connection.send(new GetExtendedProfileMessageComposer(_toolbar.sessionDataManager.userId));
                        break;
                     case "minimail":
                        HabboWebTools.openMinimail("#mail/inbox/");
                        break;
                     case "rooms":
                        _loc4_ = _toolbar.navigator;
                        if(_loc4_ != null)
                        {
                           _loc4_.showOwnRooms();
                        }
                        break;
                     case "talents":
                        _loc6_ = _toolbar.sessionDataManager.currentTalentTrack;
                        _toolbar.connection.send(new GetTalentTrackMessageComposer(_loc6_));
                        break;
                     case "settings":
                        var_482 = new MeMenuSettingsMenuView();
                        var_482.init(this,var_140);
                        break;
                     case "achievements":
                        _toolbar.questEngine.showAchievements();
                        break;
                     case "guide":
                        _toolbar.toggleWindowVisibility("GUIDE");
                        break;
                     case "clothes":
                        _toolbar.context.createLinkEvent("avatareditor/open");
                  }
            }
         }
      }
      
      private function onToolbarClick(param1:HabboToolbarEvent) : void
      {
         if(var_4749)
         {
            return;
         }
         if(param1.iconId == "HTIE_ICON_MEMENU")
         {
            toggleVisibility();
         }
         else
         {
            _window.visible = false;
            if(var_482 != null)
            {
               var_482.dispose();
               var_482 = null;
            }
         }
      }
      
      private function setGuideToolVisibility(param1:Boolean) : void
      {
         _window.findChildByName("guide").visible = param1;
         _window.height = param1 ? _window.findChildByName("guide").bottom + 5 : _window.findChildByName("achievements").bottom + 5;
      }
      
      public function toggleVisibility() : void
      {
         var _loc1_:Boolean = false;
         if(var_482 != null)
         {
            var_482.dispose();
            var_482 = null;
         }
         _window.visible = !_window.visible;
         if(_window.visible)
         {
            if(!toolbar.getBoolean("talent.track.enabled"))
            {
               _window.findChildByName("guide").rectangle = _window.findChildByName("talents").rectangle;
               _window.findChildByName("talents").visible = false;
            }
            if(_toolbar.getBoolean("guides.enabled"))
            {
               _loc1_ = _toolbar.sessionDataManager.isPerkAllowed("USE_GUIDE_TOOL");
               setGuideToolVisibility(_loc1_);
            }
         }
         reposition();
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_482 != null)
         {
            var_482.dispose();
            var_482 = null;
         }
         var_2938.dispose();
         var_2938 = null;
         _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK",onToolbarClick);
         var_140 = null;
         _toolbar = null;
      }
      
      public function get disposed() : Boolean
      {
         return _toolbar == null;
      }
      
      public function get toolbar() : HabboToolbar
      {
         return _toolbar;
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      public function reposition() : void
      {
         _window.x = var_140.window.width + 10;
         _window.y = var_140.window.bottom - _window.height;
      }
      
      public function getUnseenItemCounter(param1:String) : class_1812
      {
         var _loc2_:class_1812 = null;
         var _loc4_:String = param1;
         if(!_loc4_)
         {
            class_21.log("[Toolbar] Unknown icon type for unseen item counter for iconId: " + param1);
         }
         var _loc3_:class_1812 = _unseenItemCounters.getValue(param1) as class_1812;
         if(!_loc3_)
         {
            _loc3_ = _toolbar.windowManager.createUnseenItemCounter();
            _loc2_ = _window.findChildByName(_loc4_) as class_1812;
            if(_loc2_)
            {
               _loc2_.addChild(_loc3_);
               _loc3_.x = _loc2_.width - _loc3_.width - 5;
               _loc3_.y = 5;
               _unseenItemCounters.add(param1,_loc3_);
            }
         }
         return _loc3_;
      }
      
      public function set achievementCount(param1:int) : void
      {
         setUnseenItemCount("achievements",param1);
      }
      
      public function set minimailCount(param1:int) : void
      {
         setUnseenItemCount("minimail",param1);
      }
      
      public function set newUiEnabled(param1:Boolean) : void
      {
         var_4749 = param1;
      }
      
      public function setUnseenItemCount(param1:String, param2:int) : void
      {
         var _loc3_:class_1812 = getUnseenItemCounter(param1);
         if(!_loc3_)
         {
            return;
         }
         if(param2 < 0)
         {
            _loc3_.visible = true;
            _loc3_.findChildByName("count").caption = " ";
         }
         else if(param2 > 0)
         {
            _loc3_.visible = true;
            _loc3_.findChildByName("count").caption = param2.toString();
         }
         else
         {
            _loc3_.visible = false;
         }
      }
   }
}

