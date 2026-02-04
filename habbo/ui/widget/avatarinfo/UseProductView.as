package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.ui.widget.events.UseProductItem;
   import com.sulake.room.object.IRoomObject;
   
   public class UseProductView extends AvatarContextInfoButtonView
   {
      
      private static const MODE_NORMAL:int = 0;
      
      private static const MODE_SHAMPOO:int = 1;
      
      private static const MODE_CUSTOM_PART:int = 2;
      
      private static const MODE_CUSTOM_PART_SHAMPOO:int = 3;
      
      private static const MODE_SADDLE:int = 4;
      
      private static const MODE_REVIVE:int = 5;
      
      private static const MODE_REBREED:int = 6;
      
      private static const MODE_FERTILIZE:int = 7;
      
      private var var_261:int;
      
      private var var_644:UseProductItem;
      
      public function UseProductView(param1:AvatarInfoWidget)
      {
         super(param1);
         var_236 = false;
      }
      
      public static function setup(param1:UseProductView, param2:int, param3:String, param4:int, param5:int, param6:UseProductItem) : void
      {
         param1.var_644 = param6;
         AvatarContextInfoButtonView.setup(param1,param2,param3,param4,param5,false);
      }
      
      public function get objectId() : int
      {
         return var_644.id;
      }
      
      public function get requestRoomObjectId() : int
      {
         return var_644.requestRoomObjectId;
      }
      
      override public function dispose() : void
      {
         if(_window)
         {
            _window.removeEventListener("WME_OVER",onMouseHoverEvent);
            _window.removeEventListener("WME_OUT",onMouseHoverEvent);
         }
         if(var_644)
         {
            var_644.dispose();
         }
         var_644 = null;
         super.dispose();
      }
      
      private function resolveMode() : void
      {
         var _loc1_:class_1800 = null;
         var _loc2_:int = widget.handler.roomSession.roomId;
         var _loc3_:IRoomObject = widget.handler.roomEngine.getRoomObject(_loc2_,var_644.requestRoomObjectId,10);
         if(_loc3_ != null)
         {
            _loc1_ = widget.handler.getFurniData(_loc3_);
         }
         else
         {
            _loc1_ = widget.handler.container.sessionDataManager.getFloorItemData(var_644.requestRoomObjectId);
         }
         if(!_loc1_)
         {
            return;
         }
         var_261 = 0;
         switch(_loc1_.category - 13)
         {
            case 0:
               var_261 = 1;
               break;
            case 1:
               var_261 = 2;
               break;
            case 2:
               var_261 = 3;
               break;
            case 3:
               var_261 = 4;
               break;
            case 7:
               var_261 = 5;
               break;
            case 8:
               var_261 = 6;
               break;
            case 9:
               var_261 = 7;
               break;
            default:
               class_21.log("[UseProductView.open()] Unsupported furniture category: " + _loc1_.category);
         }
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         if(!var_16 || !var_16.assets || !var_16.windowManager)
         {
            return;
         }
         resolveMode();
         if(var_530)
         {
            activeView = getMinimizedView();
         }
         else
         {
            if(!_window)
            {
               _loc1_ = XmlAsset(var_16.assets.getAssetByName("use_product_menu")).content as XML;
               _window = var_16.windowManager.buildFromXML(_loc1_,0) as class_1812;
               if(!_window)
               {
                  return;
               }
               _window.addEventListener("WME_OVER",onMouseHoverEvent);
               _window.addEventListener("WME_OUT",onMouseHoverEvent);
               _window.findChildByName("minimize").addEventListener("WME_CLICK",onMinimize);
               _window.findChildByName("minimize").addEventListener("WME_OVER",onMinimizeHover);
               _window.findChildByName("minimize").addEventListener("WME_OUT",onMinimizeHover);
            }
            var_34 = _window.findChildByName("buttons") as IItemListWindow;
            var_34.procedure = buttonEventProc;
            _window.findChildByName("name").caption = _userName;
            _window.visible = false;
            activeView = _window;
            updateButtons();
         }
      }
      
      public function updateButtons() : void
      {
         var _loc2_:int = 0;
         if(!_window || !var_34)
         {
            return;
         }
         var_34.autoArrangeItems = false;
         var _loc1_:int = var_34.numListItems;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            var_34.getListItemAt(_loc2_).visible = false;
            _loc2_++;
         }
         switch(var_261)
         {
            case 0:
               showButton("use_product");
               break;
            case 1:
               showButton("use_product_shampoo");
               break;
            case 2:
               showButton("use_product_custom_part");
               break;
            case 3:
               showButton("use_product_custom_part_shampoo");
               break;
            case 4:
               if(var_644.replace)
               {
                  showButton("replace_product_saddle");
                  break;
               }
               showButton("use_product_saddle");
               break;
            case 5:
               showButton("revive_monsterplant");
               break;
            case 6:
               showButton("rebreed_monsterplant");
               break;
            case 7:
               showButton("fertilize_monsterplant");
         }
         var_34.autoArrangeItems = true;
         var_34.visible = true;
      }
      
      override protected function buttonEventProc(param1:class_1758, param2:class_1741) : void
      {
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               _loc3_ = true;
               switch(param2.parent.name)
               {
                  case "use_product":
                  case "use_product_shampoo":
                  case "use_product_custom_part":
                  case "use_product_custom_part_shampoo":
                  case "use_product_saddle":
                  case "replace_product_saddle":
                  case "revive_monsterplant":
                  case "rebreed_monsterplant":
                  case "fertilize_monsterplant":
                     widget.showUseProductConfirmation(var_644.requestRoomObjectId,var_644.targetRoomObjectId,var_644.requestInventoryStripId);
               }
            }
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc3_)
         {
            widget.removeUseProductViews();
         }
      }
      
      private function changeMode(param1:int) : void
      {
         var_261 = param1;
         updateButtons();
      }
      
      private function get widget() : AvatarInfoWidget
      {
         return var_16 as AvatarInfoWidget;
      }
   }
}

