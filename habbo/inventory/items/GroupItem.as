package com.sulake.habbo.inventory.items
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   import com.sulake.habbo.window.widgets.ILimitedItemGridOverlayWidget;
   import com.sulake.habbo.window.widgets.IRarityItemGridOverlayWidget;
   import flash.display.BitmapData;
   
   public class GroupItem implements class_1829
   {
      
      private static const THUMB_WINDOW_LAYOUT:String = "inventory_thumb_xml";
      
      private static const THUMB_COLOR_NORMAL:int = 13421772;
      
      private static const THUMB_COLOR_UNSEEN:int = 10275685;
      
      public static const THUMB_BLEND_ITEMS_AVAILABLE:Number = 1;
      
      public static const THUMB_BLEND_ITEMS_NOT_AVAILABLE:Number = 0.2;
      
      protected var _items:class_55;
      
      protected var _window:class_1812;
      
      protected var var_36:FurniModel;
      
      private var var_230:int;
      
      private var _roomEngine:IRoomEngine;
      
      private var var_1613:Boolean;
      
      private var _selected:Boolean;
      
      private var var_191:int;
      
      private var var_1966:IStuffData;
      
      private var var_3221:Number;
      
      private var var_992:int = 0;
      
      private var var_952:BitmapData;
      
      private var var_2911:int;
      
      private var var_1558:Boolean;
      
      private var var_2435:Boolean;
      
      private var var_4274:Boolean;
      
      private var _icon:BitmapData;
      
      private var var_978:class_1741;
      
      private var _hasUnseenItems:Boolean;
      
      private var var_1031:Boolean;
      
      private var var_2733:String = "center";
      
      private var var_265:Boolean = false;
      
      private var _name:String = "";
      
      private var var_735:String = "";
      
      private var var_2069:int = -1;
      
      private var var_1395:int = -1;
      
      public function GroupItem(param1:FurniModel, param2:int, param3:int, param4:IRoomEngine, param5:Boolean, param6:IStuffData, param7:Number, param8:BitmapData, param9:Boolean, param10:String)
      {
         super();
         var_36 = param1;
         var_230 = param2;
         _roomEngine = param4;
         var_2435 = param5;
         _items = new class_55();
         var_191 = param3;
         var_1966 = param6;
         var_3221 = param7;
         var_2733 = param10;
         _icon = param8;
         var_4274 = param9;
         switch(var_191 - 2)
         {
            case 0:
               _name = var_36.controller.localization.getLocalization("inventory.furni.item.wallpaper.name");
               var_735 = var_36.controller.localization.getLocalization("inventory.furni.item.wallpaper.desc");
               break;
            case 1:
               _name = var_36.controller.localization.getLocalization("inventory.furni.item.floor.name");
               var_735 = var_36.controller.localization.getLocalization("inventory.furni.item.floor.desc");
               break;
            case 2:
               _name = var_36.controller.localization.getLocalization("inventory.furni.item.landscape.name");
               var_735 = var_36.controller.localization.getLocalization("inventory.furni.item.landscape.desc");
         }
         var_36.soundManager.events.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
      }
      
      public function get isImageInited() : Boolean
      {
         return var_265 && var_1558;
      }
      
      public function get isImageFinished() : Boolean
      {
         return var_992 == -1;
      }
      
      public function get window() : class_1812
      {
         if(!var_265)
         {
            initWindow();
         }
         if(_window == null)
         {
            return null;
         }
         if(_window.disposed)
         {
            return null;
         }
         return _window;
      }
      
      public function get isLocked() : Boolean
      {
         return var_1613;
      }
      
      public function set isLocked(param1:Boolean) : void
      {
         var_1613 = param1;
      }
      
      public function get isSelected() : Boolean
      {
         return _selected;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         if(_selected != param1)
         {
            _selected = param1;
            updateSelectionVisual();
         }
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get iconImage() : BitmapData
      {
         return var_952;
      }
      
      public function set iconImage(param1:BitmapData) : void
      {
         var_952 = param1;
      }
      
      public function get iconCallbackId() : int
      {
         return var_992;
      }
      
      public function set iconCallbackId(param1:int) : void
      {
         var_992 = param1;
      }
      
      public function get previewCallbackId() : int
      {
         return var_2911;
      }
      
      public function set previewCallbackId(param1:int) : void
      {
         var_2911 = param1;
      }
      
      public function get category() : int
      {
         return var_191;
      }
      
      public function get stuffData() : IStuffData
      {
         return var_1966;
      }
      
      public function get extra() : Number
      {
         return var_3221;
      }
      
      public function set showRecyclable(param1:Boolean) : void
      {
         if(var_2435 != param1)
         {
            var_2435 = param1;
            updateRecycleStatusVisual();
         }
      }
      
      public function get hasUnseenItems() : Boolean
      {
         return _hasUnseenItems;
      }
      
      public function set hasUnseenItems(param1:Boolean) : void
      {
         if(_hasUnseenItems != param1)
         {
            _hasUnseenItems = param1;
            updateBackgroundVisual();
         }
      }
      
      public function get alignment() : String
      {
         return var_2733;
      }
      
      public function get isWallItem() : Boolean
      {
         var _loc1_:FurnitureItem = getAt(0);
         return _loc1_ ? _loc1_.isWallItem : false;
      }
      
      public function get flatId() : int
      {
         var _loc1_:FurnitureItem = getAt(0);
         return _loc1_ ? _loc1_.flatId : -1;
      }
      
      public function get isGroupable() : Boolean
      {
         var _loc1_:FurnitureItem = getAt(0);
         return _loc1_ ? _loc1_.groupable : true;
      }
      
      public function get isRented() : Boolean
      {
         var _loc1_:FurnitureItem = getAt(0);
         return _loc1_ ? _loc1_.isRented : false;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get description() : String
      {
         return var_735;
      }
      
      public function dispose() : void
      {
         if(var_36.soundManager)
         {
            if(var_36.soundManager.events != null)
            {
               var_36.soundManager.events.removeEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
            }
         }
         var_36 = null;
         var_978 = null;
         _roomEngine = null;
         if(_items)
         {
            _items.dispose();
            _items = null;
         }
         var_1966 = null;
         if(_window)
         {
            _window.dispose();
         }
      }
      
      public function removeIntervalProcedure() : void
      {
         if(_window)
         {
            _window.procedure = null;
         }
      }
      
      public function initImage(param1:Boolean = true) : Boolean
      {
         var _loc2_:class_2198 = null;
         if(var_952 != null)
         {
            return false;
         }
         if(var_1558)
         {
            return false;
         }
         if(isWallItem)
         {
            _loc2_ = _roomEngine.getWallItemIcon(var_230,this,var_1966.getLegacyString());
         }
         else
         {
            _loc2_ = _roomEngine.getFurnitureIcon(var_230,this,String(var_3221),var_1966);
         }
         if(_loc2_.id > 0)
         {
            if(param1)
            {
               setLoadingImage(_loc2_.data);
            }
            var_992 = _loc2_.id;
         }
         else
         {
            setFinalImage(_loc2_.data);
            var_992 = -1;
         }
         var_1558 = true;
         return _loc2_.id > 0;
      }
      
      public function push(param1:FurnitureItem, param2:Boolean = false) : void
      {
         var _loc3_:FurnitureItem = _items.getValue(param1.id);
         if(_loc3_ == null)
         {
            _items.add(param1.id,param1);
         }
         else
         {
            _loc3_.locked = false;
         }
         updateItemCountVisual();
         updateSelectionVisual();
         updateRentStateVisual();
         if(_name == null || _name.length == 0)
         {
            _name = getFurniItemName();
         }
         if(var_735 == null || var_735.length == 0)
         {
            var_735 = getFurniItemDesc();
         }
         if(param2 != _hasUnseenItems)
         {
            _hasUnseenItems = param2;
            updateBackgroundVisual();
         }
      }
      
      public function unshift(param1:FurnitureItem) : void
      {
         var _loc2_:FurnitureItem = _items.getValue(param1.id);
         if(_loc2_ == null)
         {
            _items.unshift(param1.id,param1);
         }
         else
         {
            _loc2_.locked = false;
         }
         updateAllThumbDataVisuals();
      }
      
      public function pop() : FurnitureItem
      {
         var _loc1_:FurnitureItem = null;
         if(_items.length > 0)
         {
            _loc1_ = _items.getWithIndex(_items.length - 1) as FurnitureItem;
            _items.remove(_loc1_.id);
         }
         updateAllThumbDataVisuals();
         return _loc1_;
      }
      
      public function peek() : FurnitureItem
      {
         var _loc1_:FurnitureItem = null;
         if(_items.length > 0)
         {
            _loc1_ = _items.getWithIndex(_items.length - 1) as FurnitureItem;
            updateAllThumbDataVisuals();
         }
         return _loc1_;
      }
      
      public function getAt(param1:int) : FurnitureItem
      {
         return _items.getWithIndex(param1);
      }
      
      public function getItemsForTrade(param1:int) : Vector.<class_1875>
      {
         var _loc5_:int = 0;
         var _loc3_:Vector.<class_1875> = new Vector.<class_1875>();
         var _loc6_:class_1875 = getOneForTrade();
         if(_loc6_ == null)
         {
            return _loc3_;
         }
         _loc5_ = 0;
         while(_loc5_ < _items.length)
         {
            if(0 >= param1)
            {
               break;
            }
            var _loc2_:FurnitureItem = _items.getWithIndex(_loc5_);
            if(!null.locked && Boolean(null.tradeable) && null.type == _loc6_.type)
            {
               _loc4_++;
               _loc3_.push(null);
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function getOneForTrade() : FurnitureItem
      {
         var _loc2_:FurnitureItem = null;
         var _loc3_:int = 0;
         var _loc1_:FurnitureItem = null;
         if(var_1395 >= 0 && var_1395 < _items.length)
         {
            _loc2_ = _items.getWithIndex(var_1395);
            if(!_loc2_.locked && _loc2_.tradeable)
            {
               return _loc2_;
            }
         }
         _loc3_ = 0;
         while(_loc3_ < _items.length)
         {
            _loc1_ = _items.getWithIndex(_loc3_);
            if(!_loc1_.locked && _loc1_.tradeable)
            {
               return _loc1_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getOneForRecycle() : FurnitureItem
      {
         var _loc2_:int = 0;
         var _loc1_:FurnitureItem = null;
         _loc2_ = 0;
         while(_loc2_ < _items.length)
         {
            _loc1_ = _items.getWithIndex(_loc2_);
            if(!_loc1_.locked && _loc1_.recyclable)
            {
               addLockTo(_loc1_.id);
               return _loc1_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getOneForSelling() : FurnitureItem
      {
         var _loc2_:int = 0;
         var _loc1_:FurnitureItem = null;
         _loc2_ = 0;
         while(_loc2_ < _items.length)
         {
            _loc1_ = _items.getWithIndex(_loc2_);
            if(!_loc1_.locked && _loc1_.sellable)
            {
               return _loc1_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getFurniIds() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_ in _items)
         {
            _loc2_.push(_loc1_.id);
         }
         return _loc2_;
      }
      
      public function getNonRentedFurnitureIds() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_ in _items)
         {
            if(!_loc1_.isRented)
            {
               _loc2_.push(_loc1_.id);
            }
         }
         return _loc2_;
      }
      
      public function addLockTo(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:FurnitureItem = null;
         _loc3_ = 0;
         while(_loc3_ < _items.length)
         {
            _loc2_ = _items.getWithIndex(_loc3_);
            if(_loc2_.id == param1)
            {
               _loc2_.locked = true;
               updateItemCountVisual();
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function updateLocks(param1:Array) : void
      {
         var _loc2_:FurnitureItem = null;
         var _loc4_:* = false;
         var _loc3_:int = _items.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = _items.getWithIndex(_loc3_);
            _loc4_ = param1.indexOf(_loc2_.ref) >= 0;
            if(_loc2_.locked != _loc4_)
            {
               _loc2_.locked = _loc4_;
               var _loc5_:Boolean = true;
            }
            _loc3_--;
         }
      }
      
      public function removeLockFrom(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:FurnitureItem = null;
         _loc3_ = 0;
         while(_loc3_ < _items.length)
         {
            _loc2_ = _items.getWithIndex(_loc3_);
            if(_loc2_.id == param1)
            {
               _loc2_.locked = false;
               updateItemCountVisual();
               updateRecycleStatusVisual();
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function removeAllLocks() : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:int = 0;
         var _loc1_:FurnitureItem = null;
         _loc2_ = _items.length - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = _items.getWithIndex(_loc2_);
            if(_loc1_.locked)
            {
               _loc1_.locked = false;
               _loc3_ = true;
            }
            _loc2_--;
         }
         if(_loc3_)
         {
            updateItemCountVisual();
         }
      }
      
      public function getTotalCount() : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:FurnitureItem = null;
         if(category == 5)
         {
            _loc2_ = 0;
            _loc3_ = 0;
            while(_loc3_ < _items.length)
            {
               _loc1_ = _items.getWithIndex(_loc3_) as FurnitureItem;
               _loc2_ += int(_loc1_.stuffData.getLegacyString());
               _loc3_++;
            }
            return _loc2_;
         }
         return _items.length;
      }
      
      public function getRecyclableCount() : int
      {
         var _loc3_:int = 0;
         var _loc1_:FurnitureItem = null;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _items.length)
         {
            _loc1_ = _items.getWithIndex(_loc3_) as FurnitureItem;
            if(_loc1_.recyclable && !_loc1_.locked)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getTradeableCount() : int
      {
         var _loc3_:int = 0;
         var _loc1_:FurnitureItem = null;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _items.length)
         {
            _loc1_ = _items.getWithIndex(_loc3_) as FurnitureItem;
            if(_loc1_.tradeable && !_loc1_.locked)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function remove(param1:int) : FurnitureItem
      {
         var _loc2_:FurnitureItem = _items.getValue(param1);
         if(_loc2_)
         {
            _items.remove(param1);
            updateAllThumbDataVisuals();
            return _loc2_;
         }
         return null;
      }
      
      public function getItem(param1:int) : FurnitureItem
      {
         return _items.getValue(param1);
      }
      
      public function replaceItem(param1:int, param2:FurnitureItem) : void
      {
         _items.add(param1,param2);
         updateAllThumbDataVisuals();
      }
      
      public function getMinimumItemsToShowCounter() : int
      {
         return 2;
      }
      
      public function getUnlockedCount() : int
      {
         var _loc1_:FurnitureItem = null;
         var _loc3_:int = 0;
         if(category == 5)
         {
            return getTotalCount();
         }
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _items.length)
         {
            _loc1_ = _items.getWithIndex(_loc3_);
            if(!_loc1_.locked)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function updateAllThumbDataVisuals() : void
      {
         if(_window == null)
         {
            return;
         }
         if(_window.disposed)
         {
            return;
         }
         updateItemImageVisual();
         updateBackgroundVisual();
         updateItemCountVisual();
         updateRecycleStatusVisual();
         updateSelectionVisual();
         updateRentStateVisual();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(_window == null)
         {
            return;
         }
         if(_window.disposed)
         {
            return;
         }
         if(var_992 != param1)
         {
            return;
         }
         var_952 = param2;
         updateItemImageVisual();
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function setFinalImage(param1:BitmapData) : void
      {
         var_952 = param1;
         var_1558 = true;
         var_992 = -1;
         updateItemImageVisual();
      }
      
      private function setLoadingImage(param1:BitmapData) : void
      {
         var_952 = param1;
         var_1558 = true;
         updateItemImageVisual();
      }
      
      private function updateRentStateVisual() : void
      {
         if(_window == null || Boolean(_window.disposed))
         {
            return;
         }
         var _loc2_:FurnitureItem = getAt(0);
         var _loc1_:IStaticBitmapWrapperWindow = _window.findChildByName("rent_state") as IStaticBitmapWrapperWindow;
         if(!_loc2_ || !isRented)
         {
            _loc1_.visible = false;
            return;
         }
         _loc1_.visible = isRented;
         var _loc3_:int = var_36.controller.getInteger("purchase.rent.warning_duration_seconds",172800);
         _loc1_.assetUri = !_loc2_.hasRentPeriodStarted ? "inventory_thumb_rent_not_started" : (_loc2_.secondsToExpiration < _loc3_ ? "inventory_thumb_rent_ending" : "inventory_thumb_rent_started");
      }
      
      private function updateItemCountVisual() : void
      {
         var _loc4_:ITextWindow = null;
         if(!_window)
         {
            return;
         }
         var _loc5_:int = getUnlockedCount();
         var _loc1_:* = _loc5_ >= getMinimumItemsToShowCounter();
         var _loc3_:class_1741 = _window.findChildByName("number_container");
         _loc3_.visible = _loc1_;
         if(_loc1_)
         {
            _loc4_ = _window.findChildByName("number") as ITextWindow;
            _loc4_.text = String(_loc5_);
         }
         var _loc2_:class_2251 = _window.findChildByName("bitmap") as class_2251;
         if(_loc5_ <= 0)
         {
            _loc2_.blend = 0.2;
         }
         else
         {
            _loc2_.blend = 1;
         }
      }
      
      private function updateBackgroundVisual() : void
      {
         if(!_window)
         {
            return;
         }
         if(!var_978)
         {
            var_978 = _window.findChildByTag("BG_COLOR");
         }
         var_978.color = _hasUnseenItems ? 10275685 : 13421772;
      }
      
      private function updateSelectionVisual() : void
      {
         if(!_window)
         {
            return;
         }
         _window.findChildByName("outline").visible = isSelected;
      }
      
      private function updateRecycleStatusVisual() : void
      {
         if(!_window)
         {
            return;
         }
         var _loc1_:class_1741 = _window.findChildByName("recyclable_container");
         if(_loc1_)
         {
            _loc1_.visible = var_2435 && getRecyclableCount() > 0;
         }
      }
      
      private function updateItemImageVisual() : void
      {
         var _loc2_:ILimitedItemGridOverlayWidget = null;
         var _loc4_:class_2010 = null;
         var _loc5_:class_2010 = null;
         var _loc1_:IRarityItemGridOverlayWidget = null;
         if(!_window)
         {
            return;
         }
         if(stuffData.uniqueSerialNumber > 0)
         {
            _loc4_ = class_2010(_window.findChildByName("unique_item_overlay_container"));
            _loc2_ = ILimitedItemGridOverlayWidget(_loc4_.widget);
            _loc4_.visible = true;
            _loc2_.serialNumber = stuffData.uniqueSerialNumber;
            _loc2_.animated = true;
            _window.findChildByName("unique_item_background_bitmap").visible = true;
         }
         else if(stuffData.rarityLevel >= 0)
         {
            _loc5_ = class_2010(_window.findChildByName("rarity_item_overlay_container"));
            _loc1_ = IRarityItemGridOverlayWidget(_loc5_.widget);
            _loc1_.rarityLevel = stuffData.rarityLevel;
            _loc5_.visible = true;
         }
         var _loc3_:class_2251 = _window.findChildByName("bitmap") as class_2251;
         if(_loc3_)
         {
            _loc3_.bitmap = var_952;
         }
      }
      
      private function itemEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:Boolean = false;
         switch(param1.type)
         {
            case "WME_UP":
               var_1031 = false;
               var_36.cancelFurniInMover();
               break;
            case "WME_DOWN":
               var_36.removeSelections();
               isSelected = true;
               var_1031 = true;
               var_36.updateActionView();
               var_36.categorySelection = this;
               break;
            case "WME_OUT":
               if(!var_1031 || var_36.isTradingOpen)
               {
                  return;
               }
               _loc3_ = var_36.requestSelectedFurniPlacement(true);
               if(_loc3_)
               {
                  var_1031 = false;
               }
               break;
            case "WME_CLICK":
               var_1031 = false;
               break;
            case "WME_DOUBLE_CLICK":
               var_36.requestCurrentActionOnSelection();
               var_1031 = false;
         }
      }
      
      private function initWindow() : void
      {
         createWindow();
         if(_icon != null)
         {
            setFinalImage(_icon);
         }
         else if(!var_4274)
         {
            initImage();
         }
         _window.procedure = itemEventProc;
         _window.name = _roomEngine.getFurnitureType(type) + "." + category;
         if(stuffData && stuffData.getLegacyString() != "")
         {
            _window.name += ".s" + stuffData;
         }
         if(!isNaN(extra))
         {
            _window.name += ".e" + extra;
         }
         updateBackgroundVisual();
         updateItemCountVisual();
         updateItemImageVisual();
         updateRecycleStatusVisual();
         updateSelectionVisual();
         updateRentStateVisual();
         var_265 = true;
      }
      
      protected function createWindow() : void
      {
         _window = var_36.createItemWindow("inventory_thumb_xml");
      }
      
      private function getFurniItemName() : String
      {
         var _loc2_:String = null;
         var _loc1_:FurnitureItem = peek();
         if(_loc1_ == null)
         {
            return "";
         }
         switch(var_191 - 6)
         {
            case 0:
               _loc2_ = "poster_" + _loc1_.stuffData.getLegacyString() + "_name";
               break;
            case 2:
               var _loc3_:ISongInfo = var_36.soundManager.musicController.getSongInfo(_loc1_.extra);
               getSongInfo(_loc1_);
               return "";
            default:
               if(isWallItem)
               {
                  _loc2_ = "wallItem.name." + _loc1_.type;
                  break;
               }
               _loc2_ = "roomItem.name." + _loc1_.type;
         }
         return var_36.controller.localization.getLocalization(_loc2_);
      }
      
      public function isNft() : Boolean
      {
         var _loc1_:FurnitureItem = peek();
         if(_loc1_ == null)
         {
            return "";
         }
         var _loc3_:String = isWallItem ? "i" : "s";
         var _loc2_:class_1800 = var_36.controller.getFurnitureData(_loc1_.type,_loc3_);
         if(_loc2_ == null)
         {
            return false;
         }
         return _loc2_.className.indexOf("nft_") == 0;
      }
      
      private function getFurniItemDesc() : String
      {
         var _loc2_:String = null;
         var _loc1_:FurnitureItem = peek();
         if(_loc1_ == null)
         {
            return "";
         }
         switch(var_191 - 6)
         {
            case 0:
               _loc2_ = "poster_" + _loc1_.stuffData.getLegacyString() + "_desc";
               break;
            case 2:
               var _loc3_:ISongInfo = var_36.soundManager.musicController.getSongInfo(_loc1_.extra);
               getSongInfo(_loc1_);
               return "";
            default:
               if(isWallItem)
               {
                  _loc2_ = "wallItem.desc." + _loc1_.type;
                  break;
               }
               _loc2_ = "roomItem.desc." + _loc1_.type;
         }
         return var_36.controller.localization.getLocalization(_loc2_);
      }
      
      private function getSongInfo(param1:FurnitureItem) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_2069 = -1;
         if(param1 != null)
         {
            if(param1.category == 8)
            {
               var _loc2_:int = param1.extra;
               var _loc3_:ISongInfo = var_36.soundManager.musicController.getSongInfo(0);
               var_36.soundManager.musicController.requestSongInfoWithoutSamples(0);
               var_2069 = 0;
            }
         }
      }
      
      private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent) : void
      {
         if(param1.id == var_2069)
         {
            var_2069 = -1;
            _name = getFurniItemName();
            var_735 = getFurniItemDesc();
            if(var_36.getSelectedItem() == this)
            {
               var_36.updateActionView();
            }
         }
      }
      
      public function get selectedItemIndex() : int
      {
         if(var_1395 >= _items.length)
         {
            var_1395 = Math.max(0,_items.length - 1);
         }
         return var_1395;
      }
      
      public function set selectedItemIndex(param1:int) : void
      {
         if(param1 >= _items.length)
         {
            param1 = 0;
         }
         var_1395 = param1;
      }
   }
}

