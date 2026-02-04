package com.sulake.habbo.ui.widget.furniture.contextmenu
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUseProductMessage;
   import com.sulake.habbo.window.class_38;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   
   public class MonsterPlantSeedConfirmationView implements class_13, class_1829
   {
      
      private static const PRODUCT_PAGE_UKNOWN:int = -1;
      
      private static const PRODUCT_PAGE_SEED:int = 0;
      
      private static const const_202:String = "header_button_close";
      
      private static const const_248:String = "save_button";
      
      private static const const_207:String = "cancel_text";
      
      private static const const_147:String = "ok_button";
      
      private var _window:class_1812;
      
      private var var_1134:Boolean = false;
      
      private var var_16:FurnitureContextMenuWidget;
      
      private var _windowManager:class_38;
      
      private var _assets:class_40;
      
      private var var_2259:int = -1;
      
      private var var_2911:int;
      
      private var var_587:class_1800;
      
      public function MonsterPlantSeedConfirmationView(param1:FurnitureContextMenuWidget)
      {
         super();
         var_16 = param1;
         _windowManager = param1.windowManager;
         _assets = var_16.assets;
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
         var_587 = null;
      }
      
      public function open(param1:int) : void
      {
         var _loc3_:int = var_16.handler.roomSession.roomId;
         var _loc4_:IRoomObject = var_16.handler.roomEngine.getRoomObject(_loc3_,param1,10);
         if(_loc4_ != null)
         {
            var_587 = var_16.handler.getFurniData(_loc4_);
            var_2259 = _loc4_.getId();
         }
         var _loc2_:int = -1;
         switch(var_587.category - 19)
         {
            case 0:
               _loc2_ = 0;
               break;
            default:
               class_21.log("[PlantSeedConfirmationView.open()] Unsupported furniture category: " + var_587.category);
         }
         setWindowContent(_loc2_);
         _window.visible = true;
      }
      
      private function setWindowContent(param1:int) : void
      {
         var _loc4_:String = null;
         var _loc3_:BitmapData = new BitmapData(10,10);
         var_16.localizations.registerParameter("useproduct.widget.title.plant_seed","name",var_587.localizedName);
         if(!_window)
         {
            _loc4_ = "use_product_widget_frame_plant_seed_xml";
            _window = _windowManager.buildFromXML(_assets.getAssetByName(_loc4_).content as XML) as class_1812;
            addClickListener("header_button_close");
            _window.center();
         }
         var_16.localizations.registerParameter("useproduct.widget.text.plant_seed","productName",var_587.localizedName);
         var _loc2_:class_2250 = _window as class_2250;
         _loc2_.content.removeChildAt(0);
         var _loc5_:class_1812 = createWindow(param1);
         _loc2_.content.addChild(_loc5_);
         switch(param1)
         {
            case 0:
               addClickListener("save_button");
               addClickListener("cancel_text");
               _loc3_ = resolvePreviewImage(var_587);
               updatePreviewImage(_loc3_);
               _window.invalidate();
               return;
            default:
               throw new Error("Invalid type for use product confirmation content apply: " + param1);
         }
      }
      
      private function createWindow(param1:int) : class_1812
      {
         var _loc2_:IAsset = null;
         var _loc3_:* = null;
         switch(param1)
         {
            case 0:
               _loc2_ = _assets.getAssetByName("use_product_controller_plant_seed_xml");
               return _windowManager.buildFromXML(_loc2_.content as XML) as class_1812;
            default:
               throw new Error("Invalid type for view content creation: " + param1);
         }
      }
      
      private function resolvePreviewImage(param1:class_1800) : BitmapData
      {
         var _loc3_:class_2198 = null;
         if(!param1)
         {
            return null;
         }
         var _loc2_:Array = param1.customParams.split(" ");
         switch(param1.category - 19)
         {
            case 0:
               _loc3_ = var_16.handler.roomEngine.getFurnitureImage(var_587.id,new Vector3d(90,0,0),64,this,0,"",-1,-1,null);
               break;
            default:
               class_21.log("[PlantSeedConfirmationView] Unsupported furniture category: " + param1.category);
         }
         if(_loc3_ != null)
         {
            var_2911 = _loc3_.id;
            var _loc4_:BitmapData = _loc3_.data;
         }
         return null;
      }
      
      private function updatePreviewImage(param1:BitmapData) : void
      {
         if(!_window || !param1)
         {
            return;
         }
         setPreviewImage("preview_image_bg");
         setPreviewImage("preview_image");
      }
      
      private function setPreviewImage(param1:String) : void
      {
         if(!_window)
         {
            return;
         }
         var _loc2_:class_2251 = _window.findChildByName(param1) as class_2251;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:BitmapDataAsset = _assets.getAssetByName(_loc2_.bitmapAssetName) as BitmapDataAsset;
         if(_loc3_ == null)
         {
            return;
         }
         _loc2_.disposesBitmap = false;
         _loc2_.bitmap = _loc3_.content as BitmapData;
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      private function addClickListener(param1:String) : void
      {
         _window.findChildByName(param1).addEventListener("WME_CLICK",onMouseClick);
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel_text":
            case "ok_button":
               close();
               break;
            case "save_button":
               var _loc2_:RoomWidgetMessage = new RoomWidgetUseProductMessage("RWUPM_MONSTERPLANT_SEED",var_2259);
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
   }
}

