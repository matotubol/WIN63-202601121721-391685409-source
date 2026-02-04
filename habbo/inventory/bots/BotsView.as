package com.sulake.habbo.inventory.bots
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import package_182.class_3317;
   
   public class BotsView implements IInventoryView, class_259
   {
      
      private const STATE_NULL:int = 0;
      
      private const STATE_INITIALIZING:int = 1;
      
      private const STATE_EMPTY:int = 2;
      
      private const STATE_CONTENT:int = 3;
      
      private var _windowManager:class_38;
      
      private var var_909:class_40;
      
      private var var_18:class_1812;
      
      private var var_36:BotsModel;
      
      private var _disposed:Boolean = false;
      
      private var var_608:IItemGridWindow;
      
      private var _roomEngine:IRoomEngine;
      
      private var _avatarRenderer:class_48;
      
      private var _gridItems:class_55;
      
      private var var_488:BotGridItem;
      
      private var var_1857:int = 0;
      
      private var var_3248:int;
      
      private var var_265:Boolean = false;
      
      public function BotsView(param1:BotsModel, param2:class_38, param3:class_40, param4:IRoomEngine, param5:class_48)
      {
         super();
         var_36 = param1;
         var_909 = param3;
         _windowManager = param2;
         _roomEngine = param4;
         _avatarRenderer = param5;
         _gridItems = new class_55();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get isVisible() : Boolean
      {
         return var_18 && var_18.parent != null && var_18.visible;
      }
      
      public function dispose() : void
      {
         _windowManager = null;
         _avatarRenderer = null;
         _roomEngine = null;
         var_909 = null;
         var_36 = null;
         var_18 = null;
         _disposed = true;
      }
      
      public function update() : void
      {
         if(!var_265)
         {
            return;
         }
         updateGrid();
         updatePreview(var_488);
         updateContainerVisibility();
      }
      
      public function removeItem(param1:int) : void
      {
         if(!var_265)
         {
            return;
         }
         var _loc2_:BotGridItem = _gridItems.remove(param1) as BotGridItem;
         if(_loc2_ == null)
         {
            return;
         }
         var_608.removeGridItem(_loc2_.window);
         if(var_488 == _loc2_)
         {
            var_488 = null;
            selectFirst();
         }
      }
      
      public function addItem(param1:class_3317) : void
      {
         if(!var_265)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(_gridItems.getValue(param1.id) != null)
         {
            return;
         }
         var _loc2_:BotGridItem = new BotGridItem(this,param1,_windowManager,var_909,var_36.isUnseen(param1.id));
         if(_loc2_ != null)
         {
            var_608.addGridItem(_loc2_.window);
            _gridItems.add(param1.id,_loc2_);
            if(var_488 == null)
            {
               selectFirst();
            }
         }
      }
      
      public function placeItemToRoom(param1:int, param2:Boolean = false) : void
      {
         var_36.placeItemToRoom(param1,param2);
      }
      
      public function getWindowContainer() : class_1812
      {
         if(!var_265)
         {
            init();
         }
         if(var_18 == null)
         {
            return null;
         }
         if(var_18.disposed)
         {
            return null;
         }
         return var_18;
      }
      
      public function setSelectedGridItem(param1:BotGridItem) : void
      {
         if(!var_265)
         {
            return;
         }
         if(var_488 != null)
         {
            var_488.setSelected(false);
         }
         var_488 = param1;
         if(var_488 != null)
         {
            var_488.setSelected(true);
         }
         updatePreview(param1);
      }
      
      public function updateState() : void
      {
         var _loc1_:int = 0;
         if(!var_265)
         {
            return;
         }
         var _loc2_:class_55 = var_36.items;
         if(!var_36.isListInitialized())
         {
            _loc1_ = 1;
         }
         else if(!_loc2_ || _loc2_.length == 0)
         {
            _loc1_ = 2;
         }
         else
         {
            _loc1_ = 3;
         }
         if(var_1857 == _loc1_)
         {
            return;
         }
         var_1857 = _loc1_;
         updateContainerVisibility();
         if(var_1857 == 3)
         {
            updateGrid();
            updatePreview();
         }
      }
      
      public function getGridItemImage(param1:class_3317) : BitmapData
      {
         return getItemImage(param1,3,false,"h");
      }
      
      public function getItemImage(param1:class_3317, param2:int, param3:Boolean, param4:String) : BitmapData
      {
         var _loc5_:BitmapData = null;
         var _loc6_:class_1827 = _avatarRenderer.createAvatarImage(param1.figure,param4,param1.gender,this);
         _loc6_.setDirection("full",param2);
         if(param3)
         {
            _loc5_ = _loc6_.getCroppedImage("full");
         }
         else
         {
            _loc5_ = _loc6_.getCroppedImage("head");
         }
         _loc6_.dispose();
         return _loc5_;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(disposed)
         {
            return;
         }
         for each(var _loc2_ in _gridItems)
         {
            if(_loc2_.data.figure == param1)
            {
               _loc2_.setImage(getGridItemImage(_loc2_.data));
            }
         }
      }
      
      private function selectFirst() : void
      {
         if(_gridItems == null || _gridItems.length == 0)
         {
            updatePreview();
            return;
         }
         setSelectedGridItem(_gridItems.getWithIndex(0));
      }
      
      public function selectById(param1:int) : void
      {
         setSelectedGridItem(_gridItems.getValue(param1));
      }
      
      private function updateGrid() : void
      {
         var _loc4_:int = 0;
         var _loc3_:BotGridItem = null;
         if(var_18 == null)
         {
            return;
         }
         var _loc1_:Array = _gridItems.getKeys();
         var _loc2_:Array = var_36.items ? var_36.items.getKeys() : [];
         var_608.lock();
         for each(_loc4_ in _loc1_)
         {
            if(_loc2_.indexOf(_loc4_) == -1)
            {
               removeItem(_loc4_);
            }
         }
         for each(_loc4_ in _loc2_)
         {
            if(_loc1_.indexOf(_loc4_) == -1)
            {
               addItem(var_36.items.getValue(_loc4_));
            }
            _loc3_ = _gridItems.getValue(_loc4_);
            _loc3_.setUnseen(var_36.isUnseen(_loc4_));
         }
         var_608.unlock();
      }
      
      private function startPlacingHandler(param1:WindowMouseEvent) : void
      {
         if(var_488 == null)
         {
            return;
         }
         var _loc2_:class_3317 = var_488.data;
         if(_loc2_ == null)
         {
            return;
         }
         placeItemToRoom(_loc2_.id);
      }
      
      private function windowEventHandler(param1:class_1758, param2:class_1741) : void
      {
      }
      
      private function updateContainerVisibility() : void
      {
         if(var_36.controller.currentCategoryId != "bots")
         {
            return;
         }
         var _loc1_:class_1812 = var_36.controller.view.loadingContainer;
         var _loc3_:class_1812 = var_36.controller.view.emptyContainer;
         var _loc4_:class_1741 = var_18.findChildByName("grid");
         var _loc2_:class_1741 = var_18.findChildByName("preview_container");
         switch(var_1857 - 1)
         {
            case 0:
               if(_loc1_)
               {
                  _loc1_.visible = true;
               }
               if(_loc3_)
               {
                  _loc3_.visible = false;
               }
               _loc4_.visible = false;
               _loc2_.visible = false;
               break;
            case 1:
               if(_loc1_)
               {
                  _loc1_.visible = false;
               }
               if(_loc3_)
               {
                  _loc3_.visible = true;
               }
               _loc4_.visible = false;
               _loc2_.visible = false;
               break;
            case 2:
               if(_loc1_)
               {
                  _loc1_.visible = false;
               }
               if(_loc3_)
               {
                  _loc3_.visible = false;
               }
               _loc4_.visible = true;
               _loc2_.visible = true;
         }
      }
      
      private function updatePreview(param1:BotGridItem = null) : void
      {
         if(var_18 == null)
         {
            return;
         }
         var_3248 = -1;
         if(param1 == null || param1.data == null)
         {
            var _loc3_:BitmapData = new BitmapData(1,1);
            var _loc11_:String = "";
            var _loc13_:String = "";
            var _loc10_:Boolean = false;
         }
         else
         {
            var _loc4_:class_3317 = param1.data;
            _loc11_ = _loc4_.name;
            _loc13_ = null.motto;
            _loc3_ = getItemImage(null,4,true,"h");
            _loc10_ = true;
         }
         var _loc9_:class_2251 = var_18.findChildByName("preview_image") as class_2251;
         if(_loc9_ != null)
         {
            var _loc5_:BitmapData = new BitmapData(_loc9_.width,_loc9_.height);
            _loc5_.fillRect(_loc5_.rect,0);
            null.copyPixels(null,null.rect,new Point(null.width / 2 - null.width / 2,null.height / 2 - null.height / 2));
            _loc9_.bitmap = null;
         }
         null.dispose();
         var _loc6_:ITextWindow = var_18.findChildByName("bot_name") as ITextWindow;
         if(_loc6_ != null)
         {
            _loc6_.caption = null;
         }
         _loc6_ = var_18.findChildByName("bot_description") as ITextWindow;
         if(_loc6_ != null)
         {
            _loc6_.caption = null;
         }
         var _loc8_:Boolean = false;
         var _loc12_:Boolean = false;
         if(var_36.roomSession != null)
         {
            _loc8_ = var_36.roomSession.areBotsAllowed;
            _loc12_ = var_36.roomSession.isRoomOwner;
         }
         var _loc2_:String = "";
         if(!_loc12_)
         {
            if(_loc8_)
            {
               _loc2_ = "${inventory.bots.allowed}";
            }
            else
            {
               _loc2_ = "${inventory.bots.forbidden}";
            }
         }
         _loc6_ = var_18.findChildByName("preview_info") as ITextWindow;
         if(_loc6_ != null)
         {
            _loc6_.caption = _loc2_;
         }
         var _loc7_:class_1775 = var_18.findChildByName("place_button") as class_1775;
         if(_loc7_ != null)
         {
            _loc7_.disable();
         }
      }
      
      private function addUnseenItemSymbols() : void
      {
      }
      
      private function init() : void
      {
         var_18 = var_36.controller.view.getView("bots");
         var_18.visible = false;
         var_18.procedure = windowEventHandler;
         addUnseenItemSymbols();
         var_608 = var_18.findChildByName("grid") as IItemGridWindow;
         var _loc1_:class_1775 = var_18.findChildByName("place_button") as class_1775;
         var _loc2_:class_2251 = var_18.findChildByName("preview_image") as class_2251;
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_DOWN",startPlacingHandler);
         }
         updatePreview();
         updateState();
         selectFirst();
         var_265 = true;
      }
   }
}

