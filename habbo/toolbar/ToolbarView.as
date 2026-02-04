package com.sulake.habbo.toolbar
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.motion.Motion;
   import com.sulake.core.window.utils.class_2201;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.memenu.MeMenuController;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ToolbarView implements ILinkEventTracker
   {
      
      private static const ICON_BG_COLOR_OVER:uint = 7433577;
      
      private static const ICON_BG_COLOR_OUT:uint = 5723213;
      
      private static const ICON_MOUSE_OVER:String = "_hover";
      
      private static const ICON_MOUSE_OUT:String = "_normal";
      
      private static const COUNTER_MARGIN:int = 5;
      
      private static const ME_MENU_ICON_NAME:String = "icon_me_menu";
      
      private static const ICON_REGION_HEIGHT:int = 80;
      
      private static const ICON_LABEL_HEIGHT:int = 20;
      
      private static const WINDOW_BOTTOM_PADDING:int = 52;
      
      private static const DEFAULT_LOCATION:Point = new Point(3,3);
      
      private static const LANDING_VIEW_LOCATION:Point = new Point(3,3);
      
      private var _window:class_1812;
      
      private var name_1:IEventDispatcher;
      
      private var _disposed:Boolean;
      
      private var _toolbar:HabboToolbar;
      
      private var _assets:class_40;
      
      private var _windowManager:class_38;
      
      private var _unseenItemCounters:class_55;
      
      private var var_394:class_1812;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var var_4628:Boolean;
      
      private var var_1435:BitmapData;
      
      private var var_1255:BitmapData;
      
      private var var_4515:int;
      
      private var var_4296:int;
      
      private var var_944:MeMenuController;
      
      public function ToolbarView(param1:HabboToolbar, param2:class_38, param3:class_40, param4:IEventDispatcher, param5:ISessionDataManager)
      {
         super();
         _toolbar = param1;
         _windowManager = param2;
         _assets = param3;
         name_1 = param4;
         _sessionDataManager = param5;
         var_944 = new MeMenuController(_toolbar,this);
         var_944.newUiEnabled = true;
         _unseenItemCounters = new class_55();
         var _loc13_:XmlAsset = param3.getAssetByName("toolbar_view_xml") as XmlAsset;
         _window = param2.buildFromXML(_loc13_.content as XML,2) as class_1812;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _window.position = DEFAULT_LOCATION;
         _window.addEventListener("WE_PARENT_RESIZED",onParentResized);
         var _loc9_:Array = [];
         _window.groupChildrenWithTag("TOGGLE",_loc9_,-1);
         for each(var _loc7_ in _loc9_)
         {
            if(_loc7_ && _loc7_ is IRegionWindow)
            {
               _loc7_.addEventListener("WME_CLICK",onIconClick);
               _loc7_.addEventListener("WME_OVER",onIconHoverMouseEvent);
               _loc7_.addEventListener("WME_OUT",onIconHoverMouseEvent);
            }
         }
         _loc9_ = [];
         _window.groupChildrenWithTag("ICON_BMP",_loc9_,-1);
         for each(var _loc11_ in _loc9_)
         {
            setIconHoverState(_loc11_,"_normal");
         }
         iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_PROGRESSION"),false);
         iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_MEMENU"),false);
         iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_INVENTORY"),true);
         var _loc12_:Boolean = param1.getBoolean("games_icon_enabled");
         if(_loc12_)
         {
            iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_GAMES"),true);
            iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_ACHIEVEMENTS"),false);
         }
         else
         {
            iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_GAMES"),false);
            iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_ACHIEVEMENTS"),true);
         }
         var _loc10_:XmlAsset = param3.getAssetByName("new_items_label_xml") as XmlAsset;
         var_394 = param2.buildFromXML(_loc10_.content as XML,2) as class_1812;
         if(var_394 == null)
         {
            throw new Error("Failed to construct toolbar label from XML!");
         }
         var _loc8_:class_1812 = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE")) as class_1812;
         _loc8_.addChild(var_394);
         var _loc14_:ITextWindow = var_394.findChildByName("new_textfield") as ITextWindow;
         var _loc6_:ILocalization = param1.localization.getLocalizationRaw("toolbar.new_additions.notification");
         if(_loc6_ != null)
         {
            _loc14_.text = _loc6_.value;
         }
         var_394.visible = false;
         var_394.x = _loc8_.width - var_394.width - 5;
         var_394.y = 5;
         var_4628 = isNewItemsNotificationEnabled();
         checkSize();
         (_toolbar as class_17).context.addLinkEventTracker(this);
      }
      
      private static function addShadow(param1:BitmapData, param2:Point, param3:uint) : BitmapData
      {
         var _loc4_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         _loc4_.fillRect(_loc4_.rect,param3);
         _loc4_.copyChannel(param1,param1.rect,new Point(0,0),8,8);
         var _loc5_:BitmapData = new BitmapData(param1.width + param2.x,param1.height + param2.y,true,0);
         _loc5_.copyPixels(_loc4_,_loc4_.rect,param2);
         _loc5_.copyPixels(param1,param1.rect,new Point(0,0),null,null,true);
         _loc4_.dispose();
         return _loc5_;
      }
      
      private function onPanicButton(param1:WindowMouseEvent) : void
      {
         _toolbar.toggleWindowVisibility("PANIC");
      }
      
      private function onParentResized(param1:class_1758) : void
      {
         checkSize();
      }
      
      private function checkSize() : void
      {
         if(!_window || !_windowManager)
         {
            return;
         }
         setLabelVisibility(true);
         if(shrinkListSpacing())
         {
            setLabelVisibility(false);
            shrinkListSpacing();
         }
         _window.invalidate();
         if(var_944 != null)
         {
            var_944.reposition();
         }
      }
      
      private function setLabelVisibility(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc2_:class_1812 = null;
         var _loc6_:class_1741 = null;
         var _loc5_:IItemListWindow = _window.findChildByName("toolbar_items") as IItemListWindow;
         var _loc3_:int = _loc5_.numListItems;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _loc5_.getListItemAt(_loc4_) as class_1812;
            if(_loc2_ != null)
            {
               _loc6_ = _loc2_.findChildByName("text");
               if(_loc6_ != null)
               {
                  _loc6_.visible = param1;
                  _loc2_.height = param1 ? 80 : 80 - 20;
               }
            }
            _loc4_++;
         }
      }
      
      private function shrinkListSpacing() : Boolean
      {
         var _loc1_:IItemListWindow = _window.findChildByName("toolbar_items") as IItemListWindow;
         _loc1_.spacing = 2;
         _loc1_.scrollV = 0;
         _loc1_.arrangeListItems();
         while(_window.bottom > _windowManager.getDesktop(2).height - 52)
         {
            if(_loc1_.spacing == -5)
            {
               return true;
            }
            _loc1_.spacing--;
         }
         return false;
      }
      
      public function dispose() : void
      {
         if(var_944 != null)
         {
            var_944.dispose();
            var_944 = null;
         }
         if(var_1435 != null)
         {
            var_1435.dispose();
            var_1435 = null;
         }
         if(var_1255 != null)
         {
            var_1255.dispose();
            var_1255 = null;
         }
         if(_unseenItemCounters != null)
         {
            _unseenItemCounters.dispose();
            _unseenItemCounters = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(var_394 != null)
         {
            var_394.dispose();
            var_394 = null;
         }
         if(_toolbar)
         {
            (_toolbar as class_17).context.removeLinkEventTracker(this);
         }
         _toolbar = null;
         _windowManager = null;
         _assets = null;
         _disposed = true;
         if(name_1)
         {
            name_1 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : class_1741
      {
         return _window;
      }
      
      private function disableCatalogIcon() : void
      {
         var _loc1_:class_1812 = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE")) as class_1812;
         _loc1_.blend = 0.5;
         _loc1_.disable();
      }
      
      public function onCatalogEvent(param1:CatalogEvent) : void
      {
         var _loc2_:class_1812 = null;
         var _loc3_:String = null;
         switch(param1.type)
         {
            case "CATALOG_INITIALIZED":
               _loc2_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE")) as class_1812;
               _loc2_.blend = 1;
               _loc2_.enable();
               _loc3_ = _toolbar.getProperty("open.catalog.page");
               if(_loc3_.length > 0 && _toolbar.catalog)
               {
                  _toolbar.catalog.openCatalogPage("hc_membership");
                  _toolbar.setProperty("open.catalog.page","");
               }
               break;
            case "CATALOG_NOT_READY":
               disableCatalogIcon();
               break;
            case "CATALOG_NEW_ITEMS_SHOW":
               if(var_394 != null && var_4628)
               {
                  var_394.visible = true;
               }
               break;
            case "CATALOG_NEW_ITEMS_HIDE":
               if(var_394 != null)
               {
                  var_394.visible = false;
               }
         }
      }
      
      public function setToolbarState(param1:String) : void
      {
         var _loc3_:String = null;
         if(param1 == "HTE_STATE_HIDDEN")
         {
            _window.visible = false;
            return;
         }
         _window.visible = true;
         var _loc4_:Array = [];
         _window.groupChildrenWithTag("TOGGLE",_loc4_,-1);
         switch(param1)
         {
            case "HTE_STATE_GAME_CENTER_VIEW":
               _loc3_ = "VISIBLE_GAME_CENTER";
               _window.position = DEFAULT_LOCATION;
               break;
            case "HTE_STATE_HOTEL_VIEW":
               _loc3_ = "VISIBLE_HOTEL";
               _window.position = LANDING_VIEW_LOCATION;
               break;
            case "HTE_STATE_ROOM_VIEW":
               _loc3_ = "VISIBLE_ROOM";
               _window.position = DEFAULT_LOCATION;
         }
         for each(var _loc2_ in _loc4_)
         {
            if(!_loc2_)
            {
               continue;
            }
            _loc2_.visible = _loc2_.tags.indexOf(_loc3_) >= 0;
            if(_loc2_.name == "QUESTS")
            {
               §§push(_loc2_);
               var _temp_1:* = _loc2_.visible;
               §§push(_temp_1);
               if(_temp_1)
               {
                  §§pop();
                  var _temp_2:* = !_toolbar.isNewIdentity();
                  while(true)
                  {
                  }
                  addr00fb:
                  if(_loc2_.name == "STORIES")
                  {
                     _loc2_.visible &&= _toolbar.getBoolean("toolbar.stories.enabled");
                  }
                  if(_loc2_.name == "BUILDER")
                  {
                     _loc2_.visible &&= _toolbar.getBoolean("builders.club.enabled");
                  }
                  §§push(!_toolbar.isNewIdentity() || !_toolbar.getBoolean("new.identity.hide.quests"));
                  continue;
               }
               §§pop().visible = §§pop();
               _loc2_.visible &&= !_toolbar.getBoolean("toolbar.hide.quests");
            }
            §§goto(addr00fb);
         }
         checkSize();
      }
      
      public function iconVisibility(param1:String, param2:Boolean) : void
      {
         var _loc3_:class_1812 = _window.findChildByName(param1) as class_1812;
         if(_loc3_)
         {
            _loc3_.visible = param2;
         }
         checkSize();
      }
      
      private function onNaviHover(param1:WindowMouseEvent) : void
      {
         var _loc2_:Rectangle = null;
         if(_toolbar.navigator == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "WME_OVER":
               _loc2_ = getIconLocation("HTIE_ICON_NAVIGATOR");
               _toolbar.navigator.showToolbarHover(new Point(_loc2_.right + 15,_loc2_.y));
               break;
            case "WME_OUT":
               _toolbar.navigator.hideToolbarHover(true);
         }
      }
      
      private function onIconHoverMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_1812 = param1.target as class_1812;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:class_1993 = _loc2_.findChildByTag("ICON_BORDER") as class_1993;
         var _loc4_:class_2201 = _loc2_.findChildByTag("ICON_BMP") as class_2201;
         class_21.log(param1);
         switch(param1.type)
         {
            case "WME_OVER":
               setIconHoverState(_loc4_,"_hover");
               setIconBgHoverState(_loc3_,"_hover");
               if(param1.target.name == "NAVIGATOR")
               {
                  onNaviHover(param1);
               }
               break;
            case "WME_OUT":
               setIconHoverState(_loc4_,"_normal");
               setIconBgHoverState(_loc3_,"_normal");
               if(param1.target.name == "NAVIGATOR")
               {
                  onNaviHover(param1);
               }
         }
      }
      
      private function setIconHoverState(param1:class_2201, param2:String) : void
      {
         var _loc3_:IStaticBitmapWrapperWindow = null;
         var _loc4_:class_2251 = null;
         if(param1 is IStaticBitmapWrapperWindow)
         {
            _loc3_ = param1 as IStaticBitmapWrapperWindow;
            _loc3_.assetUri = _loc3_.name + param2;
         }
         else if(param1 is class_2251)
         {
            _loc4_ = param1 as class_2251;
            if(_loc4_.name == "icon_me_menu")
            {
               _loc4_.bitmap = param2 == "_normal" ? var_1435 : var_1255;
            }
         }
      }
      
      private function setIconBgHoverState(param1:class_1812, param2:String) : void
      {
         if(!param1)
         {
            return;
         }
         if(param2 == "_hover")
         {
            param1.color = 7433577;
         }
         else
         {
            param1.color = 5723213;
         }
      }
      
      private function onIconClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:String = class_1741(param1.target).name;
         _toolbar.toggleWindowVisibility(_loc2_);
      }
      
      public function setIconBitmap(param1:String, param2:BitmapData) : void
      {
         var _loc3_:String = null;
         if(!param2)
         {
            return;
         }
         var _loc5_:String = param1;
         if("HTIE_ICON_MEMENU" === _loc5_)
         {
            _loc3_ = "icon_me_menu";
            setMeMenuIconBitmaps(param2);
         }
         var _loc4_:class_2201 = _window.findChildByName(_loc3_) as class_2201;
         if(_loc4_ != null)
         {
            setIconHoverState(_loc4_,"_normal");
         }
      }
      
      public function getIconLocation(param1:String) : Rectangle
      {
         var _loc3_:class_1741 = null;
         var _loc2_:Rectangle = null;
         switch(param1)
         {
            case "HTIE_ICON_NAVIGATOR":
               _loc3_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_NAVIGATOR"));
               break;
            case "HTIE_ICON_PROGRESSION":
               _loc3_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_PROGRESSION"));
               break;
            case "HTIE_ICON_GAMES":
               _loc3_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_GAMES"));
         }
         if(_loc3_ != null && _loc3_.visible)
         {
            _loc2_ = new Rectangle();
            _loc3_.getGlobalRectangle(_loc2_);
            return _loc2_;
         }
         return null;
      }
      
      private function setMeMenuIconBitmaps(param1:BitmapData) : void
      {
         if(var_1435 != null)
         {
            var_1435.dispose();
         }
         if(var_1255 != null)
         {
            var_1255.dispose();
         }
         var_1435 = addShadow(param1,new Point(2,3),4280426782);
         var_1255 = addShadow(param1,new Point(4,5),4281150249);
         param1.dispose();
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
      
      public function getUnseenItemCounter(param1:String) : class_1812
      {
         var _loc2_:class_1812 = null;
         var _loc4_:String = HabboToolbarIconEnum.getIconName(param1);
         if(!_loc4_)
         {
            class_21.log("[Toolbar] Unknown icon type for unseen item counter for iconId: " + param1);
         }
         var _loc3_:class_1812 = _unseenItemCounters.getValue(param1) as class_1812;
         if(!_loc3_)
         {
            _loc3_ = _windowManager.createUnseenItemCounter();
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
      
      public function isNewItemsNotificationEnabled() : Boolean
      {
         return _toolbar.getBoolean("toolbar.new_additions.notification.enabled");
      }
      
      public function animateToIcon(param1:String, param2:BitmapData, param3:int, param4:int) : Motion
      {
         var _loc16_:int = param2 ? param2.width : 20;
         var _loc19_:int = param2 ? param2.height : 20;
         var _loc18_:class_2251 = _windowManager.create("ToolBarTransition",21,0,0,new Rectangle(param3,param4,_loc16_,_loc19_)) as class_2251;
         if(param2)
         {
            _loc18_.bitmap = param2;
            _loc18_.disposesBitmap = true;
            _loc18_.filters = [new GlowFilter(16777215,1,2,2,255,1,false,false)];
         }
         _windowManager.getDesktop(2).addChild(_loc18_);
         var _loc7_:String = null;
         switch(param1)
         {
            case "HTIE_ICON_CATALOGUE":
               _loc7_ = "icons_toolbar_catalogue";
               break;
            case "HTIE_ICON_INVENTORY":
               _loc7_ = "icons_toolbar_inventory";
               break;
            case "HTIE_ICON_MEMENU":
               _loc7_ = "icons_toolbar_me_menu";
               break;
            case "HTIE_ICON_NAVIGATOR":
               _loc7_ = "icons_toolbar_navigator";
               break;
            case "HTIE_ICON_PROGRESSION":
               _loc7_ = "icons_toolbar_progression";
               break;
            case "HTIE_ICON_GAMES":
               _loc7_ = "icons_toolbar_games";
               break;
            case "HTIE_ICON_STORIES":
               _loc7_ = "icons_toolbar_stories";
               break;
            case "HTIE_ICON_RECEPTION":
               _loc7_ = "icons_toolbar_reception";
         }
         if(_loc7_ != null)
         {
            var _loc14_:class_1741 = _window.findChildByName(_loc7_);
         }
         _loc18_.dispose();
         return null;
      }
      
      public function set onDuty(param1:Boolean) : void
      {
         _window.findChildByName("guide_icon").visible = param1;
      }
      
      public function get unseenAchievementCount() : int
      {
         return var_4296;
      }
      
      public function set unseenAchievementCount(param1:int) : void
      {
         var_4296 = param1;
      }
      
      public function get unseenMiniMailMessageCount() : int
      {
         return var_4515;
      }
      
      public function set unseenMiniMailMessageCount(param1:int) : void
      {
         var_4515 = param1;
      }
      
      public function get memenu() : MeMenuController
      {
         return var_944;
      }
      
      public function get linkPattern() : String
      {
         return "toolbar/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         var _loc3_:* = _loc2_[1];
         if("memenu" !== _loc3_)
         {
            class_21.log("Toolbar unknown link-type received: " + _loc2_[1]);
         }
         else
         {
            memenu.toggleVisibility();
         }
      }
   }
}

