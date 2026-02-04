package com.sulake.habbo.ui.widget.furniture.contextmenu
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.widgets.class_2478;
   import com.sulake.room.object.IRoomObject;
   import package_107.class_2379;
   import package_177.class_3061;
   
   public class PurchasableClothingConfirmationView implements class_13
   {
      
      private static const PRODUCT_PAGE_UKNOWN:int = -1;
      
      private static const PRODUCT_PAGE_CLOTHING:int = 0;
      
      private static const const_202:String = "header_button_close";
      
      private static const const_248:String = "save_button";
      
      private static const const_207:String = "cancel_text";
      
      private static const const_147:String = "ok_button";
      
      private static const const_526:String = "avatar_preview";
      
      private var _window:class_1812;
      
      private var var_1134:Boolean = false;
      
      private var var_16:FurnitureContextMenuWidget;
      
      private var _windowManager:class_38;
      
      private var _assets:class_40;
      
      private var var_2259:int = -1;
      
      private var var_587:class_1800;
      
      private var _newFigureString:String;
      
      public function PurchasableClothingConfirmationView(param1:FurnitureContextMenuWidget)
      {
         super();
         var_16 = param1;
         _windowManager = param1.windowManager;
         _assets = var_16.assets;
      }
      
      public function dispose() : void
      {
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function open(param1:int) : void
      {
         var _loc5_:int = var_16.handler.roomSession.roomId;
         var _loc6_:IRoomObject = var_16.handler.roomEngine.getRoomObject(_loc5_,param1,10);
         if(_loc6_ != null)
         {
            var_587 = var_16.handler.getFurniData(_loc6_);
            var_2259 = _loc6_.getId();
            var _loc3_:int = -1;
            var _loc2_:Vector.<int> = new Vector.<int>(0);
            switch(var_587.category - 23)
            {
               case 0:
                  _loc3_ = 0;
                  var _loc7_:Array = var_587.customParams.split(",");
                  var _loc9_:int = 0;
                  var _loc8_:* = null;
                  while(§§hasnext(_loc8_,_loc9_))
                  {
                     var _loc4_:String = §§nextvalue(_loc9_,_loc8_);
                     if(var_16.handler.container.avatarRenderManager.isValidFigureSetForGender(parseInt(_loc4_),var_16.handler.container.sessionDataManager.gender))
                     {
                        _loc2_.push(parseInt(_loc4_));
                     }
                  }
                  break;
               default:
                  class_21.log("[PurchasableClothingConfirmationView.open()] Unsupported furniture category: " + var_587.category);
            }
            _newFigureString = var_16.handler.container.avatarRenderManager.getFigureStringWithFigureIds(var_16.handler.container.sessionDataManager.figure,var_16.handler.container.sessionDataManager.gender,_loc2_);
            if(var_16.handler.container.inventory.hasBoundFigureSetFurniture(var_587.className))
            {
               var_16.handler.container.connection.send(new class_3061(_newFigureString,var_16.handler.container.sessionDataManager.gender));
            }
            else
            {
               setWindowContent(_loc3_);
               _window.visible = true;
            }
            return;
         }
      }
      
      private function setWindowContent(param1:int) : void
      {
         var _loc3_:String = null;
         var_16.localizations.registerParameter("useproduct.widget.title.bind_clothing","name",var_587.localizedName);
         if(!_window)
         {
            _loc3_ = "use_product_widget_frame_plant_seed_xml";
            _window = _windowManager.buildFromXML(_assets.getAssetByName(_loc3_).content as XML) as class_1812;
            addClickListener("header_button_close");
            _window.center();
         }
         _window.caption = "${useproduct.widget.title.bind_clothing}";
         var_16.localizations.registerParameter("useproduct.widget.text.bind_clothing","productName",var_587.localizedName);
         var _loc2_:class_2250 = _window as class_2250;
         _loc2_.content.removeChildAt(0);
         var _loc4_:class_1812 = createWindow(param1);
         _loc2_.content.addChild(_loc4_);
         switch(param1)
         {
            case 0:
               addClickListener("save_button");
               addClickListener("cancel_text");
               refreshAvatar();
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
               _loc2_ = _assets.getAssetByName("use_product_controller_purchasable_clothing_xml");
               return _windowManager.buildFromXML(_loc2_.content as XML) as class_1812;
            default:
               throw new Error("Invalid type for view content creation: " + param1);
         }
      }
      
      private function refreshAvatar() : void
      {
         var _loc1_:class_2010 = class_2010(_window.findChildByName("avatar_preview"));
         var _loc2_:class_2478 = class_2478(_loc1_.widget);
         _loc2_.figure = _newFigureString;
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
               var_16.handler.container.connection.send(new class_2379(var_2259));
               var_16.handler.container.connection.send(new class_3061(_newFigureString,var_16.handler.container.sessionDataManager.gender));
               close();
         }
      }
   }
}

