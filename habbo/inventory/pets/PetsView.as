package com.sulake.habbo.inventory.pets
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
   import com.sulake.habbo.avatar.pets.PetCustomPart;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.window.class_38;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import package_105.class_2486;
   import package_105.class_2838;
   
   public class PetsView implements IInventoryView, class_1829
   {
      
      private static const UNSEEN_SYMBOL_MARGIN:int = 4;
      
      private const STATE_NULL:int = 0;
      
      private const STATE_INITIALIZING:int = 1;
      
      private const STATE_EMPTY:int = 2;
      
      private const STATE_CONTENT:int = 3;
      
      private var _windowManager:class_38;
      
      private var var_909:class_40;
      
      private var var_18:class_1812;
      
      private var var_36:PetsModel;
      
      private var _disposed:Boolean = false;
      
      private var var_608:IItemGridWindow;
      
      private var _roomEngine:IRoomEngine;
      
      private var _gridItems:class_55;
      
      private var var_488:PetsGridItem;
      
      private var var_1857:int = 0;
      
      private var var_3248:int;
      
      private var var_265:Boolean = false;
      
      public function PetsView(param1:PetsModel, param2:class_38, param3:class_40, param4:IRoomEngine)
      {
         super();
         var_36 = param1;
         var_909 = param3;
         _windowManager = param2;
         _roomEngine = param4;
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
         if(!_disposed)
         {
            _windowManager = null;
            var_36 = null;
            var_18 = null;
            _disposed = true;
         }
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
      
      public function removePet(param1:int) : void
      {
         if(!var_265)
         {
            return;
         }
         var _loc2_:PetsGridItem = _gridItems.remove(param1) as PetsGridItem;
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
      
      public function addPet(param1:class_2838) : void
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
         var _loc2_:PetsGridItem = new PetsGridItem(this,param1,_windowManager,var_909,var_36.isUnseen(param1.id));
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
      
      public function placePetToRoom(param1:int, param2:Boolean = false) : void
      {
         var_36.placePetToRoom(param1,param2);
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
      
      public function setSelectedGridItem(param1:PetsGridItem) : void
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
         var _loc2_:int = 0;
         if(!var_265)
         {
            return;
         }
         var _loc1_:class_55 = var_36.pets;
         if(!var_36.isListInitialized())
         {
            _loc2_ = 1;
         }
         else if(!_loc1_ || _loc1_.length == 0)
         {
            _loc2_ = 2;
         }
         else
         {
            _loc2_ = 3;
         }
         if(var_1857 == _loc2_)
         {
            return;
         }
         var_1857 = _loc2_;
         updateContainerVisibility();
         if(var_1857 == 3)
         {
            updateGrid();
            updatePreview();
         }
      }
      
      public function getPetImage(param1:class_2838, param2:int, param3:Boolean, param4:PetsGridItem = null, param5:int = 64, param6:String = null) : BitmapData
      {
         var _loc9_:int = 0;
         var _loc10_:class_2486 = param1.figureData;
         var _loc7_:BitmapData = null;
         var _loc8_:uint = parseInt(_loc10_.color,16);
         var _loc13_:Array = [];
         _loc9_ = 0;
         while(_loc9_ < _loc10_.customPartCount * 3)
         {
            _loc13_.push(new PetCustomPart(_loc10_.customParts[_loc9_],_loc10_.customParts[_loc9_ + 1],_loc10_.customParts[_loc9_ + 2]));
            _loc9_ += 3;
         }
         var _loc12_:class_2198 = _roomEngine.getPetImage(_loc10_.typeId,_loc10_.paletteId,_loc8_,new Vector3d(param2 * 45),param5,this,param3,0,_loc13_,param6);
         if(_loc12_ != null)
         {
            _loc7_ = _loc12_.data;
            if(param4 != null)
            {
               param4.imageDownloadId = _loc12_.id;
            }
            else if(param3)
            {
               var_3248 = _loc12_.id;
            }
         }
         if(_loc7_ == null)
         {
            _loc7_ = new BitmapData(30,30,false,4289374890);
         }
         return _loc7_;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(param1 == var_3248)
         {
            updatePreview(var_488);
            return;
         }
         for each(var _loc3_ in _gridItems)
         {
            if(_loc3_.imageDownloadId == param1)
            {
               _loc3_.setPetImage(param2);
               return;
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
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
         var _loc3_:PetsGridItem = null;
         if(var_18 == null)
         {
            return;
         }
         var _loc1_:Array = _gridItems.getKeys();
         var _loc2_:Array = var_36.pets ? var_36.pets.getKeys() : [];
         var_608.lock();
         for each(_loc4_ in _loc1_)
         {
            if(_loc2_.indexOf(_loc4_) == -1)
            {
               removePet(_loc4_);
            }
         }
         for each(_loc4_ in _loc2_)
         {
            if(_loc1_.indexOf(_loc4_) == -1)
            {
               addPet(var_36.pets.getValue(_loc4_));
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
         var _loc2_:class_2838 = var_488.pet;
         if(_loc2_ == null)
         {
            return;
         }
         placePetToRoom(_loc2_.id);
      }
      
      private function updateContainerVisibility() : void
      {
         if(var_36.controller.currentCategoryId != "pets")
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
      
      private function updatePreview(param1:PetsGridItem = null) : void
      {
         if(var_18 == null)
         {
            return;
         }
         var_3248 = -1;
         if(param1 == null || param1.pet == null)
         {
            var _loc15_:BitmapData = new BitmapData(1,1);
            var _loc8_:String = "";
            var _loc7_:String = "";
            var _loc11_:Boolean = false;
         }
         else
         {
            var _loc16_:class_2838 = param1.pet;
            _loc8_ = _loc16_.name;
            if(null.typeId == 16)
            {
               var _loc17_:int = 2;
               var _loc14_:Boolean = true;
               if(null.level >= 7)
               {
                  var _loc4_:String = "std";
               }
               else
               {
                  _loc4_ = "grw" + null.level;
               }
            }
            _loc15_ = getPetImage(null,4,true,null,64,null);
            _loc11_ = true;
         }
         var _loc10_:class_2251 = var_18.findChildByName("preview_image") as class_2251;
         if(_loc10_ != null)
         {
            var _loc3_:BitmapData = new BitmapData(_loc10_.width,_loc10_.height);
            null.fillRect(null.rect,0);
            null.copyPixels(null,null.rect,new Point(null.width / 2 - null.width / 2,null.height / 2 - null.height / 2));
            _loc10_.bitmap = null;
         }
         null.dispose();
         var _loc6_:ITextWindow = var_18.findChildByName("preview_text") as ITextWindow;
         if(_loc6_ != null)
         {
            _loc6_.caption = null;
         }
         _loc6_ = var_18.findChildByName("preview_description") as ITextWindow;
         if(_loc6_ != null)
         {
            _loc6_.caption = null;
         }
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         if(var_36.roomSession != null)
         {
            _loc12_ = var_36.roomSession.arePetsAllowed;
            _loc13_ = var_36.roomSession.isRoomOwner;
         }
         var _loc2_:String = "";
         if(!_loc13_)
         {
            if(_loc12_)
            {
               _loc2_ = "${inventory.pets.allowed}";
            }
            else
            {
               _loc2_ = "${inventory.pets.forbidden}";
            }
         }
         _loc6_ = var_18.findChildByName("preview_info") as ITextWindow;
         if(_loc6_ != null)
         {
            _loc6_.caption = _loc2_;
         }
         var _loc9_:class_1775 = var_18.findChildByName("place_button") as class_1775;
         if(_loc9_ != null)
         {
            _loc9_.disable();
         }
      }
      
      private function init() : void
      {
         var_18 = var_36.controller.view.getView("pets");
         var_18.visible = false;
         var_608 = var_18.findChildByName("grid") as IItemGridWindow;
         var _loc1_:class_1775 = var_18.findChildByName("place_button") as class_1775;
         var _loc2_:class_2251 = var_18.findChildByName("preview_image") as class_2251;
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_DOWN",startPlacingHandler);
         }
         updatePreview();
         updateState();
         var_265 = true;
      }
   }
}

