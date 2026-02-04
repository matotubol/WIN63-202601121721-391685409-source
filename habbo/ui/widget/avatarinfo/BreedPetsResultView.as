package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.inventory.class_61;
   import com.sulake.habbo.inventory.items.class_1875;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.window.class_38;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class BreedPetsResultView implements class_13, class_1829
   {
      
      private static const ELEM_LIST:String = "element_list";
      
      private static const PREVIEW_LIST:String = "preview_list";
      
      private static const PREVIEW_BUTTONLIST:String = "preview_buttonlist";
      
      private static const ELEM_SEED1_ITEMLIST:String = "seed1_itemlist";
      
      private static const ELEM_SEED2_ITEMLIST:String = "seed2_itemlist";
      
      private static const ELEM_SEED1_BUTTONLIST:String = "seed1_buttonlist";
      
      private static const ELEM_SEED2_BUTTONLIST:String = "seed2_buttonlist";
      
      private static const const_639:String = "header_button_close";
      
      private static const const_202:String = "close_button";
      
      private static const const_248:String = "save_button";
      
      private static const ELEM_PLACE_BUTTON1:String = "place_button1";
      
      private static const ELEM_PLACE_BUTTON2:String = "place_button2";
      
      private static const ELEM_PICK_BUTTON1:String = "pick_button1";
      
      private static const ELEM_PICK_BUTTON2:String = "pick_button2";
      
      private static const ELEM_PREVIEW_IMAGE:String = "preview_image";
      
      private static const ELEM_PREVIEW_IMAGE2:String = "preview_image2";
      
      private static const const_167:String = "preview_image_region";
      
      private static const ELEM_PREVIEW_IMAGE_REGION2:String = "preview_image_region2";
      
      private static const ELEM_BUTTON_LIST:String = "button_list";
      
      private static const const_177:String = "description";
      
      private static const const_1212:String = "description_sorry";
      
      private static const ELEM_INFO:String = "info";
      
      private static const const_438:String = "info_sorry";
      
      private static const ELEM_INFO_MUTATE1:String = "info_mutate1";
      
      private static const ELEM_INFO_MUTATE2:String = "info_mutate2";
      
      private static const const_147:String = "ok_button";
      
      private var _window:class_2250;
      
      private var var_1134:Boolean = false;
      
      private var var_16:AvatarInfoWidget;
      
      private var _windowManager:class_38;
      
      private var _assets:class_40;
      
      private var var_1532:class_55;
      
      private var var_357:BreedPetsResultData;
      
      private var _resultData2:BreedPetsResultData;
      
      private var var_1709:Boolean;
      
      public function BreedPetsResultView(param1:AvatarInfoWidget)
      {
         super();
         var_16 = param1;
         _windowManager = param1.windowManager;
         _assets = var_16.assets;
         var_1532 = new class_55();
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         var_1134 = true;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_1532 != null)
         {
            var_1532.dispose();
         }
         var_1532 = null;
      }
      
      public function open(param1:BreedPetsResultData, param2:BreedPetsResultData) : void
      {
         var_357 = param1;
         _resultData2 = param2;
         setWindowContent();
         show();
      }
      
      private function resolvePreviewImage(param1:int, param2:String) : BitmapData
      {
         var _loc5_:BitmapData = null;
         var _loc4_:int = 0;
         var _loc3_:class_2198 = var_16.handler.container.roomEngine.getFurnitureImage(param1,new Vector3d(90,0,0),64,this,0,null,-1,-1,null);
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.id;
            if(_loc4_ > 0)
            {
               var_1532.add(_loc4_,param2);
            }
            _loc5_ = _loc3_.data;
         }
         return _loc5_;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed)
         {
            return;
         }
         var _loc3_:String = var_1532.getValue(param1);
         if(_loc3_ != null)
         {
            updatePreviewImage(param2,_loc3_);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function setWindowContent() : void
      {
         var _loc3_:String = null;
         var _loc1_:class_1800 = var_16.handler.container.sessionDataManager.getFloorItemData(var_357.classId);
         var _loc4_:class_1800 = var_16.handler.container.sessionDataManager.getFloorItemData(_resultData2.classId);
         var_16.localizations.registerParameter("breedpetsresult.widget.seed1.name","name",_loc1_ != null ? _loc1_.localizedName : "");
         var_16.localizations.registerParameter("breedpetsresult.widget.seed2.name","name",_loc4_ != null ? _loc4_.localizedName : "");
         var_16.localizations.registerParameter("breedpetsresult.widget.seed1.description","name",var_357.userName);
         var_16.localizations.registerParameter("breedpetsresult.widget.seed2.description","name",_resultData2.userName);
         var_16.localizations.registerParameter("breedpetsresult.widget.seed1.raritylevel","level",var_357.rarityLevel.toString());
         var_16.localizations.registerParameter("breedpetsresult.widget.seed2.raritylevel","level",_resultData2.rarityLevel.toString());
         var _loc7_:int = var_16.handler.container.sessionDataManager.userId;
         var _loc5_:* = var_357.userId == _loc7_;
         var _loc6_:* = _resultData2.userId == _loc7_;
         var _loc2_:Boolean = _loc5_ || _loc6_;
         if(!_loc2_)
         {
            _loc3_ = "";
            if(var_357.userName != null && var_357.userName != "")
            {
               _loc3_ = var_357.userName;
            }
            else if(_resultData2.userName != null && _resultData2.userName != "")
            {
               _loc3_ = _resultData2.userName;
            }
            var_16.localization.registerParameter("breedpetsresult.widget.text.sorry","name",_loc3_);
         }
         if(!_window)
         {
            _window = _windowManager.buildFromXML(_assets.getAssetByName("breed_pets_result_xml").content as XML) as class_2250;
            addClickListener("header_button_close");
         }
         _window.center();
         _window.visible = true;
         enableElement("seed1_buttonlist",false);
         enableElement("seed2_buttonlist",false);
         enableElement("place_button1",false);
         enableElement("pick_button1",false);
         enableElement("place_button2",false);
         enableElement("pick_button2",false);
         enableElement("close_button",false);
         if(_loc5_)
         {
            enableElement("place_button1",true);
            enableElement("seed1_buttonlist",true);
         }
         if(_loc6_)
         {
            enableElement("place_button2",true);
            enableElement("seed2_buttonlist",true);
         }
         if(_loc2_)
         {
            enableElement("preview_buttonlist",true);
         }
         enableElement("seed2_itemlist",true);
         if(_resultData2.stuffId == -1)
         {
            enableElement("seed2_itemlist",false);
         }
         enableElement("description",true);
         enableElement("info",true);
         enableElement("description_sorry",false);
         enableElement("info",false);
         enableElement("button_list",false);
         enableElement("close_button",false);
         if(!_loc2_)
         {
            enableElement("preview_buttonlist",false);
            enableElement("description",false);
            enableElement("info",false);
            enableElement("save_button",false);
            enableElement("place_button1",false);
            enableElement("pick_button1",false);
            enableElement("place_button2",false);
            enableElement("pick_button2",false);
            enableElement("button_list",true);
            enableElement("description_sorry",true);
            enableElement("info_sorry",true);
            enableElement("close_button",true);
         }
         enableElement("info_mutate1",false);
         enableElement("info_mutate2",false);
         if(var_357.hasMutation)
         {
            enableElement("info_mutate1",true);
         }
         if(_resultData2.hasMutation)
         {
            enableElement("info_mutate2",true);
         }
         addClickListener("save_button");
         addClickListener("header_button_close");
         addClickListener("close_button");
         addClickListener("place_button1");
         addClickListener("place_button2");
         addClickListener("pick_button1");
         addClickListener("pick_button2");
         addClickListener("preview_image_region");
         addClickListener("preview_image_region2");
         var _loc8_:BitmapData = resolvePreviewImage(_loc1_.id,"preview_image");
         updatePreviewImage(_loc8_ ?? new BitmapData(10,10),"preview_image");
         _loc8_ = resolvePreviewImage(_loc1_.id,"preview_image2");
         updatePreviewImage(_loc8_ ?? new BitmapData(10,10),"preview_image2");
         arrangeListItems();
         _window.invalidate();
      }
      
      private function enableElement(param1:String, param2:Boolean) : void
      {
         var _loc3_:class_1741 = _window.findChildByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.visible = param2;
         }
      }
      
      private function arrangeListItems() : void
      {
         arrangeListItem("seed1_itemlist");
         arrangeListItem("seed2_itemlist");
         arrangeListItem("seed1_buttonlist");
         arrangeListItem("seed2_buttonlist");
         arrangeListItem("preview_buttonlist");
         arrangeListItem("button_list");
         arrangeListItem("preview_list");
         arrangeListItem("element_list");
         _window.resizeToFitContent();
      }
      
      private function arrangeListItem(param1:String) : void
      {
         var _loc2_:IItemListWindow = _window.findChildByName(param1) as IItemListWindow;
         if(_loc2_ != null)
         {
            _loc2_.arrangeListItems();
         }
      }
      
      private function updatePreviewImage(param1:BitmapData, param2:String) : void
      {
         var _loc5_:BitmapData = null;
         if(!_window || !param1)
         {
            return;
         }
         var _loc6_:class_2251 = _window.findChildByName(param2) as class_2251;
         _loc6_.bitmap = new BitmapData(_loc6_.width,_loc6_.height);
         var _loc3_:IAsset = _assets.getAssetByName("breed_pets_preview_bg_png") as IAsset;
         if(_loc3_)
         {
            _loc5_ = _loc3_.content as BitmapData;
            _loc6_.bitmap.copyPixels(_loc5_,_loc5_.rect,new Point(0,0));
         }
         var _loc4_:Point = new Point((_loc6_.width - param1.width) / 2,(_loc6_.height - param1.height) / 2);
         _loc6_.bitmap.copyPixels(param1,param1.rect,_loc4_,null,null,true);
      }
      
      public function close() : void
      {
         if(var_16)
         {
            var_16.removeBreedPetsResultView(this);
         }
      }
      
      public function show() : void
      {
         var_1709 = false;
         if(_window)
         {
            _window.visible = true;
         }
      }
      
      private function hide() : void
      {
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      private function addClickListener(param1:String) : void
      {
         var _loc2_:class_1741 = _window.findChildByName(param1);
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseClick);
         }
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "header_button_close":
            case "close_button":
               close();
               break;
            case "place_button1":
               var_1709 = placeItemToRoom(var_357.stuffId);
               if(var_1709)
               {
                  close();
               }
               break;
            case "place_button2":
               var_1709 = placeItemToRoom(_resultData2.stuffId);
               if(var_1709)
               {
                  close();
               }
               break;
            case "pick_button1":
               pickItemFromRoom(var_357.stuffId);
               break;
            case "pick_button2":
               pickItemFromRoom(_resultData2.stuffId);
               break;
            case "preview_image_region":
               selectItemFromInventoryOrRoom(var_357.stuffId);
               break;
            case "preview_image_region2":
               selectItemFromInventoryOrRoom(_resultData2.stuffId);
               break;
            case "ok_button":
               hide();
               break;
            case "save_button":
               hide();
         }
      }
      
      private function selectItemFromInventoryOrRoom(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:class_1875 = findInventoryFloorItemById(param1);
         if(_loc2_ != null)
         {
            var_16.handler.container.inventory.toggleInventoryPage("furni");
            return true;
         }
         var _loc3_:IRoomObject = findRoomObject(param1);
         if(_loc3_ != null)
         {
            _loc4_ = var_16.handler.container.roomSession.roomId;
            _loc5_ = 10;
            var_16.handler.container.roomEngine.selectRoomObject(_loc4_,_loc3_.getId(),_loc5_);
            return true;
         }
         return false;
      }
      
      private function pickItemFromRoom(param1:int) : Boolean
      {
         var _loc2_:IRoomObject = findRoomObject(param1);
         if(_loc2_ != null)
         {
            var_16.handler.container.roomEngine.modifyRoomObject(_loc2_.getId(),10,"OBJECT_PICKUP");
            return true;
         }
         return false;
      }
      
      private function placeItemToRoom(param1:int) : Boolean
      {
         var _loc2_:class_1875 = findInventoryFloorItemById(param1);
         return requestSelectedFurniPlacement(_loc2_);
      }
      
      private function findRoomObject(param1:int) : IRoomObject
      {
         var _loc3_:int = var_16.handler.container.roomSession.roomId;
         return var_16.handler.container.roomEngine.getRoomObject(_loc3_,param1,10);
      }
      
      private function findInventoryFloorItemById(param1:int) : class_1875
      {
         if(var_16 == null)
         {
            return null;
         }
         var _loc3_:class_61 = var_16.handler.container.inventory;
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getFloorItemById(-param1);
      }
      
      private function requestSelectedFurniPlacement(param1:class_1875) : Boolean
      {
         if(param1 == null || var_16 == null)
         {
            return false;
         }
         var _loc3_:class_61 = var_16.handler.container.inventory;
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc2_:Boolean = false;
         if(param1.category == 3 || param1.category == 2 || param1.category == 4)
         {
            _loc2_ = false;
         }
         else
         {
            _loc2_ = _loc3_.requestSelectedFurniToMover(param1);
         }
         return _loc2_;
      }
      
      public function roomObjectRemoved(param1:int) : void
      {
         if(var_357 == null || _resultData2 == null)
         {
            return;
         }
         if(var_357.stuffId == param1 || _resultData2.stuffId == param1)
         {
            updatePlacingButtons();
            show();
         }
      }
      
      public function roomObjectAdded(param1:int) : void
      {
         if(var_357 == null || _resultData2 == null)
         {
            return;
         }
         if(var_357.stuffId == param1 || _resultData2.stuffId == param1)
         {
            updatePlacingButtons();
            show();
         }
      }
      
      public function updatePlacingButtons() : void
      {
         updateButtons(var_357,"place_button1","pick_button1");
         updateButtons(_resultData2,"place_button2","pick_button2");
         arrangeListItems();
      }
      
      private function updateButtons(param1:BreedPetsResultData, param2:String, param3:String) : void
      {
         var _loc5_:class_1875 = null;
         if(_window == null || param1 == null)
         {
            return;
         }
         var _loc10_:int = var_16.handler.container.sessionDataManager.userId;
         var _loc4_:* = param1.userId == _loc10_;
         var _loc9_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc7_:IRoomObject = findRoomObject(param1.stuffId);
         if(_loc7_ != null)
         {
            _loc8_ = true;
         }
         if(!_loc8_)
         {
            _loc5_ = findInventoryFloorItemById(param1.stuffId);
            if(_loc5_ != null)
            {
               _loc9_ = true;
            }
         }
         var _loc6_:class_1741 = _window.findChildByName(param2);
         var _loc11_:class_1741 = _window.findChildByName(param3);
         if(_loc6_ != null)
         {
            _loc6_.visible = false;
            if(_loc4_)
            {
               if(_loc9_)
               {
                  _loc6_.visible = true;
               }
               if(!_loc9_ && !_loc8_)
               {
                  _loc6_.visible = true;
               }
            }
         }
         if(_loc11_ != null)
         {
            _loc11_.visible = false;
            if(_loc4_)
            {
               if(_loc8_)
               {
                  _loc11_.visible = true;
               }
            }
         }
      }
   }
}

