package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.pets.PetCustomPart;
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.room.PetColorResult;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUseProductMessage;
   import com.sulake.habbo.window.class_38;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class UseProductConfirmationView implements class_13, class_1829
   {
      
      private static const PRODUCT_PAGE_UKNOWN:int = -1;
      
      private static const PRODUCT_PAGE_SHAMPOO:int = 0;
      
      private static const PRODUCT_PAGE_CUSTOM_PART:int = 1;
      
      private static const PRODUCT_PAGE_CUSTOM_PART_SHAMPOO:int = 2;
      
      private static const PRODUCT_PAGE_SADDLE:int = 3;
      
      private static const PRODUCT_PAGE_REVIVE:int = 4;
      
      private static const PRODUCT_PAGE_REBREED:int = 5;
      
      private static const PRODUCT_PAGE_FERTILIZE:int = 6;
      
      private static const const_202:String = "header_button_close";
      
      private static const const_248:String = "save_button";
      
      private static const const_207:String = "cancel_text";
      
      private static const const_147:String = "ok_button";
      
      private static const const_167:String = "preview_image_region";
      
      private var _window:class_1812;
      
      private var var_1134:Boolean = false;
      
      private var var_16:AvatarInfoWidget;
      
      private var _windowManager:class_38;
      
      private var _assets:class_40;
      
      private var var_2259:int = -1;
      
      private var var_2190:int = -1;
      
      private var var_2911:int;
      
      private var var_587:class_1800;
      
      private var var_311:class_2146;
      
      public function UseProductConfirmationView(param1:AvatarInfoWidget)
      {
         super();
         var_16 = param1;
         _windowManager = param1.windowManager;
         _assets = var_16.assets;
      }
      
      public function get requestObjectId() : int
      {
         return var_2259;
      }
      
      public function get targetRoomObjectId() : int
      {
         return var_2190;
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
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         var_1134 = true;
         var_587 = null;
         var_311 = null;
      }
      
      public function open(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:int = var_16.handler.roomSession.roomId;
         var _loc6_:IRoomObject = var_16.handler.roomEngine.getRoomObject(_loc5_,param1,10);
         if(_loc6_ != null)
         {
            var_587 = var_16.handler.getFurniData(_loc6_);
            var_2259 = _loc6_.getId();
         }
         else
         {
            var_587 = var_16.handler.container.sessionDataManager.getFloorItemData(param1);
            var_2259 = param3;
         }
         var_2190 = param2;
         var_311 = var_16.handler.roomSession.userDataManager.getUserDataByIndex(param2);
         var _loc4_:int = -1;
         switch(var_587.category - 13)
         {
            case 0:
               _loc4_ = 0;
               break;
            case 1:
               _loc4_ = 1;
               break;
            case 2:
               _loc4_ = 2;
               break;
            case 3:
               _loc4_ = 3;
               break;
            case 7:
               _loc4_ = 4;
               break;
            case 8:
               _loc4_ = 5;
               break;
            case 9:
               _loc4_ = 6;
               break;
            default:
               class_21.log("[UseProductConfirmationView.open()] Unsupported furniture category: " + var_587.category);
         }
         setWindowContent(_loc4_);
         _window.center();
         _window.visible = true;
      }
      
      private function setWindowContent(param1:int) : void
      {
         var _loc3_:String = null;
         var _loc2_:BitmapData = new BitmapData(10,10);
         var_16.localizations.registerParameter("useproduct.widget.title","name",var_311.name);
         var_16.localizations.registerParameter("useproduct.widget.title.monsterplant","name",var_311.name);
         var_16.localizations.registerParameter("useproduct.widget.title.monsterplant_rebreed","name",var_311.name);
         var_16.localizations.registerParameter("useproduct.widget.title.monsterplant_fertilize","name",var_311.name);
         var_16.localizations.registerParameter("useproduct.widget.title.monsterplant_rebreed","name",var_311.name);
         var_16.localizations.registerParameter("useproduct.widget.monsterplant.plant.name","name",var_311.name);
         var_16.localizations.registerParameter("useproduct.widget.monsterplant.plant.raritylevel","level",var_311.rarityLevel.toString());
         var_16.localizations.registerParameter("useproduct.widget.monsterplant.plant.description","name",var_311.ownerName);
         if(!_window)
         {
            _loc3_ = "use_product_widget_frame_xml";
            switch(param1 - 4)
            {
               case 0:
                  _loc3_ = "use_product_widget_frame_monsterplant_xml";
                  break;
               case 1:
                  _loc3_ = "use_product_widget_frame_monsterplant_rebreed_xml";
                  break;
               case 2:
                  _loc3_ = "use_product_widget_frame_monsterplant_fertilize_xml";
                  break;
               default:
                  _loc3_ = "use_product_widget_frame_xml";
            }
            _window = _windowManager.buildFromXML(_assets.getAssetByName(_loc3_).content as XML) as class_1812;
            addClickListener("header_button_close");
         }
         var_16.localizations.registerParameter("useproduct.widget.text.saddle","productName",var_587.localizedName);
         var_16.localizations.registerParameter("useproduct.widget.text.custompart","productName",var_587.localizedName);
         var_16.localizations.registerParameter("useproduct.widget.text.custompartshampoo","productName",var_587.localizedName);
         var_16.localizations.registerParameter("useproduct.widget.text.shampoo","productName",var_587.localizedName);
         var_16.localizations.registerParameter("useproduct.widget.text.revive_monsterplant","productName",var_587.localizedName);
         (_window as class_2250).content.removeChildAt(0);
         var _loc4_:class_1741 = createWindow(param1);
         (_window as class_2250).content.addChild(_loc4_);
         (_window as class_2250).resizeToFitContent();
         switch(param1)
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
               addClickListener("preview_image_region");
               addClickListener("save_button");
               addClickListener("cancel_text");
               _loc2_ = resolvePreviewImage(var_587);
               updatePreviewImage(_loc2_);
               _window.invalidate();
               return;
            default:
               throw new Error("Invalid type for use product confirmation content apply: " + param1);
         }
      }
      
      private function createWindow(param1:int) : class_1741
      {
         var _loc2_:IAsset = null;
         var _loc3_:* = null;
         switch(param1)
         {
            case 0:
               _loc2_ = _assets.getAssetByName("use_product_controller_shampoo_xml");
               break;
            case 1:
               _loc2_ = _assets.getAssetByName("use_product_controller_custom_part_xml");
               break;
            case 2:
               _loc2_ = _assets.getAssetByName("use_product_controller_custom_part_shampoo_xml");
               break;
            case 3:
               _loc2_ = _assets.getAssetByName("use_product_controller_saddle_xml");
               break;
            case 4:
               _loc2_ = _assets.getAssetByName("use_product_controller_revive_monsterplant_xml");
               break;
            case 5:
               _loc2_ = _assets.getAssetByName("use_product_controller_rebreed_monsterplant_xml");
               break;
            case 6:
               _loc2_ = _assets.getAssetByName("use_product_controller_fertilize_monsterplant_xml");
               break;
            default:
               throw new Error("Invalid type for Use Product View content creation: " + param1);
         }
         return _windowManager.buildFromXML(_loc2_.content as XML) as class_1741;
      }
      
      private function resolvePreviewImage(param1:class_1800) : BitmapData
      {
         var _loc7_:class_2198 = null;
         var _loc21_:Array = null;
         var _loc16_:Array = null;
         var _loc18_:Array = null;
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc14_:int = 0;
         var _loc5_:int = 0;
         var _loc20_:PetCustomPart = null;
         var _loc19_:String = null;
         var _loc11_:Array = null;
         var _loc10_:PetColorResult = null;
         var _loc8_:String = null;
         var _loc15_:IRoomObject = null;
         var _loc6_:int = 0;
         if(!param1)
         {
            return null;
         }
         var _loc12_:PetFigureData = new PetFigureData(var_311.figure);
         var _loc3_:Array = param1.customParams.split(" ");
         var _loc17_:int = int(_loc3_[0]);
         var _loc22_:Array = [];
         switch(param1.category - 13)
         {
            case 0:
               if(_loc3_.length < 2)
               {
                  class_21.log("[UseProductConfirmationView] Invalid custom params: " + _loc3_);
                  break;
               }
               _loc19_ = _loc3_[1];
               _loc11_ = var_16.handler.roomEngine.getPetColorsByTag(_loc17_,_loc19_);
               _loc10_ = var_16.handler.roomEngine.getPetColor(_loc17_,_loc12_.paletteId);
               for each(var _loc4_ in _loc11_)
               {
                  if(_loc4_.breed == _loc10_.breed)
                  {
                     _loc2_ = int(_loc4_.id);
                     break;
                  }
               }
               _loc7_ = var_16.handler.roomEngine.getPetImage(_loc12_.typeId,_loc2_,_loc12_.color,new Vector3d(90),64,this,true,0,_loc12_.customParts);
               break;
            case 1:
               if(_loc3_.length < 4)
               {
                  class_21.log("[UseProductConfirmationView] Invalid custom params: " + _loc3_);
                  break;
               }
               _loc21_ = (_loc3_[1] as String).split(",");
               _loc16_ = (_loc3_[2] as String).split(",");
               _loc18_ = (_loc3_[3] as String).split(",");
               _loc9_ = 0;
               while(_loc9_ < _loc21_.length)
               {
                  _loc14_ = int(_loc21_[_loc9_]);
                  _loc20_ = _loc12_.getCustomPart(_loc14_);
                  _loc2_ = int(_loc18_[_loc9_]);
                  if(_loc20_ != null)
                  {
                     _loc2_ = _loc20_.paletteId;
                  }
                  _loc22_.push(new PetCustomPart(_loc14_,_loc16_[_loc9_],_loc2_));
                  _loc9_++;
               }
               _loc7_ = var_16.handler.roomEngine.getPetImage(_loc12_.typeId,_loc12_.paletteId,_loc12_.color,new Vector3d(90),64,this,true,0,_loc22_);
               break;
            case 2:
               if(_loc3_.length < 3)
               {
                  class_21.log("[UseProductConfirmationView] Invalid custom params: " + _loc3_);
                  break;
               }
               _loc21_ = (_loc3_[1] as String).split(",");
               _loc18_ = (_loc3_[2] as String).split(",");
               _loc9_ = 0;
               while(_loc9_ < _loc21_.length)
               {
                  _loc14_ = int(_loc21_[_loc9_]);
                  _loc20_ = _loc12_.getCustomPart(_loc14_);
                  _loc5_ = -1;
                  if(_loc20_ != null)
                  {
                     _loc5_ = _loc20_.partId;
                  }
                  _loc22_.push(new PetCustomPart(_loc21_[_loc9_],_loc5_,_loc18_[_loc9_]));
                  _loc9_++;
               }
               _loc7_ = var_16.handler.roomEngine.getPetImage(_loc12_.typeId,_loc12_.paletteId,_loc12_.color,new Vector3d(90),64,this,true,0,_loc22_);
               break;
            case 3:
               if(_loc3_.length < 4)
               {
                  class_21.log("[UseProductConfirmationView] Invalid custom params: " + _loc3_);
                  break;
               }
               _loc21_ = (_loc3_[1] as String).split(",");
               _loc16_ = (_loc3_[2] as String).split(",");
               _loc18_ = (_loc3_[3] as String).split(",");
               _loc9_ = 0;
               while(_loc9_ < _loc21_.length)
               {
                  _loc22_.push(new PetCustomPart(_loc21_[_loc9_],_loc16_[_loc9_],_loc18_[_loc9_]));
                  _loc9_++;
               }
               for each(var _loc13_ in _loc12_.customParts)
               {
                  if(_loc21_.indexOf(_loc13_.layerId) == -1)
                  {
                     _loc22_.push(_loc13_);
                  }
               }
               _loc7_ = var_16.handler.roomEngine.getPetImage(_loc12_.typeId,_loc12_.paletteId,_loc12_.color,new Vector3d(90),64,this,true,0,_loc22_);
               break;
            case 7:
            case 8:
            case 9:
               _loc8_ = null;
               if(var_311 != null)
               {
                  _loc8_ = "rip";
                  _loc15_ = getRoomUserObject(var_311.roomObjectId);
                  if(_loc15_ != null)
                  {
                     _loc8_ = _loc15_.getModel().getString("figure_posture");
                     if(_loc8_ == "rip")
                     {
                        _loc6_ = var_311.petLevel;
                        if(_loc6_ < 7)
                        {
                           _loc8_ = "grw" + _loc6_;
                        }
                        else
                        {
                           _loc8_ = "std";
                        }
                     }
                  }
               }
               _loc7_ = var_16.handler.roomEngine.getPetImage(_loc12_.typeId,_loc12_.paletteId,_loc12_.color,new Vector3d(90),64,this,true,0,_loc12_.customParts,_loc8_);
               break;
            default:
               class_21.log("[UseProductConfirmationView] Unsupported furniture category: " + param1.category);
         }
         if(_loc7_ != null)
         {
            var_2911 = _loc7_.id;
            var _loc23_:BitmapData = _loc7_.data;
         }
         return null;
      }
      
      private function getRoomUserObject(param1:int) : IRoomObject
      {
         return var_16.handler.roomEngine.getRoomObject(var_16.handler.roomEngine.activeRoomId,param1,100);
      }
      
      private function updatePreviewImage(param1:BitmapData) : void
      {
         var _loc4_:BitmapData = null;
         if(!_window || !param1)
         {
            return;
         }
         var _loc5_:class_2251 = _window.findChildByName("preview_image") as class_2251;
         if(_loc5_.bitmap == null)
         {
            _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height);
         }
         var _loc2_:IAsset = _assets.getAssetByName("use_product_preview_bg_png") as IAsset;
         if(_loc2_)
         {
            _loc4_ = _loc2_.content as BitmapData;
            _loc5_.bitmap.copyPixels(_loc4_,_loc4_.rect,new Point(0,0));
         }
         var _loc3_:Point = new Point((_loc5_.width - param1.width) / 2,(_loc5_.height - param1.height) / 2);
         _loc5_.bitmap.copyPixels(param1,param1.rect,_loc3_,null,null,true);
      }
      
      private function close() : void
      {
         _window.visible = false;
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
            case "preview_image_region":
               if(var_311 != null)
               {
                  selectItemFromRoom(var_311.roomObjectId,100);
               }
               break;
            case "header_button_close":
            case "cancel_text":
            case "ok_button":
               close();
               break;
            case "save_button":
               var _loc2_:RoomWidgetMessage = new RoomWidgetUseProductMessage("RWUPM_PET_PRODUCT",var_2259,var_311.webID);
               close();
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed)
         {
            return;
         }
         if(var_2911 == param1)
         {
            updatePreviewImage(param2);
            var_2911 = 0;
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function selectItemFromRoom(param1:int, param2:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:IRoomObject = findRoomObject(param1,param2);
         if(_loc3_ != null)
         {
            _loc4_ = var_16.handler.container.roomSession.roomId;
            var_16.handler.container.roomEngine.selectRoomObject(_loc4_,_loc3_.getId(),param2);
            return true;
         }
         return false;
      }
      
      private function findRoomObject(param1:int, param2:int) : IRoomObject
      {
         var _loc4_:int = var_16.handler.container.roomSession.roomId;
         return var_16.handler.container.roomEngine.getRoomObject(_loc4_,param1,param2);
      }
   }
}

